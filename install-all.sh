#!/bin/bash

set -euo pipefail

./install-base.sh
./install-longhorn.sh
./install-metallb.sh
./install-helm.sh
./install-externaldns.sh
./install-monitoring.sh

echo "!!! source ~/.bashrc !!!"

