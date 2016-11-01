#!bin/bin/bash

# Rawan Alsaadi 10081442
# Omar Toutounji 10169506
# Beltan Michel 10169162
# Zina Al-Sabbagh 10161380

# delete any previous rules in the INPUT, FORWARD and OUTPUT tables
sudo iptables -F INPUT
sudo iptables -F FORWARD
sudo iptables -F OUTPUT

# enable ssh only from computers in the range 130.15.0.0 to 130.15.255.255 [netmask /16]
sudo iptables -A INPUT -p TCP --dport 22 -s 130.15.0.0/16 -j ACCEPT

# enable ssh from computers in any private network
sudo iptables -A INPUT -p TCP --dport 22 -m iprange --src-range 10.0.0.0-10.255.255.255 -j ACCEPT
sudo iptables -A INPUT -p TCP --dport 22 -m iprange --src-range 172.16.0.0-172.31.255.255 -j ACCEPT
sudo iptables -A INPUT -p TCP --dport 22 -s 192.168.0.0/16 -j ACCEPT

# enable http and https from any IP
sudo iptables -A INPUT -p TCP --dport 80,443 -j ACCEPT

# drop any other incoming tcp traffic
sudo iptables -A INPUT -p TCP -j DROP

#block connecting from your computer to any IP outside the range 130.15.0.0 to 130.15.255.255 [netmask/16]

# only allow IP 130.15.100.100 to connect to your MySQL running on port 3306

#drop outgoing ssh traffic to all other computers
