# kube-system

## Content

Deploys Kubernetes (RKE2), Helm, ArgoCD and basic toolchain: Metallb, Longhorn, ExternalDNS, Prometheus and Grafana

## Install

On fresh OS run ```install-all.sh``` and grab a coffee.

install-all.sh is wrapper for sub-components which can be also installed separately one by one:

- ```install-rke2.sh``` installs RKE2 K8s

- ```install-bash.sh``` adds ENV variables and aliases to .bashrc

- ```install-helm.sh``` installs Helm

- ```install-argo.sh``` installs Helm's ArgoCD and then argocd-main app of apps with all ArgoCD applications

## Hints

- Error from server (InternalError): error when creating "STDIN": Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io": failed to call webhook: Post "https://rke2-ingress-nginx-controller-admission.kube-system.svc:443/networking/v1/ingresses?timeout=10s": x509: certificate signed by unknown authority

- ```kubectl delete -A ValidatingWebhookConfiguration rke2-ingress-nginx-admission```

