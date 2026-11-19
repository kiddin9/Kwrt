#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.1.sh

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8152/' target/linux/bcm27xx/Makefile


