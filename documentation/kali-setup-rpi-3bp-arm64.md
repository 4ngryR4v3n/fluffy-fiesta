# Installing Kali Linux on the Raspberry Pi 3 B+ (arm64)

## Contents

- Description
- Requirements
- Preparing the SD card
- Configuring the system
  - Changing the password
  - Setting a hostname
  - Configuring SSH

## Description

## Requirements

- A computer with internet access
- Raspberry Pi 3 B+
- 16 GB or larger SD card (with usb reader)

## Preparing the SD card

Download the "Kali Linux RaspberryPi 3 64 bit" image from [here](https://www.offensive-security.com/kali-linux-arm-images/) and burn it to the SD card using [Etcher](https://www.balena.io/etcher/).

Once the image has finished burning, insert the SD card into the Raspberry Pi and power it on. DO NOT insert the SD card while the device is on.

## Configuring the system

The default login uses the root account with "toor" as the password.

### Changing the password

Type `passwd` then enter the new password twice.

### Setting a hostname

`hostnamectl set-hostname HOSTNAME`

### Configuring SSH

`systemctl enable ssh`

`systemctl start ssh`
