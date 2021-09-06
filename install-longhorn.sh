#!/bin/bash

set -euo pipefail

kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.2/deploy/longhorn.yaml

echo 'sleeping 30s to propagate (if next step fails, try again in a moment'
sleep 30s

kubectl patch storageclass longhorn -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl get pods \
--namespace longhorn-system \
--watch

kubectl -n longhorn-system get pod


