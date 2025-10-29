#!/bin/bash

shopt -s extglob

rm -rf package/kernel
git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic/backport-6.1 target/linux/generic/hack-6.1 target/linux/generic/pending-6.1 target/linux/amlogic package/boot/uboot-amlogic package/kernel

rm -rf package/kernel/bpf-headers
git_clone_path openwrt-24.10 https://github.com/openwrt/openwrt package/kernel/bpf-headers

sed -i "s/autocore-arm/autocore/" target/linux/amlogic/Makefile

wget -N https://github.com/coolsnowwolf/lede/raw/refs/heads/master/include/kernel-6.1 -P include/

rm -rf feeds/routing/batman-adv package/kernel/rtw88-usb

echo '
CONFIG_BLK_DEV_INTEGRITY=n
' >> target/linux/amlogic/mesongx/config-6.1



