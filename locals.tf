locals {
  map_roles = concat(
    flatten([
      for permission_set, config in var.cluster_map_roles : {
        name     = permission_set
        rolearn  = "arn:aws:iam::038492037104:root"
        username = config.username
        groups   = config.groups
      }
    ]),
    # user roles
    flatten([
      for permission_set, config in var.cluster_map_roles : {
        name     = permission_set
        rolearn  = var.team_role_arn
        username = config.username
        groups   = config.groups
      }
    ]),
    # node roles
    flatten([
      {
        username = "system:node:{{EC2PrivateDNSName}}"
        rolearn  = aws_iam_role.node_group.arn
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])
  )

  aws_auth_cm = {
    apiVersion = "v1"
    kind       = "ConfigMap"
    metadata = {
      name      = "aws-auth"
      namespace = "kube-system"
    }
    data = {
      mapRoles = yamlencode(local.map_roles)
    }
  }
}