
# Install git

sudo apt install git
git config --global user.name <name>
git config --global user.email <email>

ssh-keygen


# docker-k8s

## Steps to start VM in Google Console
1) Go to Compute Engine
2) Create VM
3) select ubuntu OS

Once VM is created, launch console in browser SSH mode- use chrome

## Install Docker
https://docs.docker.com/engine/install/ubuntu/

```
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

```
sudo usermod -aG docker $USER
```
(If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.)


## Install Kubernetes

**As per Official Docs**

```
sudo apt-get update && sudo apt-get install -y apt-transport-https curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

kubeadm init
(Note: Run as sudo su)
Update - kubeadm init alone wont work, atleast in GCE, need to give more params.
kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address="10.128.0.13" --kubernetes-version stable-1.8

Give internal Ip for apiserver

Update - KUBECONFIG
need to export KUBECONFIG
1) if root user
export KUBECONFIG=/etc/kubernetes/admin.conf
useradd username -G sudo -m -s /bin/bash
passwd username
sudo su username
cd $HOME
sudo whoami
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
echo "export KUBECONFIG=$HOME/admin.conf" | tee -a ~/.bashrc


Update - Need a pod network CNI, when not using minikube/k3s etc
use --kubernetes-version stable-1.8 during kubeadm init
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/k8s-manifests/kube-flannel-rbac.yml

kubectl get pods --all-namespaces
```

To start using your cluster, you need to run the following as a regular user:
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

**As per Training Session**
```
apt-get update && apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update

apt-get install -y kubelet=1.18.0-00 kubeadm=1.18.0-00 kubectl=1.18.0-00

kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address="10.128.0.12"
export KUBECONFIG=/etc/kubernetes/admin.conf
```

Applying Calico Network in K8s cluster. 
```
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
```

## Sample Deployments
kubectl apply -f hello-world.yaml

In GCE, create a firewall
source ip ranges - 0.0.0.0/0
ports tcp - 80,8080,30000-33000
next, edit vm settings and add this service tag


# Useful links
https://medium.com/@Grigorkh/install-kubernetes-on-ubuntu-1ac2ef522a36
https://medium.com/@bhargavshah2011/hello-world-on-kubernetes-cluster-6bec6f4b1bfd
