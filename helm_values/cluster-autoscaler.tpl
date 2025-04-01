# https://github.com/kubernetes/autoscaler/blob/master/charts/cluster-autoscaler/values.yaml

awsRegion: ${aws_region}
rbac:
  create: true
  serviceAccount:
    name: cluster-autoscaler
    annotations:
      eks.amazonaws.com/role-arn: "${cluster_autoscaler_role_arn}"
autoDiscovery:
  clusterName: ${cluster_name}
  enabled: true
cloudConfigPath: null
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
extraArgs:
  max-node-provision-time: 5m0s
  scan-interval: 30s
  cordon-node-before-terminating: true
  skip-nodes-with-system-pods: false
  balance-similar-node-groups: true
  scale-down-unneeded-time: 1m
  scale-down-utilization-threshold: 0.5
  expander: least-waste