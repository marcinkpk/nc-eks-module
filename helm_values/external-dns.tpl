# https://github.com/kubernetes-sigs/external-dns/blob/master/charts/external-dns/values.yaml

nodeSelector:
  nodePurpose: system
tolerations:
  - key: nodePurpose
    operator: Equal
    value: system
    effect: NoSchedule
  - key: criticalAddonsOnly
    operator: Exists
    effect: NoSchedule

serviceAccount:
  name: external-dns
  annotations:
    eks.amazonaws.com/role-arn: ${external_dns_role_arn}

domainFilters:
%{for domain in external_dns_domains ~}
  - ${domain}
%{ endfor ~}

provider:
  name: aws
env:
  - name: AWS_DEFAULT_REGIOJN
    value: ${aws_region}

policy: sync