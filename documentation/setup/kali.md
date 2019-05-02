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
  - Ensuring everything is up-to-date
  - Configuring dconf schemas
- Installing and configuring zsh and oh-my-zsh
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

### Ensuring everything is up-to-date

`apt-get update && apt-get upgrade`

`apt-get dist-upgrade`

### Configuring system settings

#### Via script ([source](https://github.com/Perdyx/fluffy-fiesta/blob/master/scripts/setup/kali.sh))

`wget https://raw.githubusercontent.com/Perdyx/fluffy-fiesta/master/scripts/setup/kali.sh -O ~/setup.sh`

`chmod +x setup.sh`

`./setup.sh`

#### Manually

Ensure dconf-editor is installed

`apt-get install dconf-editor`

Change time display format

`gsettings set org.gnome.desktop.interface clock-format "12h"`

`gsettings set org.gnome.desktop.calendar show-weekdate "true"`

Turn set up touchpad (only necessary for laptops)

`gsettings set org.gnome.peripherals.touchpad tap-to-click "true"`

Set up extensions

`gnome-shell-extension-tool -e alternate-tab@gnome-shell-extensions.gcampax.github.com`

`gnome-shell-extension-tool -e caffeine@patapon.info`

`gnome-shell-extension-tool -d desktop-icons@csoriano`

`gnome-shell-extension-tool -e disconnect-wifi@kgshank.net`

`gnome-shell-extension-tool -d EasyScreenCast@iacopodeenosee.gmail.com`

`gnome-shell-extension-tool -e impatience@gfxmonk.net`

`gnome-shell-extension-tool -e drive-menu@gnome-shell-extensions.gcampax.github.com`

Configure Dash to Dock

`gsettings set org.gnome.shell.extensions.dash-to-dock require-pressure-to-show "false"`

`gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode "ALL_WINDOWS"`

`gsettings set org.gnome.shell.extensions.dash-to-dock animate-show-apps "false"`

`gsettings set org.gnome.shell.extensions.dash-to-dock click-action "minimize"`

`gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action "switch-workspace"`

`gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink "false"`

`gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode "FIXED"`

`gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity "0"`

## Installing and configuring zsh and oh-my-zsh

### Installing zsh

Install zsh

`apt install zsh`

Set zsh as the default shell

`chsh -s /bin/zsh`

After setting the default shell, a reboot is necessary for the changes to take effect.

### Installing oh-my-zsh

`sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"`

### Installing Pure for zsh

``

## Installing tor services

## Hardening Kali

## Additional resources

[02 - Building Custom Kali ISOs](https://docs.kali.org/kali-dojo/02-mastering-live-build)

[Advanced Package Management in Kali Linux](https://www.kali.org/tutorials/advanced-package-management-in-kali-linux/)

[Kali Linux sources.list Repositories](https://docs.kali.org/general-use/kali-linux-sources-list-repositories)

[live-build(7)](https://manpages.debian.org/testing/live-build/live-build.7.en.html)

[Live Build a Custom Kali ISO](https://docs.kali.org/development/live-build-a-custom-kali-iso)
