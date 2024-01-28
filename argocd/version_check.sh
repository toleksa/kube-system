#!/bin/bash

APPS="
argo-cd/argo-cd argo-cd
bitnami/external-dns external-dns
longhorn/longhorn longhorn
bitnami/metallb metallb
prometheus-community/kube-prometheus-stack monitoring
kubecost/cost-analyzer kubecost
neuvector/core neuvector

bitnami/fluentd fluentd
bitnami/elasticsearch elasticsearch
bitnami/kibana kibana
elastic/metricbeat metricbeat
bitnami/logstash logstash
"

helm repo update &> /dev/null
cd templates
while read -r REPO MANIFEST; do
  if [ -z "$REPO" ] && [ -z "$MANIFEST" ]; then
    echo ""
    continue
  fi

  COLOR='\033[00m'
  SUFFIX=''

  REPO_VER=$(helm search repo "$REPO" | tail -n 1 | gawk '{ print $2 }')
  GIT_VER=$(grep targetRevision "${MANIFEST}.yaml" | grep -v \# | gawk '{ print $2 }')

  if [ "$REPO_VER" != "$GIT_VER" ]; then
    COLOR='\033[01;31m'
    SUFFIX="!!"
  fi
  echo -e "$REPO ${COLOR}${REPO_VER}\033[00m $GIT_VER $SUFFIX"
done <<< "$APPS"

