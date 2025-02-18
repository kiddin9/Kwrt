#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k-firmware target/linux/qualcommax package/kernel/mac80211 package/kernel/qca-ssdk package/kernel/qca-nss-dp

git_clone_path main https://github.com/openwrt/openwrt package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k-firmware package/kernel/mac80211 package/kernel/qca-ssdk package/kernel/qca-nss-dp

git_clone_path 411df8fbc449175b0f46cf0dab229a16176ed067 https://github.com/openwrt/openwrt target/linux/qualcommax