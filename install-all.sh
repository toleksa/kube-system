#!/bin/bash

set -e

curl https://raw.githubusercontent.com/toleksa/kube-system/main/install-rke2.sh | bash
curl https://raw.githubusercontent.com/toleksa/kube-system/main/install-bash.sh | bash
curl https://raw.githubusercontent.com/toleksa/kube-system/main/install-helm.sh | bash
curl https://raw.githubusercontent.com/toleksa/kube-system/main/install-argo.sh | bash

