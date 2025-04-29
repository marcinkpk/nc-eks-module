<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.11.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.91.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | ~> 2.3.6 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.17.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 1.19.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.91.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | ~> 2.3.6 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.17.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | ~> 1.19.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_tag.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_eks_addon.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_instance_profile.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.external_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.gateway_api_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.control_plane](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.external_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.gateway_api_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.control_plane](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.external_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.gateway_api_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.control_plane](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.control_plane_allow_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.node_group_allow_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.control_plane_allow_node_group_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.node_group_allow_control_plane_kubelet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.node_group_allow_itself](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.node_group_allow_vpc_lattice_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.node_group_allow_vpc_lattice_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.aws_auth_cm](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_ec2_managed_prefix_list.vpc_lattice_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_ec2_managed_prefix_list.vpc_lattice_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_iam_policy_document.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_load_balancer_controller_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.control_plane_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_dns_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_secrets_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.gateway_api_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.gateway_api_controller_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.node_group_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [cloudinit_config.eks_group](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `string` | n/a | yes |
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | n/a | `any` | <pre>{<br/>  "amazon-cloudwatch-observability": {<br/>    "addon_version": "v3.5.0-eksbuild.1",<br/>    "configuration_values": {},<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "aws-ebs-csi-driver": {<br/>    "addon_version": "v1.35.0-eksbuild.1",<br/>    "configuration_values": {<br/>      "controller": {<br/>        "nodeSelector": {<br/>          "nodePurpose": "system"<br/>        },<br/>        "tolerations": [<br/>          {<br/>            "effect": "NoSchedule",<br/>            "key": "nodePurpose",<br/>            "operator": "Equal",<br/>            "value": "system"<br/>          },<br/>          {<br/>            "effect": "NoSchedule",<br/>            "key": "criticalAddonsOnly",<br/>            "operator": "Equal",<br/>            "value": "true"<br/>          }<br/>        ]<br/>      }<br/>    },<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "aws-efs-csi-driver": {<br/>    "addon_version": "v2.0.9-eksbuild.1",<br/>    "configuration_values": {<br/>      "controller": {<br/>        "nodeSelector": {<br/>          "nodePurpose": "system"<br/>        },<br/>        "tolerations": [<br/>          {<br/>            "effect": "NoSchedule",<br/>            "key": "nodePurpose",<br/>            "operator": "Equal",<br/>            "value": "system"<br/>          },<br/>          {<br/>            "effect": "NoSchedule",<br/>            "key": "criticalAddonsOnly",<br/>            "operator": "Equal",<br/>            "value": "true"<br/>          }<br/>        ]<br/>      }<br/>    },<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "cert-manager": {<br/>    "addon_version": "v1.17.1-eksbuild.1",<br/>    "configuration_values": {<br/>      "nodeSelector": {<br/>        "nodePurpose": "system"<br/>      },<br/>      "tolerations": [<br/>        {<br/>          "effect": "NoSchedule",<br/>          "key": "nodePurpose",<br/>          "operator": "Equal",<br/>          "value": "system"<br/>        },<br/>        {<br/>          "effect": "NoSchedule",<br/>          "key": "criticalAddonsOnly",<br/>          "operator": "Equal",<br/>          "value": "true"<br/>        }<br/>      ]<br/>    },<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "coredns": {<br/>    "addon_version": "v1.11.4-eksbuild.2",<br/>    "configuration_values": {<br/>      "nodeSelector": {<br/>        "nodePurpose": "system"<br/>      },<br/>      "tolerations": [<br/>        {<br/>          "effect": "NoSchedule",<br/>          "key": "nodePurpose",<br/>          "operator": "Equal",<br/>          "value": "system"<br/>        },<br/>        {<br/>          "effect": "NoSchedule",<br/>          "key": "criticalAddonsOnly",<br/>          "operator": "Equal",<br/>          "value": "true"<br/>        }<br/>      ]<br/>    },<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "eks-node-monitoring-agent": {<br/>    "addon_version": "v1.1.0-eksbuild.1",<br/>    "configuration_values": {},<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "kube-proxy": {<br/>    "addon_version": "v1.32.0-eksbuild.2",<br/>    "configuration_values": {},<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "kube-state-metrics": {<br/>    "addon_version": "v2.14.0-eksbuild.1",<br/>    "configuration_values": {<br/>      "nodeSelector": {<br/>        "nodePurpose": "system"<br/>      },<br/>      "tolerations": [<br/>        {<br/>          "effect": "NoSchedule",<br/>          "key": "nodePurpose",<br/>          "operator": "Equal",<br/>          "value": "system"<br/>        },<br/>        {<br/>          "effect": "NoSchedule",<br/>          "key": "criticalAddonsOnly",<br/>          "operator": "Equal",<br/>          "value": "true"<br/>        }<br/>      ]<br/>    },<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "metrics-server": {<br/>    "addon_version": "v0.7.2-eksbuild.2",<br/>    "configuration_values": {<br/>      "nodeSelector": {<br/>        "nodePurpose": "system"<br/>      },<br/>      "tolerations": [<br/>        {<br/>          "effect": "NoSchedule",<br/>          "key": "nodePurpose",<br/>          "operator": "Equal",<br/>          "value": "system"<br/>        },<br/>        {<br/>          "effect": "NoSchedule",<br/>          "key": "criticalAddonsOnly",<br/>          "operator": "Equal",<br/>          "value": "true"<br/>        }<br/>      ]<br/>    },<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "prometheus-node-exporter": {<br/>    "addon_version": "v1.8.2-eksbuild.2",<br/>    "configuration_values": {},<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  },<br/>  "vpc-cni": {<br/>    "addon_version": "v1.19.2-eksbuild.1",<br/>    "configuration_values": {},<br/>    "resolve_conflicts_on_create": "OVERWRITE",<br/>    "resolve_conflicts_on_update": "OVERWRITE",<br/>    "service_account_role_arn": false<br/>  }<br/>}</pre> | no |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | n/a | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | n/a | `bool` | `false` | no |
| <a name="input_cluster_managed_node_groups"></a> [cluster\_managed\_node\_groups](#input\_cluster\_managed\_node\_groups) | n/a | `any` | <pre>{<br/>  "generic-01": {<br/>    "capacity_type": "ON_DEMAND",<br/>    "desired_capacity": 1,<br/>    "instance_type": "t3.medium",<br/>    "kubelet_flags": "",<br/>    "labels": {<br/>      "capacityType": "onDemand",<br/>      "nodeGroup": "generic-01",<br/>      "nodeGroupType": "managed",<br/>      "nodePurpose": "generic"<br/>    },<br/>    "max_size": 5,<br/>    "min_size": 1,<br/>    "taints": {},<br/>    "volume_size": 100<br/>  },<br/>  "system-01": {<br/>    "capacity_type": "ON_DEMAND",<br/>    "desired_capacity": 1,<br/>    "instance_type": "t3.medium",<br/>    "kubelet_flags": "",<br/>    "labels": {<br/>      "capacityType": "onDemand",<br/>      "nodeGroup": "system-01",<br/>      "nodeGroupType": "managed",<br/>      "nodePurpose": "system"<br/>    },<br/>    "max_size": 5,<br/>    "min_size": 1,<br/>    "taints": {<br/>      "criticalAddonsOnly": {<br/>        "effect": "NO_SCHEDULE",<br/>        "key": "criticalAddonsOnly",<br/>        "value": "true"<br/>      },<br/>      "nodePurpose": {<br/>        "effect": "NO_SCHEDULE",<br/>        "key": "nodePurpose",<br/>        "value": "system"<br/>      }<br/>    },<br/>    "volume_size": 100<br/>  }<br/>}</pre> | no |
| <a name="input_cluster_map_roles"></a> [cluster\_map\_roles](#input\_cluster\_map\_roles) | n/a | <pre>map(object({<br/>    username = string<br/>    groups   = list(string)<br/>  }))</pre> | <pre>{<br/>  "AdministratorAccess": {<br/>    "groups": [<br/>      "system:masters"<br/>    ],<br/>    "username": "admin:{{SessionName}}"<br/>  },<br/>  "ReadOnlyAccess": {<br/>    "groups": [<br/>      "system:authenticated"<br/>    ],<br/>    "username": "ro:{{SessionName}}"<br/>  }<br/>}</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_cluster_public_access_cidrs"></a> [cluster\_public\_access\_cidrs](#input\_cluster\_public\_access\_cidrs) | n/a | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_cluster_service_cidr"></a> [cluster\_service\_cidr](#input\_cluster\_service\_cidr) | n/a | `string` | `"172.20.0.0/16"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | n/a | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_helm_charts"></a> [helm\_charts](#input\_helm\_charts) | n/a | `any` | <pre>{<br/>  "argo-cd": {<br/>    "chart": "argo-cd",<br/>    "namespace": "argo-cd",<br/>    "repository": "https://argoproj.github.io/argo-helm",<br/>    "template_file": "helm_values/argo-cd.tpl",<br/>    "version": "7.6.12"<br/>  },<br/>  "aws-load-balancer-controller": {<br/>    "chart": "aws-load-balancer-controller",<br/>    "namespace": "aws-load-balancer-controller",<br/>    "repository": "https://aws.github.io/eks-charts",<br/>    "template_file": "helm_values/aws-load-balancer-controller.tpl",<br/>    "version": "1.8.1"<br/>  },<br/>  "cluster-autoscaler": {<br/>    "chart": "cluster-autoscaler",<br/>    "namespace": "cluster-autoscaler",<br/>    "repository": "https://kubernetes.github.io/autoscaler",<br/>    "template_file": "helm_values/cluster-autoscaler.tpl",<br/>    "version": "9.43.0"<br/>  },<br/>  "external-dns": {<br/>    "chart": "external-dns",<br/>    "namespace": "external-dns",<br/>    "repository": "https://kubernetes-sigs.github.io/external-dns",<br/>    "template_file": "./helm_values/external-dns.tpl",<br/>    "version": "1.15.0"<br/>  },<br/>  "external-secrets": {<br/>    "chart": "external-secrets",<br/>    "namespace": "external-secrets",<br/>    "repository": "https://charts.external-secrets.io",<br/>    "template_file": "helm_values/external-secrets.tpl",<br/>    "version": "0.10.4"<br/>  },<br/>  "gateway-api-controller": {<br/>    "chart": "aws-gateway-controller-chart",<br/>    "namespace": "aws-application-networking-system",<br/>    "repository": "oci://public.ecr.aws/aws-application-networking-k8s",<br/>    "template_file": "helm_values/gateway-api-controller.tpl",<br/>    "version": "v1.1.0"<br/>  }<br/>}</pre> | no |
| <a name="input_team_role_arn"></a> [team\_role\_arn](#input\_team\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |
| <a name="input_vpc_private_subnet_ids"></a> [vpc\_private\_subnet\_ids](#input\_vpc\_private\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_vpc_public_subnet_ids"></a> [vpc\_public\_subnet\_ids](#input\_vpc\_public\_subnet\_ids) | n/a | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->