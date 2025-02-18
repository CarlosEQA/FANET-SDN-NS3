#!/bin/sh
echo " Installazione dei component"
sudo apt-get update -y
sudo apt-get install iw -y
sudo apt install wpasupplicant -y

echo " Installazione Ryu"
sudo apt install python3-pip
git clone https://github.com/faucetsdn/ryu.git
sudo apt install gcc python3-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev zlib1g-dev
cd ryu
pip3 install -r tools/optional-requires
sudo pip3 install .

echo "Creazione del file wpa"
ln -s /etc/ ~/confwpa
cd ~/confwpa
echo "#wpa_supplicant.conf \nnetwork={ \nssid="Wifi-UAV" \nkey_mgmt=WPA-PSK \npsk="unicaluav" \n}" >> wpa_supplicant.conf
sudo chmod 777 wpa_supplicant.conf
