#!/bin/bash

set -euo pipefail

curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service

echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> ~/.bashrc

set +u
. ~/.bashrc
set -u

