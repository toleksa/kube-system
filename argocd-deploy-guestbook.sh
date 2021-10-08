#!/bin/bash

set -euo pipefail

kubectl create namespace guestbook

curl -kSs https://raw.githubusercontent.com/kubernetes/examples/master/guestbook/all-in-one/guestbook-all-in-one.yaml -o guestbook_app.yaml

kubectl apply -f argocd-questbook.yaml

