#!/bin/bash

. ~/.bashrc

echo "installing helm"
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add helm https://charts.helm.sh/stable
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update

helm repo list

