# TP02: Static Routing

**Goal:** Configure a Linux machine to act as a router and forward packets between two different networks.

---

## 1. Enable IP Forwarding
By default, Linux drops packets not destined for itself. To act as a router, we must enable forwarding.

* Temporary method:

```bash
echo "1" > /proc/sys/net/ipv4/ip_forward
```

* Permanent method:

```bash
#Edit /etc/sysctl.conf and set net.ipv4.ip_forward=1. Then run
 sysctl -p.
```

---

# 2. Adding Static Routes
If our router knows about a network that isn't directly connected, we must add a static route.

```bash
# Syntax: route add -net <network> netmask <mask> gw <gateway_ip> dev <interface>
# Example: Reach the 150.2.0.0 network via the gateway 101.1.1.2
sudo route add -net 150.2.0.0 netmask 255.255.0.0 gw 101.1.1.2 dev eth0
```

---

# 3. Verification
```bash
route -n: Verify the route was added to the table.

tcpdump -i eth0 icmp: Monitor traffic to see if packets are traversing the interface.
```