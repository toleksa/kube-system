#!/bin/bash

set -euo pipefail

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

#check if installed
helm > /dev/null 2>&1

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add helm https://charts.helm.sh/stable
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

