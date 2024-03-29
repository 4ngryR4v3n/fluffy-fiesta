# Kali Linux Compilation for AMD64 Systems

## Contents

- [Description](#description)
- [Requirements](#requirements)
- [Setting up the live-build system](#setting-up-the-live-build-system)
  - [Configuring the package list](#configuring-the-package-list)
- [Building the image](#building-the-image)
  - [Configuring SSH for host-guest communication](#configuring-ssh-for-host-guest-communication)
  - [Transferring the image to the host machine via scp](#transferring-the-image-to-the-host-machine-via-scp)
- [Troubleshooting](#troubleshooting)
  - [Additional resources](#additional-resources)

## Description

This documentation outlines the steps necessary to set up a development environment and build a custom [Kali Linux](https://www.kali.org/) image. See [https://github.com/Perdyx/fluffy-fiesta/edit/master/documentation/kali_setup.md](https://github.com/Perdyx/fluffy-fiesta/edit/master/documentation/kali_setup.md) for installation documentation.

**NOTE:** This documentation is intended for personal use and may result in undesired functionality.

## Requirements

- Reliable internet connection
- Windows 10
- Hypervisor (preferrably [VirtualBox](https://www.virtualbox.org/))

## Setting up the live-build system

Download the latest Kali Linux build from [here](https://www.kali.org/downloads/) and install it in a virtual machine. Use default Kali installation settings (ie. no encryption or fancy partitioning). Additionally, set up bridged networking in order to transfer compiled image from guest to host (see []() for more information).

Update and upgrade the system

`apt-get update && apt-get upgrade`

Install the necessary tools

`apt-get install git live-build cdebootstrap`

Clone the Kali live-build repository

`git clone git://git.kali.org/live-build-config.git && cd live-build-config`

### Configuring the package list

Edit live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot to include any desired packages.

**NOTE:** Lines that start with a "#" are treated as comments and are ignored by the compiler.

For more information, see [Kali Metapackages](https://tools.kali.org/kali-metapackages).

## Building the image

`./build.sh --verbose --distribution kali-rolling --variant gnome`

### Configuring SSH for host-guest communication

Edit /etc/ssh/sshd_config to replace

`PermitRootLogin prohibit-password`

with

`PermitRootLogin yes.`

Enable the SSH server to automatically launch on startup

`systemctl enable ssh`

Restart the SSH server

`service ssh restart`

### Transferring the image to the host machine via `scp`

From the host machine, run

`scp root@GUEST_IP:~/live-build-config/images/kali-linux-gnome-rolling-amd64.iso C:\Users\USERNAME\Desktop\kali-linux-gnome-rolling-amd64.iso`

The ISO image should now be on the desktop. If an error appears stating that remote host identification has failed, run

`ssh-keygen -R GUEST_IP`

## Troubleshooting

### Known issues

- After a fresh installation, /etc/apt/sources.list may be empty, causing apt to fail.  
  - **Fix:** Copy the latest repositories from [here](https://docs.kali.org/general-use/kali-linux-sources-list-repositories).

### Additional resources

[Building Custom Kali ISOs](https://docs.kali.org/kali-dojo/02-mastering-live-build)<br>
[Debian live-build](https://manpages.debian.org/testing/live-build/live-build.7.en.html)<br>
[Kali Linux Metapackages](https://www.kali.org/news/kali-linux-metapackages/)<br>
[Kali Linux Official Documentation](https://www.kali.org/kali-linux-documentation/)<br>
[Kali Metapackages](https://tools.kali.org/kali-metapackages)<br>
[Live Build a Custom Kali ISO](https://docs.kali.org/development/live-build-a-custom-kali-iso)
