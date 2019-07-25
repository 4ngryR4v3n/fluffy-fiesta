# Kali Linux

## Contents

- [Description](#description)
- [Installation](#installation-amd64-x86-64)
    - [Requirements](#requirements)
    - [Customizing the installation](#customizing-the-installation)
        - [Requirements](#requirements-1)
        - [Setting up the live-build system](#setting-up-the-live-build-system)
        - [Configuring the package list](#configuring-the-package-list)
        - [Building the image](#building-the-image)
        - [Configuring SSH for host-guest communication](#configuring-ssh-for-host-guest-communication)
        - [Transferring the image to the host machine via scp](#transferring-the-image-to-the-host-machine-via-scp)
    - [Preparing the installation media](#preparing-the-installation-media)
    - [Installing the system](#installing-the-system)
- [Troubleshooting](#troubleshooting)
    - [Known issues](#known-issues)
    - [Additional resources](#additional-resources)

## Description

This documentation outlines steps regarding installation, customization, and usage of [Kali Linux](https://www.kali.org/) as a primary penetration testing system on various platforms.

*Note: This documentation is intended for personal use and may result in undesired functionality.*

## Installation (amd64 x86_64)

### Requirements

### Customizing the installation

*Note: for a standard installation, see [Preparing the installation media](#preparing-the-installation-media).*

#### Requirements

- Reliable internet connection
- Windows 10
- Hypervisor (preferrably [VirtualBox](https://www.virtualbox.org/))

#### Setting up the live-build system

Download the latest Kali Linux build from [here](https://www.kali.org/downloads/) and install it in a virtual machine. Use default Kali installation settings (ie. no encryption or fancy partitioning), and set up bridged networking in your virtual machine's settings in order to transfer the compiled image to your host.

Make sure the system is up to date.

`apt-get update && apt-get upgrade`

Set up the live build environment.

`apt-get install git live-build cdebootstrap`

`git clone git://git.kali.org/live-build-config.git && cd live-build-config`

#### Configuring the package list

Other variants can be used, but the Gnome one should work fine for most situations. Edit live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot to your liking.

*Note: Lines that start with a "#" are treated as comments and are ignored by the compiler.*

For more information, see [Kali Metapackages](https://tools.kali.org/kali-metapackages).

#### Building the image

`./build.sh --verbose --distribution kali-rolling --variant gnome`

*Note: If you have selected another variant, be sure to change that here.*

#### Configuring SSH for host-guest communication

Edit /etc/ssh/sshd_config to replace `PermitRootLogin prohibit-password` with `PermitRootLogin yes.`.

Normally this would be a security risk, however since this is in a virtual machine on a presumably private network, it should be fine.

Enable the SSH server to automatically launch on startup.

`systemctl enable ssh`

Restart the SSH server.

`service ssh restart`

#### Transferring the image to the host machine via `scp`

From the host machine, run the following.

`scp root@GUEST_IP:~/live-build-config/images/kali-linux-gnome-rolling-amd64.iso C:\Users\USERNAME\Desktop\kali-linux-gnome-rolling-amd64.iso`

The ISO image should now be on your desktop. If an error appears stating that remote host identification has failed, run `ssh-keygen -R GUEST_IP`.

### Preparing the installation media

Download [Rufus](https://rufus.ie/) and run it with administrator privileges. Be sure to select DD write mode, otherwise the Kali installation process may fail. Optionally, on linux machines, you can use dd `dd if=PATH_TO_KALI_ISO of=/dev/sdX bs=512k`, replacing "PATH_TO_KALI_ISO" and "/dev/sdX" with your own values. Be careful with this method though, as any syntax errors can be catastrophic!

## Installing the system

**WARNING: The following process will erase any data on the disk. Back up any important data before proceeding.**

In order to ensure speed and reliability during installation, a wired internet connection to the target system is recommended. Additionally, for extra security, select "Separate /home, /usr, /var, and /tmp partitions" and "Guided- use entire disk and set up encrypted LVM" when prompted. Note that this will encrypt your system, potentially reducing performance and requiring you to enter a passphrase during each boot.

## Troubleshooting

### Known issues

- After a fresh installation, /etc/apt/sources.list may be empty, causing apt operations to fail.
    - **Fix:** Replace the contents of /etc/apt/sources.list with the latest [repositories](https://docs.kali.org/general-use/kali-linux-sources-list-repositories).

### Additional resources