#!/bin/bash

set -euo pipefail

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml

kubectl apply -f metallb-configmap.yaml

kubectl apply -f config-ingress.yaml
