# Debian Linux Setup (Post-Installation)

## Contents

- [Setting up sudo](#setting-up-sudo)
- [Installing net-tools](#installing-net-tools)
- [Setting up SSH](#setting-up-ssh)
  - [Generate new SSH keys](#generate-new-ssh-keys)
- [Setting up i3wm](#setting-up-i3wm)

## Setting up sudo

Log into the root user

`su`

Install sudo

`apt get install sudo`

Add enable sudo for non-root users

`adduser USER sudo`

Log out and back in again for the changes to take effect.

## Installing net-tools

`sudo apt install net-tools`

## Setting up SSH

`sudo apt install openssh-server`

### Generate new SSH keys

`cd /etc/ssh`

`dpkg-reconfigure openssh-server`

## Setting up i3wm

Install i3 and additional software

`sudo apt install i3 xorg rxvt-unicode`

After login, use `startx` to launch i3.

**NOTE:** For changes to ~/.Xresources to take effect, run `xrdb -merge ~/.Xresources`
