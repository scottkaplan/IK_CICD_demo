#!/bin/bash

sudo yum -y update
sudo yum -y upgrade
sudo yum -y install curl

# install latest AWS CLI
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# Install terraform
cd /tmp
# curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg
# sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/
# sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install terraform
terraform --version

echo "Configure AWS credentials"
echo "Install IK.pem"

