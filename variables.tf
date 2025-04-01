variable "team_assume_role_principals" {
  type = list(string)
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_service_cidr" {
  type    = string
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
      addon_version               = "v1.32.0-eksbuild.2"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
      configuration_values        = {}
    }
    coredns = {
      addon_version               = "v1.11.4-eksbuild.2"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
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
      addon_version               = "v1.19.2-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
      configuration_values        = {}
    }
    aws-ebs-csi-driver = {
      addon_version               = "v1.35.0-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
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
      service_account_role_arn    = false
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
      addon_version               = "v3.5.0-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
      configuration_values        = {}
    }
    eks-node-monitoring-agent = {
      addon_version               = "v1.1.0-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
      configuration_values        = {}
    }
    cert-manager = {
      addon_version               = "v1.17.1-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
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
    kube-state-metrics = {
      addon_version               = "v2.14.0-eksbuild.1"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
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
    metrics-server = {
      addon_version               = "v0.7.2-eksbuild.2"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
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
    prometheus-node-exporter = {
      addon_version               = "v1.8.2-eksbuild.2"
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      service_account_role_arn    = false
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

variable "helm_charts" {
  type = any
  default = {
    cluster-autoscaler = {
      repository    = "https://kubernetes.github.io/autoscaler"
      version       = "9.43.0"
      namespace     = "cluster-autoscaler"
      chart         = "cluster-autoscaler"
      template_file = "helm_values/cluster-autoscaler.tpl"
    }
    aws-load-balancer-controller = {
      repository    = "https://aws.github.io/eks-charts"
      version       = "1.8.1"
      namespace     = "aws-load-balancer-controller"
      chart         = "aws-load-balancer-controller"
      template_file = "helm_values/aws-load-balancer-controller.tpl"
    }
    external-secrets = {
      repository    = "https://charts.external-secrets.io"
      version       = "0.10.4"
      namespace     = "external-secrets"
      chart         = "external-secrets"
      template_file = "helm_values/external-secrets.tpl"
    }
    argo-cd = {
      repository    = "https://argoproj.github.io/argo-helm"
      version       = "7.6.12"
      namespace     = "argo-cd"
      chart         = "argo-cd"
      template_file = "helm_values/argo-cd.tpl"
    }
    external-dns = {
      repository    = "https://kubernetes-sigs.github.io/external-dns"
      version       = "1.15.0"
      namespace     = "external-dns"
      chart         = "external-dns"
      template_file = "./helm_values/external-dns.tpl"
    }
  }
}

variable "domain" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "certificate_arn" {
  type = string
}