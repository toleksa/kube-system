#!/bin/bash

sed -e "s/example.com/$(hostname -f)/g" kube-api-ingress.yaml  | kubectl apply -f -

