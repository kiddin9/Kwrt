#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/kernel package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k-firmware target/linux/qualcommax target/linux/generic

git_clone_path main https://github.com/openwrt/openwrt package/kernel target/linux/qualcommax target/linux/generic package/boot/uboot-tools package/firmware/ipq-wifi package/firmware/ath11k-firmware

wget -N https://github.com/openwrt/openwrt/raw/main/target/linux/generic/kernel-6.12 -P include/

wget -N https://github.com/immortalwrt/immortalwrt/raw/refs/heads/master/package/network/utils/fullconenat-nft/patches/010-fix-build-with-kernel-6.12.patch -P package/feeds/kiddin9/fullconenat-nft/patches/

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/generic/hack-6.12

wget -N https://github.com/coolsnowwolf/lede/raw/refs/heads/master/target/linux/generic/pending-6.12/613-netfilter_optional_tcp_window_check.patch -P target/linux/generic/pending-6.12/

rm -rf package/feeds/kiddin9/{simulated-driver,fast-classifier,xtables-wgobfs} package/devel/perf package/feeds/packages/{ovpn-dco,xr_usb_serial_common,openvswitch,xtables-addons}