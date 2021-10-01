#!/bin/bash

kubectl create namespace monitoring

#
#community
#helm install prometheus prometheus-community/prometheus --set server.persistentVolume.storageClass=longhorn,alertmanager.persistentVolume.storageClass=longhorn --namespace monitoring
#helm install grafana grafana/grafana --namespace monitoring --set persistence.enabled=true
helm install monitoring prometheus-community/kube-prometheus-stack --set persistence.enabled=true,server.persistentVolume.storageClass=longhorn,alertmanager.persistentVolume.storageClass=longhorn --namespace monitoring
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

