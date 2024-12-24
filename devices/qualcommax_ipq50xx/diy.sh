#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf target/linux/qualcommax package/firmware/ath11k-firmware package/firmware/ipq-wifi package/kernel/mac80211 package/kernel/qca-nss-dp package/kernel/qca-ssdk package/boot/uboot-envtools package/network/utils/iwinfo
git_clone_path main https://github.com/georgemoussalem/openwrt-fork target/linux/qualcommax package/firmware/ath11k-firmware package/firmware/ipq-wifi package/kernel/mac80211 package/kernel/qca-nss-dp package/kernel/qca-ssdk package/boot/uboot-envtools package/network/utils/iwinfo
