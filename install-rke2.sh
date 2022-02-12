#!/bin/bash

#install rke2
curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service

echo "export PATH=\$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> ~/.bashrc

echo "dupa1"
. ~/.bashrc
echo "dupa2"

/var/lib/rancher/rke2/bin/kubectl apply -f - <<EOF
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: rke2-ingress-nginx
  namespace: kube-system
spec:
  valuesContent: |-
    controller:
      publishService:
        enabled: true
        pathOverride: kube-system/rke2-ingress-nginx-controller
      service:
        enabled: true
        type: LoadBalancer
EOF
