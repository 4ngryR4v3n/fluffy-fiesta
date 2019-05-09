# Setting up Kali Linux

## Contents

- Description
- Requirements
- Preparing installation media
- Installing the system
- Setting up the system
  - Creating a non-root user
  - Update
- Troubleshooting
  - Known issues
  - Additional resources

## Description

This documentation outlines the steps necessary to install and configure [Kali Linux](https://www.kali.org/) for use as a primary penetration testing system.

**NOTE:** This documentation is intended for personal use and may result in undesired functionality.

## Requirements

- Reliable internet connection
- Any Linux-compatible x64-based system with at least a 32 GB storage capacity

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

[Kali Linux Official Documentation](https://www.kali.org/kali-linux-documentation/)  
[Kali Linux sources.list Repositories](https://docs.kali.org/general-use/kali-linux-sources-list-repositories)  
[Securing and Monitoring Kali](https://kali.training/lessons/7-securing-and-monitoring-kali/)
