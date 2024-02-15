#!/bin/bash

echo "START install-bash.sh"

set -euo pipefail

curl "https://raw.githubusercontent.com/toleksa/configs/main/.bash_kube" > ~/.bash_kube
chmod +x ~/.bash_kube

cat <<'EOF' >> ~/.bashrc
if [ -f ~/.bash_kube ]; then
    . ~/.bash_kube
fi
EOF

echo "END install-bash.sh"

