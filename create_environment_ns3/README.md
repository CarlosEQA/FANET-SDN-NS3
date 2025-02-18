# Installation of the ns-3/LXD emulation environment

## Installation of the ns-3 simulator
```bash
#!/bin/sh
echo "Installazione del simulatore ns-3 v. 3.35 … "
sudo apt update
sudo mkdir ns3
sudo apt install g++ python3
sudo apt install build-essential
cd ns3
wget https://www.nsnam.org/releases/ns-allinone-3.35.tar.bz2
sudo tar xjf ns-allinone-3.35.tar.bz2
cd ns3/ns-allinone-3.35/
./build.py --enable-examples --enable-tests
cd ns-3.35/
./waf --run hello-simulator
echo "Installazione di NetAdmin"
sudo add-apt-repository ppa:rock-core/qt4
sudo apt update
sudo apt-get install qt4-dev-tools
sudo apt-get install qt4-qmake
sudo apt install qt4-default
cd ns3/ns-allinone-3.35/netanim-3.108/
qmake NetAnim.pro
make
echo " Fine dell'installazione”
```
## Installation of basic components
```bash
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
```
## Installation of Linux Container Daemon and creation of containers
```bash
#!/bin/sh
echo "Installazione LXD e contenitori"
sudo apt install lxd lxd-client
sudo lxd init
sudo lxc launch ubuntu:20.04 uav1
sudo lxc launch ubuntu:20.04 uav2
sudo lxc launch ubuntu:20.04 uav3
sudo lxc launch ubuntu:20.04 uav4
sudo lxc launch ubuntu:20.04 uav5
sudo lxc launch ubuntu:20.04 uav6
sudo lxc launch ubuntu:20.04 uav7
sudo lxc launch ubuntu:20.04 sta1
sudo lxc launch ubuntu:20.04 sta2
sudo lxc launch ubuntu:20.04 sdn

echo "Creazione di profili di contenitori"
sudo lxc profile copy default uav1
sudo lxc profile copy default uav2
sudo lxc profile copy default uav3
sudo lxc profile copy default uav4
sudo lxc profile copy default uav5
sudo lxc profile copy default uav6
sudo lxc profile copy default uav7
sudo lxc profile copy default sta1
sudo lxc profile copy default sta2
sudo lxc profile copy default sdn

echo " Associazione del profilo al contenitore"
sudo lxc profile add uav1 uav1
sudo lxc profile add uav2 uav2
sudo lxc profile add uav3 uav3
sudo lxc profile add uav4 uav4
sudo lxc profile add uav5 uav5
sudo lxc profile add uav5 uav6
sudo lxc profile add uav5 uav7
sudo lxc profile add sta1 sta1
sudo lxc profile add sta2 sta2
sudo lxc profile add sdn sdn

echo "Dissociazione del profilo "Default" a cada contenitore"
sudo lxc profile remove uav1 default
sudo lxc profile remove uav2 default
sudo lxc profile remove uav3 default
sudo lxc profile remove uav4 default
sudo lxc profile remove uav5 default
sudo lxc profile remove uav6 default
sudo lxc profile remove uav7 default
sudo lxc profile remove sta1 default
sudo lxc profile remove sta2 default
sudo lxc profile remove sdn default

echo "Fine dell'installazione e configurazione iniziale"
```
