#!/bin/bash

cd templates

for APP in "argo-cd/argo-cd" "bitnami/external-dns" "longhorn/longhorn" "bitnami/metallb" "prometheus-community/kube-prometheus-stack"; do
    COLOR='\033[00m'
    SUFFIX=''
    echo "=====$APP"
    CHART=`echo $APP | gawk -F"/" '{ print $2 }'`
    HELM_VER=`helm search repo $APP | tail -n 1 | gawk '{ print $2 }'`
    GIT_VER=`grep targetRevision ${CHART}.yaml | grep -v \# | gawk '{ print $2 }'`
    if [ "$HELM_VER" != "$GIT_VER" ]; then
      COLOR='\033[01;31m'
      SUFFIX="!!"
    fi
    echo -e "$APP ${COLOR}${HELM_VER}\033[00m $GIT_VER $SUFFIX"
done
