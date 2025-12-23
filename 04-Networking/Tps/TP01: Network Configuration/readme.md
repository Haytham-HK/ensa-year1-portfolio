# TP01: Linux Network Configuration

**Goal**: Learn how to manually configure network interfaces, manage routing tables, and troubleshoot connectivity on a Linux system.

---

## 1. Identification
First, we identify the physical interface (often `eth0`, `ens33`, etc.).

```bash
# List network hardware details
sudo lshw -class network

# Check kernel logs for ethernet devices
dmesg | grep eth
```

---

## 2. Configuration (Static IP)
We used the `ifconfig` command (part of *net-tools*) to set a static IP.


```bash
# Syntax: ifconfig <interface> <ip> netmask <mask> broadcast <bcast> up
sudo ifconfig eth0 172.16.199.200 netmask 255.255.0.0 broadcast 172.16.255.255 up

# Add a default gateway
sudo route add default gw 172.16.1.100
```

---

## 3. MAC Address Spoofing
Changing the physical address of the network card.

```bash
# 1. Take interface down
sudo ifconfig eth0 down

# 2. Change MAC
sudo ifconfig eth0 hw ether 00:11:22:33:44:55

# 3. Bring interface up
sudo ifconfig eth0 up
```

---

