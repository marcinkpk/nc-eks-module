# https://github.com/external-secrets/external-secrets/blob/main/deploy/charts/external-secrets/values.yaml

global:
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
  resources:
    requests:
      cpu: 500m
      memory: 500Mi
serviceAccount:
  name: external-secrets
  annotations:
    eks.amazonaws.com/role-arn: ${external_secrets_role_arn}