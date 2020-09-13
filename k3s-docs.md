
# k3s in docker

pre-req
install docker and kubectl

https://github.com/unboundedsystems/k3s-dind

```
docker run -d --privileged --name k3s --hostname k3s -p 8443:8443 -p 30081:30081 unboundedsystems/k3s-dind
docker exec k3s get-kubeconfig.sh > ./k3sconfig
export KUBECONFIG=./k3sconfig
Note: -p 30081:30081 is the port of application service
kubectl get nodes
kubectl apply -f hello-world.yaml
```

# k3s in docker + Ingress controller

pre-req
install docker and kubectl

```
docker run -d --privileged --name k3s --hostname k3s -p 8443:8443 -p 80:80 -p 5678:5678 unboundedsystems/k3s-dind
docker exec k3s get-kubeconfig.sh > ./k3sconfig
export KUBECONFIG=./k3sconfig
kubectl get nodes

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-0.32.0/deploy/static/provider/cloud/deploy.yaml

kubectl apply -f example/
```
Note - dont forget to tag service in GCE


# Useful links

https://github.com/unboundedsystems/k3s-dind

https://adaptjs.org/docs/0.0.6/getting_started/run

https://medium.com/@yannalbou/k3d-k3s-k8s-perfect-match-for-dev-and-testing-896c8953acc0

https://dockerlabs.collabnix.com/beginners/install/raspberrypi3/setting-up-k3s-cluster.html

https://asciinema.org/a/347570

https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-ingress-guide-nginx-example.html

https://dev.to/sr229/how-to-use-nginx-ingress-controller-in-k3s-2ck2
