#!/bin/bash

for APP in "argo-cd/argo-cd" "bitnami/external-dns" "longhorn/longhorn" "bitnami/metallb" "monitoring/kube-prometheus-stack"; do
    echo "=====$APP"
    CHART=`echo $APP | gawk -F"/" '{ print $2 }'`
    HELM_VER=`helm search repo $APP | tail -n 1 | gawk '{ print $2 }'`
    GIT_VER=`grep targetRevision ${CHART}.yaml | grep -v \# | gawk '{ print $2 }'`
    echo "$APP $HELM_VER $GIT_VER"
done

