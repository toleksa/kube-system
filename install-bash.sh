#!/bin/bash

set -euo pipefail

echo "export PATH=\$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> ~/.bashrc
echo "k(){ kubectl -n \${NAMESPACE:-default} \"\$@\"; }" >> ~/.bashrc
echo "ns(){ export NAMESPACE=\"\$1\"; }" >> ~/.bashrc
echo "prompt(){ PS1='\[\033[01;32m\]\u@\h\[\033[00m\](\${NAMESPACE:--}):\[\033[01;34m\]\w\[\033[00m\]\\$ ' ; }" >> ~/.bashrc
echo "PROMPT_COMMAND=prompt" >> ~/.bashrc
echo "alias king='kubectl get ingress -ALL'" >> ~/.bashrc
echo "alias kapp='kubectl get app -ALL'" >> ~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc

set +u
. ~/.bashrc
set -u

