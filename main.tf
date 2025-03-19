###
### iam
###

resource "aws_iam_role" "team" {
  name               = format("%s-nc-workshop", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.team_assume_role.json
}

resource "aws_iam_role" "control_plane" {
  name               = format("%s-eks-control-plane", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.control_plane_assume_role.json
}

resource "aws_iam_role" "node_group" {
  name               = format("%s-eks-node-group", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.node_group_assume_role.json
}

resource "aws_iam_role_policy_attachment" "team" {
  role       = aws_iam_role.team.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "control_plane" {
  for_each = {
    control_plane_eks_cluster_policy          = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    control_plane_eks_vpc_resource_controller = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  }
  policy_arn = each.value
  role       = aws_iam_role.control_plane.name
}

resource "aws_iam_role_policy_attachment" "node_group" {
  for_each = {
    node_group_ssm_managed_instance_core        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    node_group_eks_cni_policy                   = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    node_group_eks_worker_node_policy           = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    node_group_ec2_container_registry_read_only = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    node_group_ebs_csi_driver_policy            = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    node_group_efs_csi_driver_policy            = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
    node_group_cloudwatch_agent_server_policy   = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  }
  policy_arn = each.value
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_instance_profile" "node_group" {
  name = format("%s-eks-node-group", var.cluster_name)
  role = aws_iam_role.node_group.name

  lifecycle {
    create_before_destroy = true
  }
}

###
### eks control plane
###

resource "aws_security_group" "control_plane" {
  name        = format("%s-eks-control-plane", var.cluster_name)
  description = "eks control plan security group"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "control_plane_allow_all" {
  security_group_id = aws_security_group.control_plane.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "allow all outbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "control_plane_allow_node_group_api" {
  security_group_id            = aws_security_group.control_plane.id
  referenced_security_group_id = aws_security_group.node_group.id
  ip_protocol                  = "tcp"
  from_port                    = 443
  to_port                      = 443
  description                  = "allow inbound https traffic (port 443) for the api server"
}

resource "aws_security_group" "node_group" {
  name        = format("%s-eks-node-group", var.cluster_name)
  description = "eks node group security group"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "node_group_allow_all" {
  security_group_id = aws_security_group.node_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "allow all outbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "node_group_allow_control_plane_kubelet" {
  security_group_id            = aws_security_group.node_group.id
  referenced_security_group_id = aws_security_group.control_plane.id
  ip_protocol                  = "tcp"
  from_port                    = 1025
  to_port                      = 65535
  description                  = "allow inbound traffic from the control plane"
}

resource "aws_vpc_security_group_ingress_rule" "node_group_allow_itself" {
  security_group_id            = aws_security_group.node_group.id
  referenced_security_group_id = aws_security_group.control_plane.id
  cidr_ipv4                    = "0.0.0.0/0"
  ip_protocol                  = "-1"
  description                  = "allow all traffic within the node group"
}

resource "aws_eks_cluster" "this" {
  depends_on = [
    aws_iam_role_policy_attachment.control_plane
  ]

  name                      = var.cluster_name
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  role_arn                  = aws_iam_role.control_plane.arn
  version                   = var.cluster_version

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_cidr
  }

  vpc_config {
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_public_access_cidrs
    subnet_ids              = var.vpc_private_subnet_ids
    security_group_ids      = [aws_security_group.control_plane.id]
  }
}

#resource "kubectl_manifest" "aws_auth_cm" {
#  yaml_body = yamlencode(local.aws_auth_cm)
#}

resource "aws_eks_addon" "this" {
  for_each                    = var.cluster_addons
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = each.key
  addon_version               = each.value.addon_version
  resolve_conflicts_on_create = each.value.resolve_conflicts_on_create

  resolve_conflicts_on_update = each.value.resolve_conflicts_on_update
  configuration_values        = jsonencode(each.value["configuration_values"])
}

resource "aws_ec2_tag" "cluster" {
  for_each    = toset(concat(var.vpc_public_subnet_ids, var.vpc_private_subnet_ids))
  resource_id = each.value
  key         = format("kubernetes.io/cluster/%s", aws_eks_cluster.this.id)
  value       = "shared"
}

resource "aws_ec2_tag" "public_subnets" {
  for_each    = toset(var.vpc_public_subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

resource "aws_ec2_tag" "private_subnets" {
  for_each    = toset(var.vpc_private_subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}

###
### eks node group
###

resource "aws_launch_template" "this" {
  depends_on = [aws_iam_role_policy_attachment.node_group]
  for_each   = var.cluster_managed_node_groups

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      volume_size           = each.value.volume_size
      volume_type           = "gp3"
    }
  }

  # Set on EKS managed node group, will fail if set here
  # https://docs.aws.amazon.com/eks/latest/userguide/launch-templates.html#launch-template-basics
  # iam_instance_profile {
  #   arn = aws_iam_instance_profile.eks_node_group.arn
  # }
  image_id      = data.aws_ami.this.image_id
  instance_type = each.value.instance_type

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }
  monitoring {
    enabled = false
  }
  name = format("%s-%s-eks-node-group", var.cluster_name, each.key)
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.node_group.id]
  }
  dynamic "tag_specifications" {
    for_each = toset(["instance", "volume", "network-interface"])

    content {
      resource_type = tag_specifications.key
      tags          = merge({ Name = format("%s-%s", var.cluster_name, each.key) }, data.aws_default_tags.this.tags)
    }
  }
  update_default_version = true
  user_data              = data.cloudinit_config.eks_group[each.key].rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eks_node_group" "this" {
  depends_on      = [aws_iam_role_policy_attachment.node_group]
  for_each        = var.cluster_managed_node_groups
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.vpc_private_subnet_ids
  capacity_type   = each.value.capacity_type

  dynamic "taint" {
    for_each = each.value.taints
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }
  labels = each.value.labels

  launch_template {
    id      = aws_launch_template.this[each.key].id
    version = aws_launch_template.this[each.key].latest_version
  }

  scaling_config {
    desired_size = each.value.desired_capacity
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}