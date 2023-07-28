#!/bin/bash
set -e

helm repo add teamcity-charts https://nefelim4ag.github.io/teamcity-charts/

kubectl create namespace teamcity --dry-run=client -o yaml | kubectl apply -f -



helm upgrade teamcity teamcity-charts/teamcity-server -n teamcity -i  \
  --set proxy.replicas=1                                        \
  --set pvc.storageClassName="local-path"                       \
  --set pvc.accessModes[0]="ReadWriteOnce"                      \
  --set pvc.resources.requests.storage=10Gi                     \
  --set ephemeral.temp.storageClassName="local-path"            \
  --set ephemeral.logs.storageClassName="local-path"            \
  --set ephemeral.cache.storageClassName="local-path"           \
  --set ephemeral.temp.accessModes[0]="ReadWriteOnce"           \
  --set ephemeral.logs.accessModes[0]="ReadWriteOnce"           \
  --set ephemeral.cache.accessModes[0]="ReadWriteOnce"          


cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: teamcity
  labels:
    app: teamcity-runner
  name: teamcity-runner
spec:
  replicas: 1
  selector:
    matchLabels:
      app: teamcity-runner
  template:
    metadata:
      labels:
        app: teamcity-runner
    spec:
      restartPolicy: Always
      containers:
      - name: runner
        image: jgmurua/teamcity-agent-dind:latest
        env:
        - name: TEAMCITY_AGENT_NAME
          value: pepito
        - name: TEAMCITY_SERVER_URL
          value: http://teamcity.teamcity.svc.cluster.local:8111
        securityContext:
          privileged: true
          runAsUser: 0
EOF