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