#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/amlogic package/boot/uboot-amlogic

rm -rf package/kernel/mac80211

git_clone_path c640f7b93736621b4d56627e4f6ab824093f9c3d https://github.com/openwrt/openwrt package/kernel/mac80211

sed -i "s/wpad-openssl/wpad-basic-mbedtls/" target/linux/amlogic/image/meson8b.mk

rm -rf package/kernel/r8125 package/kernel/r8126 package/kernel/r8168

