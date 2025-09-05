#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/firmware/ipq-wifi target/linux/qualcommax target/linux/generic package/kernel package/firmware/ath11k-firmware

git_clone_path main https://github.com/openwrt/openwrt target/linux/qualcommax target/linux/generic package/kernel package/boot package/firmware/ipq-wifi package/firmware/ath11k-firmware

wget -N https://github.com/openwrt/openwrt/raw/refs/heads/main/include/kernel-version.mk -P include/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/main/include/image-commands.mk -P include/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/main/scripts/mkits-qsdk-ipq-image.sh -P scripts/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/main/config/Config-kernel.in -P config/

rm -rf feeds/kiddin9/xtables-wgobfs package/devel/perf package/feeds/packages/{ovpn-dco,xr_usb_serial_common,openvswitch,xtables-addons}

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/generic/hack-6.12
wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/refs/heads/master/target/linux/generic/pending-6.12/613-netfilter_optional_tcp_window_check.patch -P target/linux/generic/pending-6.12/

