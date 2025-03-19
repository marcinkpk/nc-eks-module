locals {
  map_roles = concat(
    # user roles
    flatten([
      for permission_set, config in var.cluster_map_roles : {
        name     = permission_set
        rolearn  = aws_iam_role.team.arn
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