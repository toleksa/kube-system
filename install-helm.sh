#!/bin/bash

set -e 

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

#check if installed
helm > /dev/null 2>&1

helm repo add bitnami https://charts.bitnami.com/bitnami

#helm install promi prometheus-community/prometheus --set server.persistentVolume.storageClass=longhorn,alertmanager.persistentVolume.storageClass=longhorn

helm install promi bitnami/kube-prometheus --set prometheus.persistence.enabled=true,alertmanager.persistence.enabled=true

