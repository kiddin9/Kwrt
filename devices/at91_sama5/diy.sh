#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += -luci-app-gpsysupgrade fdisk lsblk btrfs-progs block-mount blkid parted dosfstools e2fsprogs pv losetup uuidgen automount tune2fs resize2fs/' target/linux/at91/Makefile

rm -rf target/linux/at91/base-files/etc/config


