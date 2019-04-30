# Kali Linux Setup Documentation

## Contents

- Setting up a live-build system
- Configuring live-build
- Building the image
- Back up the live-build configuration

## Setting up a Kali live-build system

Install Kali Linux in a virtual machine connected to a bridged network (necessary for transfer of image source from guest to host for safe-keeping). Use default Kali installation settings (ie. no encryption or fancy partitioning).

Update and upgrade the system

`apt-get update && apt-get upgrade`

If this fails, /etc/apt/sources.list is probably empty. Copy the latest repositories from [here](https://docs.kali.org/general-use/kali-linux-sources-list-repositories).

Install the necessary tools

`apt-get install git live-build cdebootstrap`

Clone the Kali live-build repository

`git clone git://git.kali.org/live-build-config.git && cd live-build-config`

## Configuring Kali live-build

### Configure package lists

Edit ~/live-build-config/kali-config/variant-gnome/package-lists/kali.list.chroot:

#### Add:

- kali-linux-top10
- git
- gnome-shell-extension-autohidetopbar
- gnome-shell-extension-caffeine
- gnome-shell-extension-disconnect-wifi
- gnome-shell-extension-impatience
- gnome-shell-extension-remove-dropdown-arrows
- vim
- htop

#### Remove:

- kali-linux-full

## Building the image

`chmod +x build.sh`

`./build.sh --distribution kali-rolling --variant gnome --verbose`

## Back up the live-build configuration

Edit /etc/ssh/sshd_config to replace

`PermitRootLogin prohibit-password`

with

`PermitRootLogin yes.`

Restart the ssh server

`service ssh restart`

From the host machine, run

`scp -r root@GUEST_IP:~/live-build/images/kali-linux-gnome-rolling-amd64.iso C:\kali-linux-gnome-rolling-amd64.iso`

If an error appears stating that remote host identification has failed, run

`ssh-keygen -R GUEST_IP`
