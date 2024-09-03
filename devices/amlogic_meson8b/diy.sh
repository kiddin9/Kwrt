#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

rm -rf package/kernel/mac80211

git_clone_path c640f7b93736621b4d56627e4f6ab824093f9c3d https://github.com/openwrt/openwrt package/kernel/mac80211

git_clone_path main https://github.com/shiyu1314/openwrt-onecloud kernel/6.1/amlogic && mv -f kernel/6.1/amlogic target/linux/

sed -i "s/wpad-openssl/wpad-basic-mbedtls/" target/linux/amlogic/image/meson8b.mk


