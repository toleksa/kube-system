#!/bin/bash

set -euo pipefail

curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service

echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> ~/.bashrc
echo "alias k=\"kubectl -n \$NAMESPACE \"" >> ~/.bashrc
echo "k(){ kubectl -n \${NAMESPACE:-default} \"\$@\"; }" >> ~/.bashrc
echo "namespace(){ export NAMESPACE=\"\$1\"; }" >> ~/.bashrc
echo "prompt(){ PS1='\[\033[01;32m\]\u@\h\[\033[00m\](\${NAMESPACE:--}):\[\033[01;34m\]\w\[\033[00m\]$ ' ; }" >> ~/.bashrc
echo "PROMPT_COMMAND=prompt" >> ~/.bashrc

set +u
. ~/.bashrc
set -u

