# Kali Linux Setup

## Contents

- Description
- Requirements
- Setting up the live-build system
  - Configuring the package list
- Building the image
  - Configuring ssh for host-guest communication
  - Transferring the image to the host machine via scp
- Preparing installation media
- Setting up the system
  - Creating a non-root user
  - Ensuring everything is up-to-date
  - Configuring dconf schemas
- Installing tor services
- Hardening Kali
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

If this fails, /etc/apt/sources.list is probably empty. Copy the latest repositories from [here](https://docs.kali.org/general-use/kali-linux-sources-list-repositories).

Install the necessary tools

`apt-get install git live-build cdebootstrap`

Clone the Kali live-build repository

`git clone git://git.kali.org/live-build-config.git && cd live-build-config`

### Configuring the package list

Replace live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot with that of your desired variant.

#### Development ([source](https://github.com/Perdyx/fluffy-fiesta/blob/master/configs/kali/variants/development/live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot))

`wget https://raw.githubusercontent.com/Perdyx/fluffy-fiesta/master/configs/kali/variants/development/live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot -O kali-config/variant-gnome/package-lists/kali.list.chroot`

#### Pentesting ([source](https://github.com/Perdyx/fluffy-fiesta/blob/master/configs/kali/variants/pentesting/live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot))

`wget https://raw.githubusercontent.com/Perdyx/fluffy-fiesta/master/configs/kali/variants/pentesting/live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot -O kali-config/variant-gnome/package-lists/kali.list.chroot`

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

**WARNING:** The following actions will overwrite any data on the disk. Back up any important data before proceeding.

In order to ensure speed and reliability during installation, a wired internet connection on the target system is recommended.

For extra security, select "Separate /home, /usr, /var, and /tmp partitions" and "Guided- use entire disk and set up encrypted LVM" when prompted.

## Setting up the system

After the installation completes and the system reboots, log into the root user and open a terminal.

### Creating a non-root user

Add a new user

`useradd -m USERNAME`

**NOTE:** The -m flag creates a home directory for the new user (this is recommended, but not necessary).

Set a password for the new user. It is best practice to set this to something other than the root or disk encryption passwords

`passwd USERNAME`

Add the new user to the "sudoers" group

`usermod -a -G sudo USERNAME`

Specify a default shell for the new user

`chsh -s /bin/bash`

Log out and log back in as the new user before proceeding.

### Ensuring everything is up-to-date

`sudo apt-get update && apt-get upgrade`

`sudo apt-get dist-upgrade`

### Configuring system settings

#### Via script ([source](https://github.com/Perdyx/fluffy-fiesta/blob/master/scripts/setup/kali.sh))

From the home directory, execute

`wget https://raw.githubusercontent.com/Perdyx/fluffy-fiesta/master/scripts/setup/kali.sh -O ~/setup.sh`

`chmod +x setup.sh`

`sudo ./setup.sh`

#### Manually

Ensure dconf-editor is installed

`sudo apt-get install dconf-editor`

Change time display format

`sudo gsettings set org.gnome.desktop.interface clock-format "12h"`

`sudo gsettings set org.gnome.desktop.calendar show-weekdate "true"`

Turn set up touchpad (only necessary for laptops)

`sudo gsettings set org.gnome.peripherals.touchpad tap-to-click "true"`

Set up extensions

`sudo gnome-shell-extension-tool -e alternate-tab@gnome-shell-extensions.gcampax.github.com`

`sudo gnome-shell-extension-tool -e caffeine@patapon.info`

`sudo gnome-shell-extension-tool -d desktop-icons@csoriano`

`sudo gnome-shell-extension-tool -e disconnect-wifi@kgshank.net`

`sudo gnome-shell-extension-tool -d EasyScreenCast@iacopodeenosee.gmail.com`

`sudo gnome-shell-extension-tool -e impatience@gfxmonk.net`

`sudo gnome-shell-extension-tool -e drive-menu@gnome-shell-extensions.gcampax.github.com`

Configure Dash to Dock

`sudo gsettings set org.gnome.shell.extensions.dash-to-dock require-pressure-to-show "false"`

`sudo gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode "ALL_WINDOWS"`

`sudo gsettings set org.gnome.shell.extensions.dash-to-dock animate-show-apps "false"`

`sudo gsettings set org.gnome.shell.extensions.dash-to-dock click-action "minimize"`

`sudo gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action "switch-workspace"`

`sudo gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink "false"`

`sudo gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode "FIXED"`

`sudo gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity "0"`

## Installing tor services

## Hardening Kali

## Further configuration

Set up any custom dotfiles (terminator, vim, etc.). Check out [https://github.com/Perdyx/fluffy-fiesta/tree/master/configs](https://github.com/Perdyx/fluffy-fiesta/tree/master/configs).

## Additional resources

[02 - Building Custom Kali ISOs](https://docs.kali.org/kali-dojo/02-mastering-live-build)

[Advanced Package Management in Kali Linux](https://www.kali.org/tutorials/advanced-package-management-in-kali-linux/)

[Kali Linux sources.list Repositories](https://docs.kali.org/general-use/kali-linux-sources-list-repositories)

[live-build(7)](https://manpages.debian.org/testing/live-build/live-build.7.en.html)

[Live Build a Custom Kali ISO](https://docs.kali.org/development/live-build-a-custom-kali-iso)
