#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.1.sh

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8152/' target/linux/bcm27xx/Makefile

wget -N https://github.com/RPi-Distro/firmware-nonfree/raw/bullseye/debian/config/brcm80211/brcm/brcmfmac43436-sdio.bin -P files/lib/firmware/brcm/
wget -N https://github.com/RPi-Distro/firmware-nonfree/raw/bullseye/debian/config/brcm80211/brcm/brcmfmac43436-sdio.txt -P files/lib/firmware/brcm/
wget -N https://github.com/RPi-Distro/firmware-nonfree/raw/bullseye/debian/config/brcm80211/brcm/brcmfmac43436s-sdio.bin -P files/lib/firmware/brcm/
wget -N https://github.com/RPi-Distro/firmware-nonfree/raw/bullseye/debian/config/brcm80211/brcm/brcmfmac43436s-sdio.txt -P files/lib/firmware/brcm/
