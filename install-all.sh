#!/bin/bash

set -euo pipefail

./install-base.sh
./install-helm.sh
./install-longhorn.sh
./install-metallb.sh
./install-externaldns.sh
./install-monitoring.sh

echo "!!! source ~/.bashrc !!!"

