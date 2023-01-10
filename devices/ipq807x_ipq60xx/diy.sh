#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

mv -f ../feeds/ipq807x/ipq807x target/linux/
./scripts/feeds install -a -p wifi_ax -f

rm -rf package/feeds/wifi_ax/hostapd

sed -i "/gl_feeds_common/d" feeds.conf
sed -i "/ipq807x/d" feeds.conf
sed -i "/wifi_ax/d" feeds.conf

rm -rf package/feeds/kiddin9/{firewall,rtl*,base-files,netifd,nft-fullcone,mbedtls,oaf,shortcut-fe,simulated-driver,fast-classifier,fullconenat}

rm -rf package/kernel/{nat46,ath10k-ct,mt76,rtl8812au-ct}
rm -rf feeds/packages/net/xtables-addons package/feeds/packages/openvswitch

sed -i "s/PKG_HASH:=.*/PKG_HASH:=skip/" package/feeds/wifi_ax/mac80211/Makefile

rm -rf devices/common/patches/{glinet,imagebuilder.patch,iptables.patch,targets.patch,kernel-defaults.patch,disable_flock.patch}

rm -rf toolchain/musl

svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/toolchain/musl toolchain/musl

svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/network/services/fullconenat feeds/kiddin9/fullconenat

make defconfig