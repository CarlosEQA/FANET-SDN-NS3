#!/bin/sh
echo " Installazione dei componenti "
sudo apt-get update -y
sudo apt install openvswitch-switch -y
sudo apt-get install iw -y
sudo apt-get install iperf -y
