# jun/15/2026 11:01:30 by RouterOS 6.48.6
# software id = 8B0R-PMNF
#
# model = RB941-2nD
# serial number = HCB07HD4EJN
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface vlan
add interface=bridge1 name=VLAN10 vlan-id=10
add interface=bridge1 name=VLAN20 vlan-id=20
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk mode=dynamic-keys \
    supplicant-identity=MikroTik wpa2-pre-shared-key=12345678
add authentication-types=wpa2-psk mode=dynamic-keys name=profile1 \
    supplicant-identity="" wpa2-pre-shared-key=Rendy212005
/interface wireless
set [ find default-name=wlan1 ] country=indonesia disabled=no frequency=auto \
    installation=indoor security-profile=profile1 ssid=okeee
add disabled=no mac-address=DE:2C:6E:E5:7D:31 master-interface=wlan1 name=\
    wlan2 ssid="RENDY JAYA INTERNET" wps-mode=disabled
/ip hotspot profile
add dns-name=AGUS.NET hotspot-address=192.168.20.1 login-by=http-chap name=\
    hsprof1
/ip pool
add name=dhcp_pool0 ranges=192.168.10.2-192.168.10.254
add name=dhcp_pool1 ranges=192.168.20.2-192.168.20.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=VLAN10 name=dhcp1
add address-pool=dhcp_pool1 disabled=no interface=VLAN20 name=dhcp2
/ip hotspot
add address-pool=dhcp_pool1 disabled=no interface=VLAN20 name=hotspot1 \
    profile=hsprof1
/interface bridge port
add bridge=bridge1 frame-types=admit-only-vlan-tagged interface=ether2
add bridge=bridge1 frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether4 pvid=20
add bridge=bridge1 frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether3 pvid=10
add bridge=bridge1 interface=wlan2 pvid=20
/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether2 untagged=ether3 vlan-ids=10
add bridge=bridge1 tagged=bridge1,ether2 untagged=ether4,wlan2 vlan-ids=20
/ip address
add address=192.168.10.1/24 interface=VLAN10 network=192.168.10.0
add address=192.168.20.1/24 interface=VLAN20 network=192.168.20.0
/ip dhcp-client
add disabled=no interface=wlan1
/ip dhcp-server network
add address=192.168.10.0/24 dns-server=8.8.8.8 gateway=192.168.10.1
add address=192.168.20.0/24 dns-server=8.8.8.8 gateway=192.168.20.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=accept chain=forward connection-state=established,related
add action=drop chain=forward dst-address=192.168.10.0/24 src-address=\
    192.168.20.0/24
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat out-interface=wlan1
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.20.0/24
/ip hotspot user
add name=admin password=123
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name=RouterOS
