# MikroTik VLAN Enterprise Lab

Enterprise VLAN segmentation lab using MikroTik RouterOS, Ubuntu VM, trunk/access configuration, hotspot guest network, and inter-VLAN firewall filtering.

---

# Features

* VLAN10 & VLAN20 Configuration
* Trunk Port Configuration
* Access Port Configuration
* Inter-VLAN Routing
* DHCP Server per VLAN
* Firewall Inter-VLAN Filtering
* Wireless Guest VLAN
* Hotspot VLAN20
* Ubuntu VLAN Testing
* VLAN Packet Inspection using tcpdump

---

# Topology

## Network Design

* `ether2` → Trunk Port
* `ether3` → Access VLAN10
* `wlan2` → Guest WiFi VLAN20
* Ubuntu VM → VLAN trunk testing

---

# VLAN Information

| VLAN   | Network         | Purpose                 |
| ------ | --------------- | ----------------------- |
| VLAN10 | 192.168.10.0/24 | Staff Network           |
| VLAN20 | 192.168.20.0/24 | Guest / Hotspot Network |

---

# Technologies Used

* MikroTik RouterOS
* Bridge VLAN Filtering
* DHCP Server
* Firewall Filter
* NAT Masquerade
* Hotspot Server
* Virtual Wireless AP
* Ubuntu Linux
* tcpdump
* VirtualBox

---

# Trunk vs Access

## Trunk Port

A trunk port carries multiple VLANs simultaneously using tagged frames (802.1Q).

### Example

* `ether2` → VLAN10 + VLAN20 tagged

---

## Access Port

An access port carries only one VLAN using untagged frames.

### Examples

* `ether3` → VLAN10
* `wlan2` → VLAN20

---

# Ubuntu VLAN Testing

Ubuntu VM was used to verify VLAN tagged traffic.

## VLAN Interface Example

```bash
ip link add link enp0s3 name enp0s3.10 type vlan id 10
ip link add link enp0s3 name enp0s3.20 type vlan id 20
```

---

## DHCP Test

```bash
dhclient enp0s3.10
dhclient enp0s3.20
```

---

## VLAN Packet Inspection

```bash
tcpdump -i enp0s3 -e vlan
```

### Verification Result

* VLAN10 tagged packets detected
* VLAN20 tagged packets detected
* ethertype 802.1Q verified

---

# Firewall Rules

Implemented firewall filtering between VLANs.

## Example Rules

* VLAN20 cannot access VLAN10
* VLAN20 is still allowed internet access

---

# Wireless Guest Network

Implemented guest WiFi using:

* `wlan2`
* Access VLAN20
* MikroTik Hotspot Server

---

# Testing Results

| Test                    | Result  |
| ----------------------- | ------- |
| VLAN10 DHCP             | SUCCESS |
| VLAN20 DHCP             | SUCCESS |
| Internet Access         | SUCCESS |
| Trunk VLAN Detection    | SUCCESS |
| Hotspot Login           | SUCCESS |
| Inter-VLAN Firewall     | SUCCESS |
| VLAN tcpdump Inspection | SUCCESS |

---

# Troubleshooting

## VirtualBox VLAN Issue

Initial VLAN tagging issue occurred because:

* Wrong NIC adapter was used
* Unsupported USB LAN configuration

### Solution

* Switched trunk interface to SR9900 USB LAN adapter
* Verified VLAN tags using tcpdump

---

# Repository Structure

```text
mikrotik-vlan-enterprise-lab/
│
├── README.md
├── topology/
├── configs/
├── screenshots/
├── troubleshooting/
└── docs/
```

---

# Author

**Rendy Agustiyan**

Created as part of a personal Network Engineering learning roadmap and enterprise networking practice lab.
