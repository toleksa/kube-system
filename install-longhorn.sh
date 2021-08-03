#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.2/deploy/longhorn.yaml

kubectl get pods \
--namespace longhorn-system \
--watch

kubectl -n longhorn-system get pod


