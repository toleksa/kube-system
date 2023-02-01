#!/bin/bash

echo "START install-bash.sh"

set -euo pipefail

echo "k(){ kubectl -n \${NAMESPACE:-default} \"\$@\"; }" >> ~/.bashrc
echo "ns(){ export NAMESPACE=\"\$1\"; }" >> ~/.bashrc
echo "prompt(){ PS1='\[\033[01;31m\]\u@\h\[\033[00m\](\${NAMESPACE:--}):\[\033[01;34m\]\w\[\033[00m\]\\$ ' ; }" >> ~/.bashrc
echo "PROMPT_COMMAND=prompt" >> ~/.bashrc
echo "alias king='kubectl get ingress -A'" >> ~/.bashrc
echo "alias kapp='kubectl get applications.argoproj.io -A'" >> ~/.bashrc
echo "alias kall='kubectl get all -A'" >> ~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc

echo "END install-bash.sh"

