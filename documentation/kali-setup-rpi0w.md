# Installing Kali Linux on the Raspberry Pi Zero W

## Contents

- Description
- Requirements
- Preparing the SD card
- Configuring the system
  - Changing the root password
  - Setting a hostname
- Troubleshooting
  - Additional resources

## Description

This documentation outlines the steps necessary to set up a functional Kali Linux system on the Raspberry Pi Zero W platform.

**NOTE:** This documentation is intended for personal use and may result in undesired functionality.

## Requirements

- A computer with internet access
- Raspberry Pi Zero W
- Android tablet or phone with USB OTG charge port
- 16 GB or larger SD card (with usb reader)
- USB OTG male to USB male connector (a standard android phone charger works just fine)
- USB female to USB OTG male connector
- SSH client ([Termius](https://termius.com/) works well)

## Preparing the SD card

Download the Pi-Tail image from [here](https://whitedome.com.au/re4son/download/pi-tail/) and burn it to the SD card using [Etcher](https://www.balena.io/etcher/).

Once the image has finished burning to the SD card, use any disk management tool to resize the primary partition to fill the rest of the unallocated space. Insert the SD card into the Raspberry Pi.

**WARNING:** Do not attempt to insert the SD card while the device is on, as it may corrupt the installation.

Next, make sure the USB OTG male to USB female connector is plugged into the phone end and the other end of the cord is plugged into the USB OTG port closest to the end of the board, otherwise the Pi will not turn on. Once the Pi is powered, a green light will appear at one end of the board.

Enable the wireless hotspot on the phone, setting the SSID to "sepultura" and the password to "R4t4m4h4tt4." The Pi should autoconnect. Once it does, SSH to it at 192.168.43.254.

The default login uses the root account with "toor" as the password.

## Configuring the system

### Changing the root password

Type `passwd` then enter the new password twice.

### Setting a hostname

`hostnamectl set-hostname HOSTNAME`

## Troubleshooting

### Additional resources

[Pi-Tail | Re4son](https://whitedome.com.au/re4son/pi-tail/)
