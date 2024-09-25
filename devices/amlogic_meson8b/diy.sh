#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.1.sh

#rm -rf package/kernel/mac80211

#git_clone_path c640f7b93736621b4d56627e4f6ab824093f9c3d https://github.com/openwrt/openwrt package/kernel/mac80211

git_clone_path main https://github.com/shiyu1314/openwrt-onecloud kernel/amlogic && mv -f kernel/amlogic target/linux/

sed -i "s/CPU_SUBTYPE:=neon-vfpv4/CPU_SUBTYPE:=vfpv4/" target/linux/amlogic/meson8b/target.mk

sed -i "s/wpad-openssl/wpad-basic-mbedtls/" target/linux/amlogic/image/Makefile


