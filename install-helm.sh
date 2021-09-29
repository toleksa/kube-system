#!/bin/bash

set -euo pipefail

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

#check if installed
helm > /dev/null 2>&1

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add helm https://charts.helm.sh/stable

helm repo update

