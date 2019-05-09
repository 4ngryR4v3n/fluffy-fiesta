# Setting up Kali Linux

## Contents

- Description
- Requirements
- Setting up the live-build system
  - Configuring the package list
- Building the image
  - Configuring ssh for host-guest communication
  - Transferring the image to the host machine via scp
- Preparing installation media
- Installing the system
- Setting up the system
  - Creating a non-root user
  - Update
- Troubleshooting
  - Known issues
  - Additional resources

## Description

This documentation outlines the steps necessary to build, install, and configure a customized [Kali Linux](https://www.kali.org/) image for use as a primary penetration testing system.

Configuration files for each variant can be found in [configs/kali/variants](https://github.com/Perdyx/fluffy-fiesta/tree/master/configs/kali/variants).

**NOTE:** This guide is intended for personal use and may result in undesired functionality.

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

Edit live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot as desired.

For more information, see [Kali Metapackages](https://tools.kali.org/kali-metapackages).

## Building the image

`./build.sh --verbose --distribution kali-rolling --variant gnome`

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

## Preparing installation media

Download [Rufus](https://rufus.ie/) and run it with administrator privileges. Be sure to select DD write mode, otherwise the Kali installation process may fail.

## Installing the system

**WARNING:** The following process will erase any data on the disk. Back up any important data before proceeding.

In order to ensure speed and reliability during installation, a wired internet connection on the target system is recommended.

For extra security, select "Separate /home, /usr, /var, and /tmp partitions" and "Guided- use entire disk and set up encrypted LVM" when prompted.

## Setting up the system

After the installation completes and the system reboots, log into the root user.

### Creating a non-root user

Open gnome-control-center (this can be accessed either via typing "gnome-control-center" in a terminal, or by going to the status area on the right of the panel and selecting the settings icon). Navigate to Details/Users and click "Add User." Be sure to select "Administrator" under "Account Type" or the user will not have access to sudo.

**NOTE:** It is best practice to set the user's password to something other than the root or disk encryption passwords.

Log out and log back in as the new user before proceeding.

### Update

`sudo apt-get update && apt-get upgrade`

`sudo apt-get dist-upgrade`

## Troubleshooting

### Known issues

After a fresh installation, /etc/apt/sources.list may be empty, causing apt to fail.  
**Fix:** Copy the latest repositories from [here](https://docs.kali.org/general-use/kali-linux-sources-list-repositories).

### Additional resources

[Building Custom Kali ISOs](https://docs.kali.org/kali-dojo/02-mastering-live-build)  
[Debian live-build](https://manpages.debian.org/testing/live-build/live-build.7.en.html)  
[Kali Linux Metapackages](https://www.kali.org/news/kali-linux-metapackages/)  
[Kali Linux Official Documentation](https://www.kali.org/kali-linux-documentation/)  
[Kali Linux sources.list Repositories](https://docs.kali.org/general-use/kali-linux-sources-list-repositories)  
[Kali Metapackages](https://tools.kali.org/kali-metapackages)  
[Live Build a Custom Kali ISO](https://docs.kali.org/development/live-build-a-custom-kali-iso)  
[Securing and Monitoring Kali](https://kali.training/lessons/7-securing-and-monitoring-kali/)
