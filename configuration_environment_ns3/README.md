# Configuration of the ns-3/LXD emulation environment

## Configuration of each profile 
```bash
#Configurazioni del profilo di ogni uav (LXD)
sudo lxc profile edit uav[x]
#Viene aggiunta l'interfaccia eth1, che sarà collegata al bridge Linux. [x] corrisponde a ogni uav (uav1,uav2,ecc)
eth1:
    name: eth1
    nictype: bridged
    parent: br-uav[x]
    type: nic
```
## Association of wireless interfaces to containers
```bash
#!/bin/sh
echo "Associazione delle interfacce wireless ai contenitori, prima si deve creare con mac80211_hwsim"
sudo modprobe mac80211_hwsim radios=9
sudo lxc config device add uav1 wlan1 nic nictype=physical parent=wlan1 name=wlan1
sudo lxc config device add uav2 wlan2 nic nictype=physical parent=wlan2 name=wlan2
sudo lxc config device add uav3 wlan3 nic nictype=physical parent=wlan3 name=wlan3
sudo lxc config device add uav4 wlan4 nic nictype=physical parent=wlan4 name=wlan4
sudo lxc config device add uav5 wlan5 nic nictype=physical parent=wlan5 name=wlan5
sudo lxc config device add uav6 wlan6 nic nictype=physical parent=wlan6 name=wlan6
sudo lxc config device add uav7 wlan7 nic nictype=physical parent=wlan7 name=wlan7
sudo lxc config device add sdn wlan8 nic nictype=physical parent=wlan8 name=wlan8
sudo modprobe -r mac80211_hwsim
```
## Configuration of each container
```bash
#Configurazione di rete di ogni contenitore
sudo cp -p /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.bkp
sudo nano /etc/netplan/50-cloud-init.yaml
# Nel caso de ogni uav viene aggiunta l'interfaccia eth1 e wlan (secondo la tabella 4.1)
        eth1:
            dhcp4: no
            dhcp6: no
            addresses: [11.0.0.x/24]
        wlan1:
            dhcp4: no
            dhcp6: no
            addresses: [10.0.2.x/24]
# Nel caso de ogni sta viene aggiunta l'interfaccia eth1 (secondo la tabella 4.1)
        eth1:
            dhcp4: no
            dhcp6: no
            addresses: [11.0.0.x/24]
# Nel caso del controllore viene aggiunta l'interfaccia eth1 (secondo la tabella 4.1)
        eth1:
            dhcp4: no
            dhcp6: no
            addresses: [10.0.2.1/24]
```
## Installation of basic components in each uav container
```bash
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
```
## Installation of basic components in each container sta
```bash
#!/bin/sh
echo " Installazione dei componenti "
sudo apt-get update -y
sudo apt install openvswitch-switch -y
sudo apt-get install iw -y
sudo apt-get install iperf -y
```
## Installation of basic components and controller in the sdn container (Ryu)
```bash
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
```
