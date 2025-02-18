#!/bin/sh
echo "Installazione dei componenti … "
sudo apt-get update
sudo apt install openvswitch-switch -y
sudo apt-get install iw
sudo apt-get install wpasupplicant
sudo apt install hostapd
sudo apt-get install iperf
sudo apt install net-tools
sudo apt-get install bridge-utils
sudo apt install uml-utilities
ln -s /etc/hostapd/ ~/confhostapd
cd ~/confhostapd
echo "#hostapd.conf \ninterface=wlan0 \ndriver=nl80211 \ncountry_code=IT \nssid=Wifi-UAV \nchannel=6 \nhw_mode=b \nwpa=3 \nwpa_key_mgmt=WPA-PSK \nwpa_pairwise=TKIP \nwpa_passphrase=unicaluav \nauth_algs=3 \nbeacon_int=100" >> hostapd.conf
sudo chmod 777 hostapd.conf
echo "Fine dell'installazione"