# TP03: DHCP Server Configuration

**Goal:** Set up a DHCP server (isc-dhcp-server) to automatically assign IP addresses to clients on the network.

---

# 1. Installation

```bash
sudo apt-get install isc-dhcp-server
```

---

# 2. Configuration
**File:** /etc/dhcp/dhcpd.conf
We define a subnet block that matches our network interface's IP range.

```bash
# General Options
default-lease-time 3600;
max-lease-time 7200;
option domain-name "ensa.local";
option domain-name-servers 8.8.8.8;

# Subnet Declaration
subnet 192.168.1.0 netmask 255.255.255.0 {
    range 192.168.1.10 192.168.1.100;      # Pool of IPs to give out
    option routers 192.168.1.1;            # The Gateway for clients
    option broadcast-address 192.168.1.255;
}

# Static Reservation (Optional)
# Assigning a fixed IP to a specific printer/server
host my_printer {
    hardware ethernet 00:11:22:33:44:55;
    fixed-address 192.168.1.50;
}

```

---

# 3. Service Management
After saving the config, restart the service to apply changes.

```bash
sudo service isc-dhcp-server restart
# Check status/errors
sudo systemctl status isc-dhcp-server
```