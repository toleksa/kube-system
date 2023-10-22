#!/bin/bash

echo "START install-bash.sh"

set -euo pipefail

cat <<'EOF' >> ~/.bashrc
prompt(){ PS1='\[\033[01;31m\]\u@\h\[\033[00m\]($(kubectl config view --minify | grep namespace | cut -d" " -f6)):\[\033[01;34m\]\w\[\033[00m\]\$ ' ; }
PROMPT_COMMAND=prompt
alias k='kubectl'
alias king='kubectl get ingress -A'
alias kapp='kubectl get applications.argoproj.io -A'
alias kall='kubectl get all -A'
source <(kubectl completion bash)
complete -F __start_kubectl k

alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'
EOF


echo "END install-bash.sh"

