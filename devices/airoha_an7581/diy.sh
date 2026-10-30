#!/bin/bash

shopt -s extglob

rm -rf package/boot target/linux/airoha/!(patches-6.12) package/firmware/linux-firmware

git_clone_path airoha-gemtek-xr1710g https://github.com/akorshun/openwrt package/boot package/firmware/rtl826x-firmware package/firmware/linux-firmware
git_clone_path airoha-gemtek-xr1710g https://github.com/akorshun/openwrt mv target/linux/airoha

wget -N https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-25.12/target/linux/airoha/an7581/config-6.12 -P target/linux/airoha/an7581/
wget -N https://github.com/openwrt/openwrt/raw/refs/heads/main/target/linux/airoha/patches-6.18/609-01-dt-bindings-clock-airoha-Add-additional-reset-for-PC.patch -P target/linux/airoha/patches-6.12/

sed -i "s/6.18/6.12/" target/linux/airoha/Makefile