# https://github.com/kubernetes-sigs/aws-load-balancer-controller/blob/main/helm/aws-load-balancer-controller/values.yaml

clusterName: ${cluster_name}

# see https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
image:
  repository: "602401143452.dkr.ecr.${aws_region}.amazonaws.com/amazon/aws-load-balancer-controller"
resources:
  limits:
    cpu: 50m
    memory: 128Mi
serviceAccount:
  name: aws-load-balancer-controller
  annotations:
    eks.amazonaws.com/role-arn: ${aws_load_balancer_controller_role_arn}
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
enableWaf: false
enableWafv2: false
enableShield: false