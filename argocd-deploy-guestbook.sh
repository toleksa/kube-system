#!/bin/bash

set -euo pipefail

kubectl create namespace guestbook

curl -kSs https://raw.githubusercontent.com/kubernetes/examples/master/guestbook/all-in-one/guestbook-all-in-one.yaml -o example-guestbook/guestbook_app.yaml

kubectl apply -f argocd-guestbook.yaml

#IP=$(kubectl -n argocd get svc | grep "argocd-server " | gawk '{ print $3 }')
#CMD="argocd login ${IP}:443 --username admin --password password --insecure"
#echo $CMD
#eval $CMD
#CMD="argocd app sync guestbook"
#echo $CMD
#eval $CMD

