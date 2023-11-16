#!/usr/bin/env bash

# Cobalt Strike Jumper
# Author: RFS
# Web: #
# Version: 0.1
# OS: Ubuntu 22
DOMAIN="ad-attacks.rfs"
HOSTNAME="jumper01"
clear
echo ""


## BAsic configs
echo "Update the System"
sudo apt-get update -y
echo "Installing basic dependencies"
sudo apt install -y ssh openssl strongswan strongswan-pki libcharon-extra-plugins libcharon-extauth-plugins libstrongswan-extra-plugins libtss2-tcti-tabrmd0
sudo hostnamectl set-hostname $HOSTNAME.$DOMAIN



## Firewall
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw allow 500,4500/udp






