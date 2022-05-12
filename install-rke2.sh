#!/bin/bash

echo "START install-rke2.sh"

# hack for stupid ubuntu .bashrc which doesn't work on noninteractive sessions
[ -z "$PS1" ] && export PS1="> "

MODE=""
case $1 in
  agent | worker)
    MODE="agent"
    ;;

  *)
    MODE="server"
    ;;
esac

echo "MODE: $MODE"

if [ "$MODE" == "server" ]; then
  #install rke2
  curl -sfL https://get.rke2.io | sh -
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
fi

if [ "$MODE" == "agent" ]; then
  if [ ! -f /etc/rancher/rke2/config.yaml ]; then
    echo "ERR: /etc/rancher/rke2/config.yaml not found - skipping RKE2 installation"
  else  
    #install rke2
    curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
    systemctl enable rke2-agent.service
    systemctl start rke2-agent.service
  fi
fi

echo "export PATH=\$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> ~/.bashrc

. ~/.bashrc

echo "PATH:$PATH"
echo "KUBECONFIG: $KUBECONFIG"
echo "kubectl: `which kubectl`"

#check if kubectl installed
kubectl &> /dev/null
if [ $? -ne 0 ]; then
  echo "ERR: check kubectl installation"
  exit 1
fi 

echo "END install-rke2.sh"

