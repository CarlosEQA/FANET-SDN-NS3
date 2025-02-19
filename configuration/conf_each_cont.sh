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
