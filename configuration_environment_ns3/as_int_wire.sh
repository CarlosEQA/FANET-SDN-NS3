#Configurazioni del profilo di ogni uav (LXD)
sudo lxc profile edit uav[x]
#Viene aggiunta l'interfaccia eth1, che sarà collegata al bridge Linux. [x] corrisponde a ogni uav (uav1,uav2,ecc)
eth1:
    name: eth1
    nictype: bridged
    parent: br-uav[x]
    type: nic
