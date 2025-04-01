# https://github.com/argoproj/argo-helm/blob/master/charts/argo-cd/values.yaml

applicationSet:
  enabled: true

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

  resources:
    requests:
      cpu: 200m
      memory: 500Mi

  ingress:
    enabled: true
    controller: aws
    hostname: appset.${argocd_hostname}
    ingressClassName: alb
    annotations:
      alb.ingress.kubernetes.io/load-balancer-name: ${argocd_lb_name}
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/target-type: ip
      alb.ingress.kubernetes.io/backend-protocol: HTTPS
      alb.ingress.kubernetes.io/conditions.argogrpc: |
        [{"field":"http-header","httpHeaderConfig":{"httpHeaderName": "Content-Type", "values":["application/grpc"]}}]
      alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}]'
      alb.ingress.kubernetes.io/certificate-arn: ${acm_arn}
      alb.ingress.kubernetes.io/group.name: ${argocd_lb_name}

service:
  type: ClusterIP

global:
  domain: ${argocd_hostname}

  logging:
    level: warn

server:
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

  resources:
    requests:
      cpu: 200m
      memory: 500Mi

  extraArgs:
    - --enable-gzip

  ingress:
    enabled: true
    controller: aws
    hostname: ${argocd_hostname}
    ingressClassName: alb
    annotations:
      alb.ingress.kubernetes.io/load-balancer-name: ${argocd_lb_name}
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/target-type: ip
      alb.ingress.kubernetes.io/backend-protocol: HTTPS
      alb.ingress.kubernetes.io/conditions.argogrpc: |
        [{"field":"http-header","httpHeaderConfig":{"httpHeaderName": "Content-Type", "values":["application/grpc"]}}]
      alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}]'
      alb.ingress.kubernetes.io/certificate-arn: ${acm_arn}
      alb.ingress.kubernetes.io/group.name: ${argocd_lb_name}
      external-dns.alpha.kubernetes.io/hostname: ${argocd_hostname}


controller:
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

  resources:
    requests:
      cpu: 200m
      memory: 500Mi

dex:
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

  resources:
    requests:
      cpu: 200m
      memory: 500Mi


# disable redis in favor of redis-ha
redis:
  enabled: true

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

  resources:
    requests:
      cpu: 200m
      memory: 500Mi

# deploy redis HA
redis-ha:
  enabled: false


repoServer:
  autoscaling:
    enabled: true

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

  resources:
    requests:
      cpu: 500m
      memory: 500Mi

notifications:
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

  resources:
    requests:
      cpu: 500m
      memory: 500Mi