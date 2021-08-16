#!/bin/bash

#helm install prometheus prometheus-community/prometheus --set server.persistentVolume.storageClass=longhorn,alertmanager.persistentVolume.storageClass=longhorn

helm install prometheus bitnami/kube-prometheus --set prometheus.persistence.enabled=true,alertmanager.persistence.enabled=true

