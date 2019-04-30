# Kali Linux Setup Documentation

## Contents
- [Setting up a live-build system](##-setting-up-a-live-build-system)
- Configuring live-build
- Building the image
- Transferring live-build configuration from guest to host for safe-keeping

## Setting up a Kali live-build system

Install Kali Linux in a virtual machine connected to a bridged network (necessary for transfer of image source from guest to host for safe-keeping). Use default Kali installation settings (ie. no encryption or fancy partitioning).

If /etc/apt/sources.list is empty, copy the latest repositories from [here](https://docs.kali.org/general-use/kali-linux-sources-list-repositories).

`apt-get update && apt-get upgrade`

`apt-get install git live-build cdebootstrap`

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

`./build.sh --distribution kali-rolling --variant gnome --verbose`

## Transferring live-build configuration from guest to host for safe-keeping

From the host machine, run

`scp -r root@GUEST_IP:~/live-build/ C:\live-build\`
