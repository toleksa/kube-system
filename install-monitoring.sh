#!/bin/bash

set -euo pipefail

kubectl create namespace monitoring

#
#community
#helm install prometheus prometheus-community/prometheus --set server.persistentVolume.storageClass=longhorn,alertmanager.persistentVolume.storageClass=longhorn --namespace monitoring
#helm install grafana grafana/grafana --namespace monitoring --set persistence.enabled=true
#helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack --namespace monitoring -f monitoring-values.yaml
kubectl apply -f prometheus-ingress.yaml -n monitoring
kubectl apply -f grafana-ingress.yaml -n monitoring


#
#bitnami
#helm install prometheus bitnami/kube-prometheus --set prometheus.persistence.enabled=true,alertmanager.persistence.enabled=true
#helm install grafana bitnami/grafana --set metrics.enabled=true,metrics.serviceMonitor.enabled=true,admin.password=admin
# echo "Password: $(kubectl get secret grafana-admin --namespace default -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"

#
#helm repo
#kubectl create namespace prometheus
#helm install prometheus helm/prometheus-operator --namespace prometheus

