# https://github.com/aws/aws-application-networking-k8s/blob/main/helm/values.yaml

serviceAccount:
  name: gateway-api-controller
  annotations:
    eks.amazonaws.com/role-arn: ${gateway_api_controller_role_arn}

deployment:
    tolerations:
      - effect: NoSchedule
        key: nodePurpose
        operator: Equal
        value: system
      - effect: NoSchedule
        key: criticalAddonsOnly
        operator: Exists
    nodeSelector:
      nodePurpose: system
    priorityClassName: system-cluster-critical

defaultServiceNetwork: client-server-gateway