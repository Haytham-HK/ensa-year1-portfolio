#!/bin/bash
# TP1: Network Configuration
# Just a script to keep track of the commands we used in the lab.
# Don't run this all at once, just copy what you need.

# 1. Finding the interface name
# details about network card
sudo lshw -class network


# 2. Manual IP Config
# The command structure is: ifconfig [interface] [ip] netmask [mask] broadcast [bcast] up
# Example we used in class:
# sudo ifconfig eth0 172.16.199.200 netmask 255.255.0.0 broadcast 172.16.255.255 up

# Adding the gateway
# sudo route add default gw 172.16.1.100


# 3. MAC and MTU
# Changing MAC address (Spoofing)
ifconfig eth0 | grep ether
sudo ifconfig eth0 down
# careful with this one
sudo ifconfig eth0 hw ether 00:11:22:33:44:55
sudo ifconfig eth0 up

# Changing MTU
sudo ifconfig eth0 mtu 1400


# 4. Testing & Troubleshooting
# show routing table
netstat -rn

# classic ping
ping -c 4 google.com
# check the path
traceroute google.com

# ARP stuff
arp -a
# sudo arp -d 192.168.1.1

# Adding a manual host entry
# echo "172.16.199.56 lion lion.domain.com" | sudo tee -a /etc/hosts