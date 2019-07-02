# Setting up Kali Linux on the Raspberry Pi 3 B+

## Setting up an access point

### Updating the system and installing [hostapd](https://en.wikipedia.org/wiki/Hostapd) and [dnsmasq](https://en.wikipedia.org/wiki/Dnsmasq)

To start, log in as root and ensure the system is up to date.

`sudo apt-get update`

`sudo apt-get upgrade`

Install [hostapd](https://en.wikipedia.org/wiki/Hostapd) and [dnsmasq](https://en.wikipedia.org/wiki/Dnsmasq) and update dhcpcd to the latest version.

`apt-get install hostapd dnsmasq dhcpcd5`

Reboot to apply any changes to the system.

`reboot`

### Configuring the interfaces

Append the following to the end of /etc/dhcpcd.conf.

`denyinterfaces wlan0`

Replace the contents of /etc/network/interfaces with

```
auto lo
iface lo inet loopback

auto eth0
allow-hotplug eth0
iface eth0 inet dhcp

allow-hotplug wlan0
iface wlan1 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

allow-hotplug wlan1
iface wlan0 inet static
address 192.168.220.1
netmask 255.255.255.0
network 192.168.220.0
broadcast 192.168.220.255
```

**NOTE:** If, after a reboot, any external wireless interfaces is acting as wlan0, try switching the 'wlan0' and 'wlan1' on the lines with 'allow-hotplug.'

If a static IP address is necessary on any interface, replace the line(s) containing 'iface' with

```
iface INTERFACE inet static
address 192.168.1.2
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameservers 1.1.1.1 1.0.0.1
```

Restart the dhcpcd service and apply the changes to wlan0.

`service dhcpcd restart`

`ifdown wlan0`

`ifup wlan0`

### Configuring [hostapd](https://en.wikipedia.org/wiki/Hostapd)

Replace the contents of /etc/hostapd/hostapd.conf with

```
sudo nano /etc/hostapd/hostapd.conf
interface=wlan0
driver=nl80211

hw_mode=g
channel=6
ieee80211n=1
wmm_enabled=1
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
macaddr_acl=0
ignore_broadcast_ssid=0

auth_algs=1
wpa=2
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP

ssid=Pi3-AP
wpa_passphrase=raspberry
```

Edit /etc/default/hostapd and change the value of 'DAEMON_CONF' to '/etc/hostapd/hostapd.conf.' Do the same in /etc/init.d/hostapd.

### Configuring [dnsmasq](https://en.wikipedia.org/wiki/Dnsmasq)

Back up the original configuration.

`mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig`

Replace the contents of /etc/dnsmasq.conf with

```
interface=wlan0
listen-address=192.168.220.1
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=192.168.220.50,192.168.220.150,12h
```
### Setting up IPv4 forwarding

Add the following to the end of /etc/sysctl.conf

`net.ipv4.ip_forward=1`

Apply the changes.

`sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"`

Configure [iptables](https://wiki.debian.org/iptables).

`iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE`

`iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT`

`iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT`

`iptables -t nat -A POSTROUTING -o wlan1 -j MASQUERADE`

`iptables -A FORWARD -i wlan1 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT`

`iptables -A FORWARD -i wlan0 -o wlan1 -j ACCEPT`

Make the changes persistent across reboots.

`apt-get install iptables-persistent`

`systemctl enable netfilter-persistent`

### Enabling services to run at boot

`systemctl enable hostapd`

`systemctl enable dnsmasq`

**NOTE:** If an error occurs regarding masked services, run

`systemctl unmask SERVICE`

Reboot to ensure everything has been set up correctly.

`sudo reboot`
