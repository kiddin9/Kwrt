#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

kernel_v="$(cat include/kernel-version.mk | grep LINUX_KERNEL_HASH-5.* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
sed -i "s?targets/%S/.*'?targets/%S/$kernel_v'?" include/feeds.mk

rm -rf package/feeds/kiddin9/{firewall,rtl88x2bu,base-files,netifd}

rm -rf devices/common/patches/{glinet,imagebuilder.patch,iptables.patch,targets.patch,kernel-defaults.patch,disable_flock.patch}

sed -i "s/BOARD:=mediatek$/BOARD:=mediatek_gl/" target/linux/mediatek/Makefile

mv -f target/linux/mediatek target/linux/mediatek_gl

