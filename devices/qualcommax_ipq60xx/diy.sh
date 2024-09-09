#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

rm -rf target/linux/qualcommax target/linux/generic/!(*-5.15) package/kernel/qca-* package/kernel/mac80211 devices/common/patches/qca-ssdk.patch package/boot/uboot-envtools package/firmware/ipq-wifi
git_clone_path master https://github.com/coolsnowwolf/lede target/linux/qualcommax package/firmware/ipq-wifi package/boot/uboot-envtools package/qca

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/generic

git_clone_path c640f7b93736621b4d56627e4f6ab824093f9c3d https://github.com/openwrt/openwrt package/kernel/mac80211

wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-6.1 -P include/

sed -i "s/wpad-openssl/wpad-basic-mbedtls/" target/linux/qualcommax/Makefile

sed -i "s/OpenWrt/Kwrt/g" package/base-files/files/bin/config_generate package/base-files/image-config.in config/Config-images.in Config.in include/u-boot.mk include/version.mk package/network/config/wifi-scripts/files/lib/wifi/mac80211.sh || true




