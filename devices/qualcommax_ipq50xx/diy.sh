#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k-firmware target/linux/qualcommax target/linux/generic package/kernel/mac80211 package/kernel/qca-ssdk package/kernel/qca-nss-dp

git_clone_path main https://github.com/openwrt/openwrt target/linux/qualcommax target/linux/generic package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k-firmware package/kernel/mac80211 package/kernel/qca-ssdk package/kernel/qca-nss-dp

wget -N https://github.com/openwrt/openwrt/raw/main/include/kernel-6.6 -P include/

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/generic/hack-6.6
rm -rf target/linux/generic/hack-6.6/929-Revert-genetlink* target/linux/generic/hack-6.6/767-net-phy-realtek-add-led*
wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.6/613-netfilter_optional_tcp_window_check.patch -P target/linux/generic/pending-6.6/