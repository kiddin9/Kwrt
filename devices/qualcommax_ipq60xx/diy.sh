#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/firmware package/boot/uboot-envtools package/kernel/mac80211 package/kernel/qca-* package/kernel/nat46 target/linux/qualcommax

git_clone_path openwrt-24.10 https://github.com/LiBwrt-op/openwrt-6.x package/firmware package/boot/uboot-envtools package/kernel/mac80211 package/kernel/qca-nss-dp package/kernel/qca-ssdk package/kernel/nat46 target/linux/qualcommax

git clone https://github.com/qosmio/nss-packages package/feeds/nss-packages
git clone https://github.com/qosmio/sqm-scripts-nss package/feeds/sqm-scripts-nss

rm -rf feeds/kiddin9/shortcut-fe

rm -rf target/linux/generic/pending-6.6/613-netfilter_optional_tcp_window_check.patch target/linux/generic/hack-6.6/{952-add-net-conntrack-events-support-multiple-registrant.patch,953-net-patch-linux-kernel-to-support-shortcut-fe.patch}