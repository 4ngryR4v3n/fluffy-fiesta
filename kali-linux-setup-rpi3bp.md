sudo apt-get update
sudo apt-get upgrade
sudo reboot
sudo apt-get install hostapd
sudo apt-get install dnsmasq
sudo apt-get install dhcpcd5
sudo nano /etc/dhcpcd.conf
  denyinterfaces wlan0
sudo nano /etc/network/interfaces
  auto lo
  iface lo inet loopback

  auto eth0
  allow-hotplug eth0
  iface eth0 inet static
  address 192.168.1.2
  netmask 255.255.255.0
  gateway 192.168.1.1
  dns-nameservers 8.8.8.8 8.8.4.4

  allow-hotplug wlan0
  iface wlan0 inet static
  address 192.168.220.1
  netmask 255.255.255.0
  network 192.168.220.0
  broadcast 192.168.220.255
  # wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
sudo service dhcpcd restart
sudo ifdown wlan0
sudo ifup wlan0
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
sudo nano /etc/default/hostapd
  DAEMON_CONF="/etc/hostapd/hostapd.conf"
sudo nano /etc/init.d/hostapd
  DAEMON_CONF=/etc/hostapd/hostapd.conf
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo nano /etc/dnsmasq.conf
  interface=wlan0
  listen-address=192.168.220.1
  bind-interfaces
  server=8.8.8.8
  domain-needed
  bogus-priv
  dhcp-range=192.168.220.50,192.168.220.150,12h
sudo nano /etc/sysctl.conf
  net.ipv4.ip_forward=1
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
sudo apt-get install iptables-persistent
sudo systemctl enable netfilter-persistent
sudo service hostapd start
sudo service dnsmasq start
sudo reboot
