#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $0 <namespace>"
    exit 1
fi

kubectl -n $1 delete daemonsets,replicasets,services,deployments,pods,rc,statefulset,secret,configmap --all
kubectl delete namespace $1

