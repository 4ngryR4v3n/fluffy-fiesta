# Kali Linux Setup

## Contents

- Description
- Setting up a live-build system
- Configuring live-build
  - Configuring the package list
- Building the image
- Saving the image
  - Configuring ssh for host-guest communication
  - Transferring the image to the host machine via scp
- Resources

## Description

This documentation outlines the steps necessary to build, install, and configure a customized Kali Linux image for use as a primary penetration testing system.

Configuration files for each variant can be found in [configs/kali/variants](https://github.com/Perdyx/fluffy-fiesta/tree/master/configs/kali/variants).

**NOTE:** This guide is intended for personal use and may result in an undesired configuration.

## Setting up a Kali live-build system

Install Kali Linux in a virtual machine. Ensure that the guest is on the same network as the host (necessary to transfer the compiled image to the host for safe-keeping). Use default Kali installation settings (ie. no encryption or fancy partitioning).

Update and upgrade the system

`apt-get update && apt-get upgrade`

If this fails, /etc/apt/sources.list is probably empty. Copy the latest repositories from [here](https://docs.kali.org/general-use/kali-linux-sources-list-repositories).

Install the necessary tools

`apt-get install git live-build cdebootstrap`

Clone the Kali live-build repository

`git clone git://git.kali.org/live-build-config.git && cd live-build-config`

## Setting up live-build

### Configuring the package list

Replace live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot with that of your desired variant.

#### Development ([source](https://github.com/Perdyx/fluffy-fiesta/blob/master/configs/kali/variants/development/live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot))

`git clone https://raw.githubusercontent.com/Perdyx/fluffy-fiesta/master/configs/kali/variants/development/live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot kali-config/variant-gnome/package-lists/kali.list.chroot`

#### Pentesting ([source](https://github.com/Perdyx/fluffy-fiesta/blob/master/configs/kali/variants/pentesting/live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot))

`git clone https://raw.githubusercontent.com/Perdyx/fluffy-fiesta/master/configs/kali/variants/pentesting/live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot kali-config/variant-gnome/package-lists/kali.list.chroot`

## Building the image

`chmod +x build.sh`

`./build.sh --verbose --distribution kali-rolling --variant gnome`

## Saving the image

### Configuring ssh for host-guest communication

Edit /etc/ssh/sshd_config to replace

`PermitRootLogin prohibit-password`

with

`PermitRootLogin yes.`

Enable the ssh server to automatically launch on startup  
`systemctl enable ssh`  
Restart the ssh server

`service ssh restart`

### Transferring the image to the host machine via scp

From the host machine, run

`scp root@GUEST_IP:~/live-build-config/images/kali-linux-gnome-rolling-amd64.iso C:\Users\USERNAME\Desktop\kali-linux-gnome-rolling-amd64.iso`

The ISO image should now be on the desktop. If an error appears stating that remote host identification has failed, run

`ssh-keygen -R GUEST_IP`

## Resources

[Advanced Package Management in Kali Linux](https://www.kali.org/tutorials/advanced-package-management-in-kali-linux/)  
[Kali Linux sources.list Repositories](https://docs.kali.org/general-use/kali-linux-sources-list-repositories)
