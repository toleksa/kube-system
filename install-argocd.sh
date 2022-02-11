#!/bin/bash

echo "Waiting for kubernetes to start"
until kubectl get nodes | grep `hostname` | grep " Ready " ; do
  sleep 5s
  echo -n .
done
echo ""
kubectl get nodes
echo ""

helm install --create-namespace --namespace argocd argocd argo-cd/argo-cd

# setting credentials to admin/password <- for simplicity of example, I know it's uglyyy
# bcrypt(password)=$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'

#argocd proj create argocd -d https://kubernetes.default.svc,argocd -s https://github.com/toleksa/python-rest-api.git
cat argocd/argocd-main.yaml | kubectl apply -f -

# remove argocd entry from helm, now it's selfmanaged
kubectl delete secret -l owner=helm,name=argocd -n argocd

