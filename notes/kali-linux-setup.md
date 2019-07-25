# Kali Linux Setup

## Contents

- [Description](#description)
- [Requirements](#requirements)
- [Preparing the installation media](#preparing-the-installation-media)
- [Installing the system](#installing-the-system)
- [Setting up the system](#setting-up-the-system)
  - [Creating a non-root user](#creating-a-non-root-user)
  - [Update](#update)
  - [Generate new SSH keys](#generating-new-ssh-keys)
  - [Installing Tor (optional)](#installing-tor)
- [Troubleshooting](#troubleshooting)
  - [Known issues](#known-issues)
  - [Additional resources](#additional-resources)

## Description

This documentation outlines the steps to install and configure [Kali Linux](https://www.kali.org/) for use as a primary penetration testing system on various platforms.

**NOTE:** This documentation is intended for personal use and may result in undesired functionality.

## Requirements

- Reliable internet connection
- Any Linux-compatible x64-based system with at least a 32 GB storage capacity

## Preparing the installation media

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

### Generate new SSH keys

`cd /etc/ssh/`

`dpkg-reconfigure openssh-server`

### Installing Tor (optional)

Tor is included in the official Kali repositories, however it is not regularily updated. Tor should be downloaded from the [source](https://www.torproject.org/) to ensure it is fully up to date.

Add the source repository to /etc/apt/sources.list.

`echo 'deb https://deb.torproject.org/torproject.org stretch main' > /etc/apt/sources.list.d/tor.list`

`echo 'deb-src https://deb.torproject.org/torproject.org stretch main' >> /etc/apt/sources.list.d/tor.list`

Import the Tor project signing key to the apt keyring.

`wget -O- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | sudo apt-key add -`

Update and install Tor.

`apt-get update`

`apt-get install tor deb.torproject.org-keyring`

## Troubleshooting

### Known issues

After a fresh installation, /etc/apt/sources.list may be empty, causing apt to fail.  
**Fix:** Copy the latest repositories from [here](https://docs.kali.org/general-use/kali-linux-sources-list-repositories).

### Additional resources

[Kali Linux Official Documentation](https://www.kali.org/kali-linux-documentation/)<br>
[Kali Linux sources.list Repositories](https://docs.kali.org/general-use/kali-linux-sources-list-repositories)<br>
[Securing and Monitoring Kali](https://kali.training/lessons/7-securing-and-monitoring-kali/)<br>
[Top 10 Things to Do After Installing Kali Linux](https://null-byte.wonderhowto.com/how-to/top-10-things-do-after-installing-kali-linux-0186450/)
