#!/bin/sh
OPTION=$1;
STANUMBER=$2;
STATIC="static";
COUNTER=1;

if [ "$#" -ne 2 ]; then
        echo "Usage: Introduce PROTOCOL + NUMBER OF STAs"
else
        echo $OPTION

        if [ $OPTION = $STATIC ]; then
                echo 'Setting static environment'
		while [ $COUNTER -le $STANUMBER ]; do
                        #Bridge
                        sudo brctl addbr br-sta$COUNTER
                        #tap
                        sudo tunctl -t tap-sta$COUNTER
                        #Config tap
                        sudo ifconfig tap-sta$COUNTER 0.0.0.0 up
                        #Config Bridge
                        sudo brctl addif br-sta$COUNTER tap-sta$COUNTER
                        sudo ifconfig br-sta$COUNTER up

                        COUNTER=$((COUNTER+1))
                done
        fi
fi