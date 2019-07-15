# Arch Linux Installation

## Contents

- [Installing Arch](#installing-arch)
  - [Preparation](#preparation)
  - [Installation](#installation)
  - [Post-installation](#post-installation)
- [Configuring Arch](#configuring-arch)
  - [Users and Groups](#users-and-groups)
  - [Setting up SSH](#setting-up-ssh)
  - [Installing yay](#installing-yay)

## Installing Arch

### Preparation

Disbale UEFI and secure boot before proceeding as they sometimes cause problems and boot the arch installation media from a thumb drive. Root autologin is enabled by default.

Plug in an ethernet cable and ensure you are connected to the internet

`ping 8.8.8.8`

Update system clock

`timedatectl set-ntp true`

Partition the disk

`cfdisk /dev/sdX`

Delete any old partitions and create a boot partition. 1GB is overkill, but it never hurts to be safe. Don't forget to set the partition type to "BIOS Boot." A swap partition is generally not necessary anymore, but if you still want one or you are running low-spec hardware, go ahead and create it now. Initialize it with

`swapon /dev/sdX2`

The rest of the drive can be allocated to a singular primary partition, or it can be split to your liking.

Mount the filesystem

`mount /dev/sdX1 /mnt`

### Installation

Install the base system. Feel free to include any additional packages you want

`pacstrap /mnt base base-devel`

Generate the fstab

`genfstab -U /mnt >> /mnt/etc/fstab`

### Post-installation

Chroot into the installation

`arch-chroot /mnt`

Set the time zone. For a list of available options, type `ls /user/share/zoneinfo`

`ln -sf /usr/share/zoneinfo/Region/City /etc/localtime`

`hwclock --systohc`

Uncomment `en_US.UTF-8 UTF-8` in /etc/locale.gen and run

`locale-gen`

Then add the following to /etc/locale.conf

`LANG=en_US.UTF-8`

Install networkmanager and enable the service

`pacman -S networkmanager`

`systemctl enable NetworkManager`

Create /etc/hostname with the following contents, replacing `HOSTNAME` with your desired hostname

`HOSTNAME`

Exit the chroot environment

`exit`

Unmount the filesystem

`umount -R /mnt`

Reboot (don't forget to remove the installation media).

`reboot`

## Configuring Arch

### Users and groups

Start by logging into the root account. Set a passwd using

`passwd`

Add a new user and give it a password

`useradd -m USERNAME`

`passwd USERNAME`

Give the new user administrator priviledges by adding the following below `root ALL=(ALL) ALL`, replacing `USERNAME` with the name of the new user.

`USERNAME ALL=(ALL) ALL`

Log out and back in again for the changes to take effect.

### Setting up SSH

Install SSH

`pacman -S openssh`

Allow the SSH server to start on boot (optional)

`sudo systemctl enable sshd`

### Installing yay

`git clone https://aur.archlinux.org/yay.git`

`cd yay`

`makepkg -si`

`cd .. && rm -r yay`
