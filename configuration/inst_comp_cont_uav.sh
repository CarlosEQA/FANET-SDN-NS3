#!/bin/sh
echo " Installazione dei componenti"
sudo apt-get update -y
sudo apt install openvswitch-switch -y
sudo apt-get install iw -y
sudo apt install wpasupplicant -y

echo "Creazione del file wpa"
ln -s /etc/ ~/confwpa
cd ~/confwpa
echo "#wpa_supplicant.conf \nnetwork={ \nssid="Wifi-UAV" \nkey_mgmt=WPA-PSK \npsk="unicaluav" \n}" >> wpa_supplicant.conf
sudo chmod 777 wpa_supplicant.conf
