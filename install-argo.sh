#!/bin/bash

echo "START install-argo.sh"

. ~/.bashrc

#check if kubectl installed
kubectl &> /dev/null
if [ $? -ne 0 ]; then
  echo "ERR: check kubectl installation"
  exit 1
fi 

#check if helm installed
helm &> /dev/null
if [ $? -ne 0 ]; then
  echo "ERR: check helm installation"
  exit 1
fi

helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update

echo "Waiting for kubernetes to start"
until kubectl get nodes | grep -i `hostname` | grep " Ready " ; do
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
echo "Waiting for project"
until argocd proj list | grep default ; do
  sleep 1s
  echo -n .
done
echo ""

wget -O /tmp/argocd-main.yaml https://raw.githubusercontent.com/toleksa/kube-system/main/argocd/argocd-main.yaml
URL="http://192.168.0.2:8765/`hostname -s`-argocd-main.yaml" 
if curl --output /dev/null --silent --head --fail "$URL"; then
  echo "getting `hostname -s`-argocd-main.yaml from secret repo"
  curl "$URL" --silent -o /tmp/argocd-main.yaml
else
  URL="http://192.168.0.2:8765/generic-argocd-main.yaml"
  if curl --output /dev/null --silent --head --fail "$URL"; then
    echo "getting generic-argocd-main.yaml from secret repo"
    curl "$URL" --silent -o /tmp/argocd-main.yaml
  fi
fi

echo "adjusting domain to: ${ARGO_DOMAIN:-`hostname -f`}"
sed -i "s/domain: example.com/domain: ${ARGO_DOMAIN:-`hostname -f`}/g" /tmp/argocd-main.yaml

echo "adjusting metallb pool IP to: ${ARGO_IP:-`hostname -I | awk '{print $1"-"$1}'`}"
sed -i "s/127.0.0.1-127.0.0.1/${ARGO_IP:-`hostname -I | awk '{print $1"-"$1}'`}/g" /tmp/argocd-main.yaml

kubectl apply -f /tmp/argocd-main.yaml

# remove argocd entry from helm, now it's selfmanaged
kubectl delete secret -l owner=helm,name=argocd -n argocd

argocd app sync argocd-main

echo "END install-argo.sh"

