#!/bin/bash

set -euo pipefail

kubectl create namespace argocd
#kubectl apply -n argocd -f argocd-secret.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
chmod +x /usr/local/bin/argocd

kubectl apply -f argocd-ingress.yaml

#echo "sleep 60s" ; sleep 60s
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo

#kubectl delete secret argocd-initial-admin-secret -n argocd

# bcrypt(password)=$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'

IP=$(kubectl -n argocd get svc | grep "argocd-server " | gawk '{ print $3 }')
CMD="argocd login ${IP}:443 --username admin --password password --insecure"
echo $CMD
eval $CMD

