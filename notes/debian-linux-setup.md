# Debian Linux Setup (Post-Installation)

## Contents

- [Setting up sudo](#setting-up-sudo)
- [Configuring sources](#configuring-sources)
- [Installing wireless drivers (Thinkpad T430s)](#installing-wireless-drivers-thinkpad-t430s)
- [Installing common CLI utilities](#installing-common-cli-utilities)
- [Setting up SSH](#setting-up-ssh)
  - [Generate new SSH keys](#generate-new-ssh-keys)
- [Setting up i3wm](#setting-up-i3wm)
  - [Installing Chrome](#installing-chrome)

## Setting up sudo

Log into the root user

`su`

Install sudo

`apt get install sudo`

Add enable sudo for non-root users

`adduser USER sudo`

Log out and back in again for the changes to take effect.

## Configuring Sources

Replace the contents of /etc/apt/sources.list with the following

```
deb http://deb.debian.org/debian stretch main contrib non-free
deb-src http://deb.debian.org/debian stretch main contrib non-free

deb http://deb.debian.org/debian-security/ stretch/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ stretch/updates main contrib non-free

deb http://deb.debian.org/debian stretch-updates main contrib non-free
deb-src http://deb.debian.org/debian stretch-updates main contrib non-free
```

Update and upgrade

`sudo apt-get update && sudo apt-get upgrade`

## Installing wireless drivers (Thinkpad T430s)

`sudo apt install firmware-iwlwifi`

## Installing common CLI utilities

`sudo apt install htop net-tools`

## Setting up SSH

`sudo apt install openssh-server`

### Generate new SSH keys

`cd /etc/ssh`

`dpkg-reconfigure openssh-server`

## Setting up i3wm

Install i3

`sudo apt install i3 xorg`

Install recommended software (optional)

`sudo apt install rxvt-unicode hsetroot feh compton ranger`

After login, use `startx` to launch i3.

**NOTE:** For changes to ~/.Xresources to take effect, run `xrdb -merge ~/.Xresources`

### Installing Chrome

`wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb`

`sudo apt install ./google-chrome-stable_current_amd64.deb`

`rm google-chrome-stable_current_amd64.deb`
