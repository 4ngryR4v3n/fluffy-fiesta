# Installing Kali Linux on the Raspberry Pi 3 B+ (arm64)

## Contents

- Description
- Requirements
- Preparing the SD card
- Configuring the system
  - Changing the password
  - Setting a hostname

## Description

This documentation outlines the steps necessary to set up a functional Kali Linux system on the Raspberry Pi 3 B+ platform.

**NOTE:** This documentation is intended for personal use and may result in undesired functionality.

## Requirements

- A computer with internet access
- Raspberry Pi 3 B+
- 16 GB or larger SD card (with usb reader)
- Network cable
- Physical access to a router or switch
- HDMI cable

## Preparing the SD card

Download the "Kali Linux RaspberryPi 3 64 bit" image from [here](https://whitedome.com.au/re4son/download/sticky-fingers-kali-pi/) and burn it to the SD card using [Etcher](https://www.balena.io/etcher/).

Once the image has finished burning to the SD card, use any disk management tool to resize the primary partition to fill the rest of the unallocated space. Connect the HDMI cable to a monitor and attach a USB keyboard (necessary for initial setup). Insert the SD card into the Raspberry Pi and power it on.

**WARNING:** Do not attempt to insert the SD card while the device is on, as it may corrupt the installation.

## Configuring the system

The default login uses the root account with "toor" as the password.

### Changing the password

Type `passwd` then enter the new password twice.

### Setting a hostname

`hostnamectl set-hostname HOSTNAME`
