# Setting up Kali Linux on the Raspberry Pi 3 B+

## Contents

- [Description](#description)
- [Requirements](#requirements)
- [Preparing the SD card](#preparing-the-sd-card)
- [Resizing the primary partition](#resizing-the-primary-partition)
- [Configuring the system](#configuring-the-system)
  - [Changing the root password](#changing-the-root-password)
  - [Setting a hostname](#setting-a-hostname)
  - [Configuring SSH](#configuring-ssh)
  - [Changing host SSH keys](#changing-host-ssh-keys)
  - [Setting up Mosh](#setting-up-mosh)
  - [Disabling the GUI](#disabling-the-gui)
- [Setting up an access point)](#setting-up-an-access-point)
  - [Updating the system and installing hostapd and dnsmasq](#updating-the-system-and-installing-hostapd-and-dnsmasq)
  - [Configuring the interfaces](#configuring-the-interfaces)
  - [Configuring hostapd](#configuring-hostapd)
  - [Configuring dnsmasq](#configuring-dnsmasq)
  - [Setting up IPv4 forwarding](#setting-up-ipv4-forwarding)
  - [Enabling services to run at boot](#enabling-services-to-run-at-boot)
- [Connecting to a network](#connecting-to-a-network)
- [Troubleshooting](#troubleshooting)
  - [Additional resources](#additional-resources)

## Description

This documentation outlines the steps necessary to set up [Kali Linux](https://www.kali.org/) on the Raspberry Pi 3 B+ platform.

**NOTE:** This documentation is intended for personal use and may result in undesired functionality.

## Requirements

- A computer with internet access
- Raspberry Pi 3 B+
- 16 GB or larger SD card (with usb reader)
- An ethernet cable (for a wired connection to the Pi)

## Preparing the SD card

Download the "Kali Linux RaspberryPi 2 and 3 64" installation image from the [releases](https://www.offensive-security.com/kali-linux-arm-images/) page and burn it to the SD card using [Etcher](https://www.balena.io/etcher/) (extraction of the .xz file is not necessary).

Once the image has finished burning to the SD card, insert the SD card into the Raspberry Pi and boot.

**WARNING:** Do not attempt to insert the SD card while the device is powered, as it may corrupt the installation.

## Resizing the primary partition

**NOTE:** It is normal to have up to 1 GB of unallocated space or "wiggle room" after the primary partition. If this is the case, there is no need to expand the primary partition.

If necessary, resize the primary partition to the full size of the SD card.

`./scripts/rpi-wiggle.sh`

## Configuring the system

### Changing the root password

Type `passwd` then enter the new password twice.

### Setting a hostname

`hostnamectl set-hostname HOSTNAME`

### Configuring SSH

SSH should be enabled by default. To connect, use the default username "root" and password "toor" on port 22.

If an error appears on the client stating that remote host identification has failed, run

`ssh-keygen -R GUEST_IP`

### Changing host SSH keys

`rm /etc/ssh/ssh_host_*`

`dpkg-reconfigure openssh-server`

`service ssh restart`

### Setting up [Mosh](https://mosh.org/)

`apt install mosh`

### Disabling the GUI

Boot into a command line instead of XFCE

`systemctl set-default multi-user.target`

To revert to default, use

`systemctl set-default graphical.target`

Apply the changes

`reboot`

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
iface wlan0 inet static
address 192.168.100.1
netmask 255.255.255.0
network 192.168.100.0
broadcast 192.168.100.255

allow-hotplug wlan1
iface wlan1 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

**NOTE:** If, after a reboot, any external wireless interface is acting as wlan0, try switching the 'wlan0' and 'wlan1' on the lines with 'allow-hotplug.'

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

`ifup wlan0`

### Configuring [hostapd](https://en.wikipedia.org/wiki/Hostapd)

Create a new /etc/hostapd/hostapd.conf with the following contents

```
interface=wlan0
driver=nl80211

hw_mode=g
channel=6
ieee80211n=1
wmm_enabled=1
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
macaddr_acl=1
accept_mac_file=/etc/hostapd/wlist
ignore_broadcast_ssid=1

auth_algs=1
wpa=2
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP

ssid=Pi3-AP
wpa_passphrase=raspberry
```

Create a new file in /etc/hostapd called 'wlist' with the contents being the MAC addresses of any whitelisted devices.

**NOTE:** The above configuration disables SSID broadcast and enables MAC filtering.

Edit /etc/default/hostapd and change the value of 'DAEMON_CONF' to '/etc/hostapd/hostapd.conf.' Do the same in /etc/init.d/hostapd.

### Configuring [dnsmasq](https://en.wikipedia.org/wiki/Dnsmasq)

Back up the original configuration.

`mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig`

Replace the contents of /etc/dnsmasq.conf with

```
interface=wlan0
listen-address=192.168.100.1
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=192.168.100.2,192.168.100.100,12h
```
### Setting up IPv4 forwarding

Add the following to the end of /etc/sysctl.conf

`net.ipv4.ip_forward=1`

Apply the changes.

`sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"`

Configure [iptables](https://wiki.debian.org/iptables).

`update-alternatives --config iptables`

**NOTE:** Be sure to select legacy mode.

`iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE`

`iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT`

`iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT`

`iptables -t nat -A POSTROUTING -o wlan1 -j MASQUERADE`

`iptables -A FORWARD -i wlan1 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT`

`iptables -A FORWARD -i wlan0 -o wlan1 -j ACCEPT`

Make the changes persistent across reboots.

`apt-get install iptables-persistent`

**NOTE:** Be sure to select yes to save IP rules.

`systemctl enable netfilter-persistent`

### Enabling services to run at boot

`systemctl enable hostapd`

`systemctl enable dnsmasq`

**NOTE:** If an error occurs regarding masked services, run

`systemctl unmask SERVICE`

Reboot to ensure everything has been set up correctly.

`sudo reboot`

## Connecting to a network

To connect to a network, simply use an ethernet cable, or add the following to /etc/wpa_suplicant/wpa_supplicant.conf.

```
network={
  ssid="SSID"
  psk="PASSWORD"
}
```

## Troubleshooting

### Additional resources

[dnsmasq](https://en.wikipedia.org/wiki/Dnsmasq)  
[hostapd](https://en.wikipedia.org/wiki/Hostapd)  
[Kali Linux - Raspberry Pi](https://docs.kali.org/kali-on-arm/install-kali-linux-arm-raspberry-pi)  
[Mosh](https://mosh.org/)
