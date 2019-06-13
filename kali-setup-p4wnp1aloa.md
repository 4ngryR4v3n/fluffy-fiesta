# Installing and configuring P4wnp1_aloa on the Raspberry Pi Zero W

## Contents

- [Description](#description)
- [Requirements](#requirements)
- [Preparing the SD card](#preparing-the-sd-card)
- [Resizing the primary partition](#resizing-the-primary-partition)
- [Configuring the system](#configuring-the-system)
  - [Changing the root password](#changing-the-root-password)
  - [Setting a hostname](#setting-a-hostname)
  - [Setting up Mosh](#setting-up-mosh)
  - [Using private/public keys for SSH authentication](#using-privatepublic-keys-for-authentication)
- [Configuring the ALOA (A Little Offensive Appliance)](#configuring-the-aloa-a-little-offensive-appliance)
- [Troubleshooting](#troubleshooting)
  - [Additional resources](#additional-resources)

## Description

This documentation outlines the steps necessary to set up [P4wnp1_aloa](https://github.com/mame82/P4wnP1_aloa) on the Raspberry Pi Zero W platform.

**NOTE:** This documentation is intended for personal use and may result in undesired functionality.

## Requirements

- A computer with internet access (wireless capability is necessary for some parts of the configuration process)
- Raspberry Pi Zero W
- 16 GB or larger SD card (with usb reader)

## Preparing the SD card

Download the installation image from the [releases](https://github.com/mame82/P4wnP1_aloa/releases/download/v0.1.0-alpha2/kali-linux-v0.1.0-alpha2-rpi0w-nexmon-p4wnp1-aloa.img.xz) page and burn it to the SD card using [Etcher](https://www.balena.io/etcher/) (extraction of the .xz file is not necessary).

Once the image has finished burning to the SD card, insert the SD card into the Raspberry Pi.

**WARNING:** Do not attempt to insert the SD card while the device is powered, as it may corrupt the installation.

Next, plug a micro USB OTG cable from the PC to the Pi's data port and connect to the Pi's wireless access point when it becomes available (password: "MaMe82-P4wnP1").

SSH into the Pi at 172.24.0.1 on port 22. The default login uses the root account with "toor" as the password. If an error appears stating that remote host identification has failed, run

`ssh-keygen -R GUEST_IP`

## Resizing the primary partition

**NOTE:** It is normal to have up to 1 GB of unallocated space or "wiggle room" after the primary partition. If this is the case, there is no need to expand the primary partition.

If necessary, resize the primary partition to the full size of the SD card.

`./scripts/rpi-wiggle.sh`

## Configuring the system

### Changing the root password

Type `passwd` then enter the new password twice.

### Setting a hostname

`hostnamectl set-hostname HOSTNAME`

### Setting up [Mosh](https://mosh.org/)

`apt install mosh`

## Configuring the ALOA (A Little Offensive Appliance)

To configure P4wnp1, open a browser and go to http://172.16.0.1:8000.

It is reccommended to connect the P4wnP1 to the internet and run `apt update && apt upgrade` to ensure the entire system is up to date.

## Troubleshooting

### Additional resources

[P4wnp1_aloa](https://github.com/mame82/P4wnP1_aloa)
