#!/bin/bash

. ~/.bashrc

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
URL="http://192.168.0.2:8765/`hostname -s`-argocd-main.yaml" 
if curl --output /dev/null --silent --head --fail "$URL"; then
  echo "getting argocd-main.yaml from secret repo"
  curl "$URL" --silent -o argocd/argocd-main.yaml
  echo "adjusting  metallb pool IP"
  sed -i "s/127.0.0.1-127.0.0.1/`hostname -I | awk '{print $1"-"$1}'`/" argocd/argocd-main.yaml
fi

kubectl apply -f argocd/argocd-main.yaml

# remove argocd entry from helm, now it's selfmanaged
kubectl delete secret -l owner=helm,name=argocd -n argocd

# argo cli
curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
chmod +x /usr/local/bin/argocd

# argo cli login and credentials
IP=$(kubectl -n argocd get svc | grep "argocd-server " | gawk '{ print $3 }')
CMD="argocd login ${IP}:443 --username admin --password password --insecure"
echo
echo "to login to argocd cli use this command:"
echo $CMD
echo "argocd app sync argocd-main"
echo ""

echo "Waiting for ArgoCD to start"
until timeout 1 bash -c "cat < /dev/null > /dev/tcp/$IP/443" ; do
  sleep 5s
  echo -n .
done
echo ""
eval $CMD
argocd app sync argocd-main

