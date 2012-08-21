#!/bin/bash -e

umask 022

export DEBIAN_FRONTEND=noninteractive

# update packages
aptitude update
aptitude safe-upgrade -q -y

# vbox guest additions
aptitude install -y build-essential

ver_virtualbox="$(cat .vbox_version)"
url_guestadditions="http://download.virtualbox.org/virtualbox/$ver_virtualbox/VBoxGuestAdditions_$ver_virtualbox.iso"
pth_guestadditions="$HOME/VBoxGuestAdditions_$ver_virtualbox.iso"
wget -nv -O "$pth_guestadditions" "$url_guestadditions"
mount -o loop "$pth_guestadditions" /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -f "$pth_guestadditions"

# udev cleanup
rm -rf /etc/udev/rules.d/70-persistent-net.rules
mkdir -p /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm -rf /lib/udev/rules.d/75-persistent-net-generator.rules

# dhcp cleanup
rm -f /var/lib/dhcp3/*
