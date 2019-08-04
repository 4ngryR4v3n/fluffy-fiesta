#!/usr/bin/env bash
#
# Usage:
# Update.
#   'apt-get update && apt-get dist-upgrade'
# Reboot.
# Edit the config vars below.
# Run the script.
#   './kali-linux-rpi-setup.sh'
#

set -euo pipefail

# Config vars
hostname="kali"
root_password="toor"
ssh_private_key=false
gui_enabled="false"
additional_packages="" # Separate multiple packages by a single space
address="192.168.100.1"
netmask="255.255.255.0"
network="192.168.100.0"
broadcast="192.168.100.255"
dhcp_range="192.168.100.2,192.168.100.255"
ssid="Pi-AP"
wpa_passphrase="raspberry"
ssid_broadcasting=true
mac_filtering=false # Whitelist stored in /etc/hostapd/whitelist
filtered_macs="" # Only use if $mac_filtering is true. Separate multiple addresses by a single space

# Set hostname
hostnamectl set-hostname $hostname

# Set root password
echo -e "$root_password\n$root_password" | passwd root

# Enable/disable GUI
if [ $gui_enabled ]; then
    systemctl set-default graphical.target
else
    systemctl set-default multi-user.target
fi

# Add aliases to manage virtual monitor interface
echo "function mon0up() { iw phy phy0 interface add mon0 type managed && ifconfig mon0 up; }
function mon0down() { ifconfig mon0 down && iw dev mon0 del; }" > .bash_aliases

# Install additional packages
apt-get install $additional_packages -y

# Install hostapd, dnsmasq, and dhcpcd
apt-get install hostapd dnsmasq dhcpcd5 -y

# Prevent dhcpcd from automatically configuring wlan0
echo "denyinterfaces wlan0" >> /etc/dhcpcd.conf

# Configure interfaces
echo "auto lo
iface lo inet loopback

auto eth0
allow-hotplug eth0
iface eth0 inet dhcp

auto wlan0
iface wlan0 inet static
address $address
netmask $netmask
network $network
broadcast $broadcast

allow-hotplug mon0
iface mon0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" > /etc/network/interfaces

# Configure hostapd
echo "interface=wlan0
driver=nl80211

hw_mode=g
channel=6
ieee80211n=1
wmm_enabled=1
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]

auth_algs=1
wpa=2
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP

ssid=$ssid
wpa_passphrase=$wpa_passphrase" > /etc/hostapd/hostapd.conf

# Enable/disable SSID broadcasting for the AP
if [ !$ssid_broadcasting ]; then
    echo "ignore_broadcast_ssid=1" >> /etc/hostapd/hostapd.conf
fi

# Enable/disable MAC filtering for the AP
if [ "$mac_filtering" = true ]; then
    echo "
macaddr_acl=1
accept_mac_file=/etc/hostapd/whitelist
    " >> /etc/hostapd/hostapd.conf

    echo $filtered_macs | tr ' ' '\n' > /etc/hostapd/whitelist
fi

# Configure dnsmasq
cp /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
echo "interface=wlan0
listen-address=$address
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=$dhcp_range,12h" > /etc/dnsmasq.conf

# Enable IPv4 forwarding
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

# Set iptables to run in legacy mode
update-alternatives --set iptables /usr/sbin/iptables-legacy

# Enable connection forwarding from eth0 to AP
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

# Enable connection forwarding from virtual interface to AP
iptables -t nat -A POSTROUTING -o mon0 -j MASQUERADE
iptables -A FORWARD -i mon0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o mon0 -j ACCEPT

# Set up iptables persistence
iptables-save > /etc/iptables.conf
crontab -u root
(crontab -l; echo -e "@reboot sudo iptables-restore < /etc/iptables.conf\n";) | crontab -

# Enable hostapd and dnsmasq to run at boot
if systemctl enable hostapd; then
    systemctl unmask hostapd
fi

if systemctl enable dnsmasq; then
    systemctl unmask dnsmasq
fi

# Set up private key authentication over ssh
if [ "$ssh_private_key" = true ]; then
    ssh-keygen -t rsa
    sed -i "s/PermitRootLogin yes/PermitRootLogin without-password/g" /etc/ssh/sshd_config
fi

# Clear bash history and flush it from memory (necessary because this script uses passwords in plaintext using bash commands)
cat /dev/null > ~/.bash_history && history -c
