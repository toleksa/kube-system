#!/bin/bash

echo "START install-helm.sh"

. ~/.bashrc

echo "installing helm"
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add helm https://charts.helm.sh/stable
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo add longhorn https://charts.longhorn.io
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm repo list

echo "END install-helm.sh"
