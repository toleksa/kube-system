#!/bin/bash

echo "START install-rke2.sh"

#install rke2
curl -sfL https://get.rke2.io | sh -
echo "export PATH=\$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> ~/.bashrc

. ~/.bashrc

#check if kubectl installed
kubectl &> /dev/null
if [ $? -ne 0 ]; then
  echo "ERR: check kubectl installation"
  exit 1
fi 

systemctl enable rke2-server.service
systemctl start rke2-server.service

kubectl apply -f - <<EOF
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

echo "END install-rke2.sh"

