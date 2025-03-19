variable "team_assume_role_principals" {
  type = list(string)
  default = []
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_service_cidr" {
  type = string
  default = "172.20.0.0/16"
}

variable "cluster_endpoint_private_access" {
  type    = bool
  default = true
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = false
}

variable "cluster_public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "vpc_id" {
  type = string
}

variable "vpc_public_subnet_ids" {
  type = list(string)
}

variable "vpc_private_subnet_ids" {
  type = list(string)
}

variable "cluster_map_roles" {
  type = map(object({
    username = string
    groups   = list(string)
  }))
  default = {
    AdministratorAccess = {
      username = "admin:{{SessionName}}"
      groups   = ["system:masters"]
    }
    ReadOnlyAccess = {
      username = "ro:{{SessionName}}"
      groups   = ["system:authenticated"]
    }
  }
}

variable "cluster_addons" {
  type = any
  default = {
    kube-proxy = {
      addon_version               = "v1.30.3-eksbuild.9"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      configuration_values        = {}
    }
    coredns = {
      addon_version               = "v1.11.3-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      configuration_values = {
        nodeSelector = {
          nodePurpose = "system"
        }
        tolerations = [
          {
            effect   = "NoSchedule"
            key      = "nodePurpose"
            operator = "Equal"
            value    = "system"
          },
          {
            effect   = "NoSchedule"
            key      = "criticalAddonsOnly"
            operator = "Equal"
            value    = "true"
          }
        ]
      }
    }
    vpc-cni = {
      addon_version               = "v1.18.3-eksbuild.3"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      configuration_values        = {}
    }
    aws-ebs-csi-driver = {
      addon_version               = "v1.35.0-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      configuration_values = {
        controller = {
          nodeSelector = {
            nodePurpose = "system"
          }
          tolerations = [
            {
              effect   = "NoSchedule"
              key      = "nodePurpose"
              operator = "Equal"
              value    = "system"
            },
            {
              effect   = "NoSchedule"
              key      = "criticalAddonsOnly"
              operator = "Equal"
              value    = "true"
            }
          ]
        }
      }
    }
    aws-efs-csi-driver = {
      addon_version               = "v2.0.9-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      configuration_values = {
        controller = {
          nodeSelector = {
            nodePurpose = "system"
          }
          tolerations = [
            {
              effect   = "NoSchedule"
              key      = "nodePurpose"
              operator = "Equal"
              value    = "system"
            },
            {
              effect   = "NoSchedule"
              key      = "criticalAddonsOnly"
              operator = "Equal"
              value    = "true"
            }
          ]
        }
      }
    }
    amazon-cloudwatch-observability = {
      addon_version               = "v2.1.2-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      configuration_values        = {}
    }
  }
}

variable "cluster_managed_node_groups" {
  type = any
  default = {
    system-01 = {
      min_size         = 1
      desired_capacity = 1
      max_size         = 5
      volume_size      = 100
      instance_type    = "t3.medium"
      capacity_type    = "ON_DEMAND"
      taints = {
        nodePurpose = {
          key    = "nodePurpose"
          value  = "system"
          effect = "NO_SCHEDULE"
        }
        criticalAddonsOnly = {
          key    = "criticalAddonsOnly"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      }
      labels = {
        capacityType  = "onDemand"
        nodePurpose   = "system",
        nodeGroupType = "managed"
        nodeGroup     = "system-01"
      }
      kubelet_flags = ""
    }
    generic-01 = {
      min_size         = 1
      desired_capacity = 1
      max_size         = 5
      volume_size      = 100
      instance_type    = "t3.medium"
      capacity_type    = "ON_DEMAND"
      taints           = {}
      labels = {
        capacityType  = "onDemand"
        nodePurpose   = "generic",
        nodeGroupType = "managed"
        nodeGroup     = "generic-01"
      }
      kubelet_flags = ""
    }
  }
}