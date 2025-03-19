data "aws_region" "this" {}

data "aws_default_tags" "this" {}

data "aws_iam_roles" "sso" {
  for_each    = var.cluster_map_roles
  name_regex  = format("AWSReservedSSO_%s_.*", each.key)
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = [format("amazon-eks-node-al2023-x86_64-standard-%s-v*", var.cluster_version)]
  }
}

data "cloudinit_config" "eks_group" {
  for_each      = var.cluster_managed_node_groups
  base64_encode = true
  gzip          = false
  boundary      = "//"

  part {
    content_type = "application/node.eks.aws"
    content = templatefile("${path.module}/user_data.tpl", {
      cluster_name         = aws_eks_cluster.this.name
      cluster_endpoint     = aws_eks_cluster.this.endpoint
      cluster_auth_base64  = aws_eks_cluster.this.certificate_authority[0].data
      cluster_service_cidr = var.cluster_service_cidr
      kubelet_flags        = each.value.kubelet_flags
    })
  }
}

data "aws_iam_policy_document" "team_assume_role" {
  statement {
    sid    = "TeamAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = var.team_assume_role_principals
    }
  }
}


data "aws_iam_policy_document" "control_plane_assume_role" {
  statement {
    sid    = "EKSControlPlaneAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "eks.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "node_group_assume_role" {
  statement {
    sid    = "EKSNodeGroupAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}
