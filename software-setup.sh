#!/bin/bash

#######################################
# Bash script to install apps on a new system (Ubuntu)
# Script that should be run only first time to install software setup on the host
#######################################

# update package list
sudo apt-get update 
echo "updated packages.."  >> /home/$USERNAME/host.log 



# Inatall Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-cache policy docker-ce

sudo apt install docker-ce -y

echo "docker installed successfully.."  >> /home/$USERNAME/host.log 


# Install Docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

echo "docker-compose installed successfully.."  >> /home/$USERNAME/host.log 


# permissions for docker and docker-compose 

sudo gpasswd -a $USER docker
sudo gpasswd -a $USER docker-compose

sudo gpasswd -a $USER docker
sudo gpasswd -a $USER docker-compose

sudo chown $USER:docker /var/run/docker.sock

sudo chown $USER:docker /usr/bin/docker

sudo chown $USER:docker /usr/local/bin/docker-compose



# # Inatall JDK 
# sudo apt-get install -y openjdk-8-jdk
# echo "JDK installed successfully.."  >> /home/$USERNAME/host.log 

