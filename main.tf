###
### iam
###

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.this.certificates[*].sha1_fingerprint
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "control_plane" {
  name               = format("%s-eks-control-plane", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.control_plane_assume_role.json
}

resource "aws_iam_role" "node_group" {
  name               = format("%s-eks-node-group", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.node_group_assume_role.json
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


resource "aws_iam_policy" "cluster_autoscaler" {
  name   = format("%s-eks-cluster-autoscaler", var.cluster_name)
  policy = data.aws_iam_policy_document.cluster_autoscaler.json
}

resource "aws_iam_role" "cluster_autoscaler" {
  name               = format("%s-eks-cluster-autoscaler", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.cluster_autoscaler_assume_role.json
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  policy_arn = aws_iam_policy.cluster_autoscaler.arn
  role       = aws_iam_role.cluster_autoscaler.name
}

resource "aws_iam_policy" "aws_load_balancer_controller" {
  name_prefix = format("%s-eks-aws-load-balancer-controller", var.cluster_name)
  policy      = data.aws_iam_policy_document.aws_load_balancer_controller.json
}

resource "aws_iam_role" "aws_load_balancer_controller" {
  name               = format("%s-eks-aws-load-balancer-controller", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume_role.json
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller" {
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
  role       = aws_iam_role.aws_load_balancer_controller.name
}

resource "aws_iam_policy" "external_secrets" {
  name_prefix = format("%s-eks-external-secrets", var.cluster_name)
  policy      = data.aws_iam_policy_document.external_secrets.json
}

resource "aws_iam_role" "external_secrets" {
  name               = format("%s-eks-external-secrets", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.external_secrets_assume_role.json
}

resource "aws_iam_role_policy_attachment" "external_secrets" {
  policy_arn = aws_iam_policy.external_secrets.arn
  role       = aws_iam_role.external_secrets.name
}

resource "aws_iam_policy" "external_dns" {
  name_prefix = format("%s-eks-external-dns", var.cluster_name)
  policy      = data.aws_iam_policy_document.external_dns.json
}

resource "aws_iam_role" "external_dns" {
  name               = format("%s-eks-external-dns", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role.json
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  policy_arn = aws_iam_policy.external_dns.arn
  role       = aws_iam_role.external_dns.name
}

resource "aws_iam_policy" "gateway_api_controller" {
  name_prefix = format("%s-eks-gateway-api-controller", var.cluster_name)
  policy      = data.aws_iam_policy_document.gateway_api_controller.json
}

resource "aws_iam_role" "gateway_api_controller" {
  name               = format("%s-eks-gateway-api-controller", var.cluster_name)
  assume_role_policy = data.aws_iam_policy_document.gateway_api_controller_assume_role.json
}

resource "aws_iam_role_policy_attachment" "gateway_api_controller" {
  policy_arn = aws_iam_policy.gateway_api_controller.arn
  role       = aws_iam_role.gateway_api_controller.name
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
  referenced_security_group_id = aws_security_group.node_group.id
  ip_protocol                  = "-1"
  description                  = "allow all traffic within the node group"
}

resource "aws_vpc_security_group_ingress_rule" "node_group_allow_vpc_lattice_ipv4" {
  security_group_id = aws_security_group.node_group.id
  ip_protocol       = "-1"
  prefix_list_id    = data.aws_ec2_managed_prefix_list.vpc_lattice_ipv4.id
  description       = "allow vpc lattice (ipv4)"
}

resource "aws_vpc_security_group_ingress_rule" "node_group_allow_vpc_lattice_ipv6" {
  security_group_id = aws_security_group.node_group.id
  ip_protocol       = "-1"
  prefix_list_id    = data.aws_ec2_managed_prefix_list.vpc_lattice_ipv6.id
  description       = "allow vpc lattice (ipv6)"
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

resource "kubectl_manifest" "aws_auth_cm" {
  yaml_body = yamlencode(local.aws_auth_cm)
}

resource "aws_eks_addon" "this" {
  for_each                    = var.cluster_addons
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = each.key
  addon_version               = each.value.addon_version
  resolve_conflicts_on_create = each.value.resolve_conflicts_on_create
  resolve_conflicts_on_update = each.value.resolve_conflicts_on_update
  service_account_role_arn    = each.value.service_account_role_arn ? format("arn:aws:iam::%s:role/%s-eks-%s", data.aws_caller_identity.this.account_id, var.cluster_name, each.key) : null
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

resource "helm_release" "this" {
  depends_on = [
    aws_iam_role.aws_load_balancer_controller,
    aws_iam_role.external_secrets,
    aws_iam_role.cluster_autoscaler,
    aws_iam_role.gateway_api_controller
  ]
  for_each         = var.helm_charts
  name             = try(each.value["name"], each.key)
  namespace        = try(each.value["namespace"], "default")
  create_namespace = true
  chart            = try(each.value["chart"], each.key)
  repository       = try(each.value["repository"], null)
  version          = try(each.value["version"], ">0.0.0")
  timeout          = 120

  values = [templatefile(format("%s/%s", path.module, var.helm_charts[each.key]["template_file"]), {
    aws_region                            = data.aws_region.this.name
    cluster_name                          = aws_eks_cluster.this.id
    cluster_autoscaler_role_arn           = aws_iam_role.cluster_autoscaler.arn
    aws_load_balancer_controller_role_arn = aws_iam_role.aws_load_balancer_controller.arn
    gateway_api_controller_role_arn       = aws_iam_role.gateway_api_controller.arn
    external_secrets_role_arn             = aws_iam_role.external_secrets.arn
    external_dns_role_arn                 = aws_iam_role.external_dns.arn
    external_dns_domains                  = [var.domain]
    acm_arn                               = var.certificate_arn
    argocd_hostname                       = format("argocd.%s", var.domain)
    argocd_lb_name                        = var.cluster_name
    acm_arn                               = var.certificate_arn
  })]
}