# Debian Linux Setup (Post-Installation)

## Contents

- [Setting up sudo](#setting-up-sudo)
- [Setting up SSH](#setting-up-ssh)
  - [Generate new SSH keys](#generate-new-ssh-keys)
- [Installing i3](#installing-i3)

## Setting up sudo

Log into the root user

`su`

Install sudo

`apt get install sudo`

Add enable sudo for non-root users

`adduser USER sudo`

Log out and back in again for the changes to take effect.

## Setting up SSH

`sudo apt install openssh-server`

### Generate new SSH keys

`cd /etc/ssh`

`dpkg-reconfigure openssh-server`

## Installing i3

`sudo apt install i3 xorg`

After login, use `startx` to launch i3.