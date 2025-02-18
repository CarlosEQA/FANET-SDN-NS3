Installation of the ns-3/LXD emulation environment

Installation of the ns-3 simulator

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
