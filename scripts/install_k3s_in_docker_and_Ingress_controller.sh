#!/bin/bash

docker run -d --privileged --name k3s --hostname k3s -p 8443:8443 unboundedsystems/k3s-dind
docker exec k3s get-kubeconfig.sh > ./k3sconfig
export KUBECONFIG=./k3sconfig

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-0.32.0/deploy/static/provider/cloud/deploy.yaml

