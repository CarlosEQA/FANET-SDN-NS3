#!/bin/sh
OPTION=$1;
UAVNUMBER=$2;
STATIC="static";
COUNTER=1;

if [ "$#" -ne 2 ]; then
        echo "Usage: Introduce PROTOCOL + NUMBER OF UAVs"
else
        echo $OPTION

        if [ $OPTION = $STATIC ]; then
                echo 'Setting static environment'
		while [ $COUNTER -le $UAVNUMBER ]; do
                        #Bridge
                        sudo brctl addbr br-uav$COUNTER
                        #tap
                        sudo tunctl -t tap-uav$COUNTER
                        #Config tap
                        sudo ifconfig tap-uav$COUNTER 0.0.0.0 up
                        #Config Bridge
                        sudo brctl addif br-uav$COUNTER tap-uav$COUNTER
                        sudo ifconfig br-uav$COUNTER up

                        COUNTER=$((COUNTER+1))
                done
                        #Config. Wireless
                        sudo modprobe -r mac80211_hwsim
                        sudo modprobe mac80211_hwsim radios=9
                        sudo hostapd -B /etc/hostapd/hostapd.conf
        fi
fi