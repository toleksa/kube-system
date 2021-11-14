#!/bin/bash

set -euo pipefail

./install-rke2.sh
./install-bash.sh
./install-helm.sh
./install-longhorn.sh
./install-metallb.sh
./install-externaldns.sh
./install-monitoring.sh

echo "!!! source ~/.bashrc !!!"

