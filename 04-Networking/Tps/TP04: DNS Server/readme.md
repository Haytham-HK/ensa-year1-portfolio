# TP03: DNS Server Configuration

**Goal:**  Configure BIND9 to resolve domain names (like `www.ensa.local`) to IP addresses.

---

# 1. Installation

```bash
sudo apt-get install bind9 bind9utils bind9-doc
```

# 2. Zone Definition
**File:** /etc/bind/named.conf.local
We declare our zone (ensa.local) and point to the file that contains the records.

```bash
zone "ensa.local" {
    type master;
    file "/etc/bind/db.ensa.local";
};
```
---

# 3. Zone File

**File:** /etc/bind/db.ensa.local
Note: Punctuation (dots and semicolons) is critical here!

```bash
; BIND data file for ensa.local
$TTL    604800
@       IN      SOA     ns.ensa.local. root.ensa.local. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns.ensa.local.
@       IN      A       192.168.1.10    ; IP of the DNS server itself
ns      IN      A       192.168.1.10
www     IN      CNAME   ns              ; Alias for www
client1 IN      A       192.168.1.20
```

---

# 4. Testing
Use nslookup or dig to verify the server is answering queries.

```bash
# Check syntax errors in config files
named-checkconf
named-checkzone ensa.local /etc/bind/db.ensa.local

# Test resolution
nslookup www.ensa.local
```