#!/bin/bash
SHELL_FOLDER=$(dirname $(readlink -f "$0"))


sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8152/' target/linux/bcm27xx/Makefile

sed -i 's/ factory.img.gz / /' target/linux/bcm27xx/image/Makefile



