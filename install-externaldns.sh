#!/bin/bash

set -euo pipefail

kubectl apply -f externaldns-secret.yaml
kubectl apply -f externaldns.yaml

