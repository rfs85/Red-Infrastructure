#!/usr/bin/env bash

# Cobalt Strike Team Server
# Author: RFS
# Web: #
# Version: 0.1
# OS: Ubuntu 18

DOMAIN="ad-attacks.rfs"
HOSTNAME="cobalt"
C2_PORT="19500"


clear
echo ""

echo "Update the System"
sudo apt-get update -y


echo "Installing basic dependencies"
sudo apt install -y openjdk-11-jdk proxychains socat


sudo hostnamectl set-hostname $HOSTNAME.$DOMAIN



## Manage Cobalt Service
echo "Configuring Cobalt Service"
sudo systemctl daemon-reload
sudo systemctl enable cobaltc2.service
sudo systemctl restart cobaltc2.service
sudo systemctl status cobaltc2.service


## Firewall UFW Configuration
echo "Configuring Firewall"
sudo apt install ufw
sudo ufw allow ssh
sudo ufw allow $C2_PORT/tcp
sudo ufw allow 500,4500/udp
sudo ufw enable
sudo ufw status


## IPSEC COnfiguration
echo "Configuring IPSec"
sudo apt install strongswan strongswan-pki
mkdir -p ~/pki/{cacerts,certs,private}
chmod 700 ~/pki
ipsec pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/ca-key.pem
ipsec pki --self --ca --lifetime 3650 --in ~/pki/private/ca-key.pem --type rsa --dn "CN=AD-Attacks CA" --outform pem > ~/pki/cacerts/ca-cert.pem
ipsec pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/server-key.pem