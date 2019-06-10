# Installing and configuring P4wnp1_aloa on the Raspberry Pi Zero W

## Contents

- Description
- Requirements
- Preparing the SD card
- Resizing the primary partition
- Configuring the system
  - Changing the root password
  - Setting a hostname
- Configuring the ALOA (A Little Offensive Appliance)
- Troubleshooting
  - Additional resources

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

SSH into the Pi at 172.24.0.1 on port 22. The default login uses the root account with "toor" as the password.

## Resizing the primary partition

`./scripts/rpi-wiggle.sh`

## Configuring the system

### Changing the root password

Type `passwd` then enter the new password twice.

### Setting a hostname

`hostnamectl set-hostname HOSTNAME`

## Configuring the ALOA (A Little Offensive Appliance)

## Troubleshooting

### Additional resources

[P4wnp1_aloa](https://github.com/mame82/P4wnP1_aloa)
