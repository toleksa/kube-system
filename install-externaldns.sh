#!/bin/bash

set -euo pipefail

kubectl create namespace external-dns
kubectl apply -f externaldns-secret.yaml
kubectl apply -f externaldns.yaml

