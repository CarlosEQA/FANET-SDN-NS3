# Script used in the ns-3/LXD emulation environment

The script used to implement the FANET network in the ns-3 environment is defined. Considering that the only parameters for variation are the number of UAVs and their position in an area, we specify the code created in a general way where the only parameters to be changed are the following

```
uint16_t uav = x;
Ns2MobilityHelper ns2 = Ns2MobilityHelper ("directory");
positionAlloc->Add (Vector (x.x, y.y, z.z));
```

```
/*
* Rete FANET 
*/

#include <iostream>
#include <fstream>
#include <string>
#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/mobility-module.h"
#include "ns3/wifi-module.h"
#include "ns3/tap-bridge-module.h"
#include "ns3/flow-monitor-helper.h"
#include "ns3/csma-module.h"
#include "ns3/bridge-module.h"
#include "ns3/internet-module.h"
#include "ns3/ipv4-global-routing-helper.h"
#include "ns3/netanim-module.h" 

using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("TapWifiVirtualMachineExample");

int
main (int argc, char *argv[])
{
  CommandLine cmd;
  cmd.Parse (argc, argv);


  /*Real Time Emulation parameters*/
  GlobalValue::Bind ("SimulatorImplementationType", StringValue ("ns3::RealtimeSimulatorImpl"));
  GlobalValue::Bind ("ChecksumEnabled", BooleanValue (true));
  
  /*Nodos WiFi*/
  
  uint16_t uav = x; /*Valore da inserire*/
  uint16_t sta = 2;
  
  NodeContainer wifiUAV;
  wifiUAV.Create (uav);
  NetDeviceContainer wifiDevicesUAV;
  
  NodeContainer wifiSTA;
  wifiSTA.Create (sta);
  NetDeviceContainer wifiDevicesSTA;
  
  /*Definizione del standard*/
  
  WifiHelper wifi;
  wifi.SetStandard (WIFI_STANDARD_80211g);
  wifi.SetRemoteStationManager ("ns3::ConstantRateWifiManager", "DataMode", StringValue ("ErpOfdmRate54Mbps"));
  
  WifiMacHelper wifiMac;
  wifiMac.SetType ("ns3::AdhocWifiMac");
  
  YansWifiPhyHelper wifiPhy;
  YansWifiChannelHelper wifiChannel = YansWifiChannelHelper::Default ();
  wifiChannel.SetPropagationDelay ("ns3::ConstantSpeedPropagationDelayModel");
  wifiChannel.AddPropagationLoss ("ns3::LogDistancePropagationLossModel", "Exponent", DoubleValue(4.5)); 
  wifiPhy.SetChannel (wifiChannel.Create ());
  wifiPhy.SetPcapDataLinkType (WifiPhyHelper::DLT_IEEE802_11_RADIO);

  wifiDevicesUAV = wifi.Install (wifiPhy, wifiMac, wifiUAV);
  wifiDevicesSTA = wifi.Install (wifiPhy, wifiMac, wifiSTA);
  
  wifiPhy.EnablePcapAll (std::string ("data"));
  
  Ns2MobilityHelper ns2 = Ns2MobilityHelper ("directory"); /*Valore da inserire - posizionamento degli UAV*/
  ns2.Install();  
    
  MobilityHelper mobilitySTA;
  Ptr<ListPositionAllocator> positionAlloc = CreateObject<ListPositionAllocator> ();
  positionAlloc->Add (Vector (x.x, y.y, z.z));  /*Valore da inserire - posizione della stazione 1*/
  positionAlloc->Add (Vector (x.x, y.y, z.z));  /*Valore da inserire - posizione della stazione 2*/
  mobilitySTA.SetPositionAllocator (positionAlloc);
  mobilitySTA.SetMobilityModel ("ns3::ConstantPositionMobilityModel");
  mobilitySTA.Install (wifiSTA);
  
  AnimationInterface anim ("fanet.xml"); 
    
  for (int i = 0; i < uav; i++)
    {
      TapBridgeHelper tapBridgeUAV;
      std::string number = std::to_string(i+1);
      tapBridgeUAV.SetAttribute ("Mode", StringValue ("UseLocal"));
      tapBridgeUAV.SetAttribute ("DeviceName", StringValue ("tap-uav"+number));
      tapBridgeUAV.Install (wifiUAV.Get (i), wifiDevicesUAV.Get (i));
    }
  
  for (int i = 0; i < sta; i++)
    {
      TapBridgeHelper tapBridgeSTA;
      std::string numbersta = std::to_string(i+1);
      tapBridgeSTA.SetAttribute ("Mode", StringValue ("UseLocal"));
      tapBridgeSTA.SetAttribute ("DeviceName", StringValue ("tap-sta"+numbersta));
      tapBridgeSTA.Install (wifiSTA.Get (i), wifiDevicesSTA.Get (i));
    }
	
  Simulator::Stop (Seconds (6000.));
  Simulator::Run ();
  Simulator::Destroy ();
}
```
