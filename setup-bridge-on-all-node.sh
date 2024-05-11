#!/bin/bash


################ Install Docker
# sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# apt-cache policy docker-ce

# sudo apt install docker-ce -y

# echo "docker installed successfully.."  >> /home/$USERNAME/host.log 


############# # Install Docker-compose
# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# sudo chmod +x /usr/local/bin/docker-compose

# echo "docker-compose installed successfully.."  >> /home/$USERNAME/host.log 


# ############# permissions for docker and docker-compose 

# sudo gpasswd -a $USER docker
# sudo gpasswd -a $USER docker-compose

# sudo gpasswd -a $USER docker
# sudo gpasswd -a $USER docker-compose

# sudo chown $USER:docker /var/run/docker.sock

# sudo chown $USER:docker /usr/bin/docker

# sudo chown $USER:docker /usr/local/bin/docker-compose

# ################ Configure containerd to start using systemd as cgroup:

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd




############## disable swap
# sudo swapoff -a
# sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

############# create bridge network for k8s

# cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
# overlay
# br_netfilter
# EOF

# sudo modprobe overlay
# sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
# cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
# net.bridge.bridge-nf-call-iptables  = 1
# net.bridge.bridge-nf-call-ip6tables = 1
# net.ipv4.ip_forward                 = 1
# EOF

# ##### Apply sysctl params without reboot
# sudo sysctl --system




# Kubernetes Installation

############## disable swap
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo kubeadm init










