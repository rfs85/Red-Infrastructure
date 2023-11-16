#!/usr/bin/env bash

# Cobalt Strike Team Server
# Author: RFS
# Web: #
# Version: 0.1
# OS: Ubuntu 18 / Debian 12



check_root() {
  if [ "$(id -u)" != 0 ]; then
    exiterr "Script must be run as root. Try 'sudo sh $0'"
  fi
}

check_root()

DOMAIN="ad-attacks.rfs"
HOSTNAME="cobalt"
C2_PORT="19500"


clear
echo ""

echo "Update the System"
sudo apt-get update -y


echo "Installing basic dependencies"
#Ubuntu18
#sudo apt install -y openjdk-11-jdk 
#Debian 12
sudo apt install openjdk-17-jdk


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

