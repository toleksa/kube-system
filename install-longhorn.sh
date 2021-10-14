#!/bin/bash

set -euo pipefail

#check if helm is installed
helm > /dev/null 2>&1

helm repo add longhorn https://charts.longhorn.io
helm repo update
kubectl create namespace longhorn-system
helm install longhorn longhorn/longhorn --namespace longhorn-system -f longhorn-values.yaml
#helm install longhorn longhorn/longhorn --namespace longhorn-system -f longhorn-values.yaml --set ingress.host=longhorn.dev.ac
kubectl apply -f longhorn-ingress.yaml

### old manual version
#kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.2/deploy/longhorn.yaml
#
#echo 'sleeping 90s to propagate (if next step fails, try again in a moment)'
#sleep 90s
#
#kubectl patch storageclass longhorn -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
#
#echo 'sleeping another 60s because of reasons'
#sleep 60s
#kubectl apply -f longhorn-ingress.yaml

