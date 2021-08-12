#!/bin/bash

#helm install promi prometheus-community/prometheus --set server.persistentVolume.storageClass=longhorn,alertmanager.persistentVolume.storageClass=longhorn

helm install promi bitnami/kube-prometheus --set prometheus.persistence.enabled=true,alertmanager.persistence.enabled=true

