#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf target/linux/ipq807x
mv -f ../feeds/ipq807x/ipq807x target/linux/

rm -rf package/feeds
./scripts/feeds install -a -p ipq807x -f
./scripts/feeds install -a -p wifi_ax -f
./scripts/feeds install -a -p gl_feeds_common -f
./scripts/feeds install -a -p kiddin9 -f
./scripts/feeds install -a

echo "
CONFIG_FEED_gl_feeds_common=n
CONFIG_FEED_ipq807x=n
CONFIG_FEED_wifi_ax=n
" >> devices/common/.config

rm -rf package/feeds/kiddin9/{firewall,rtl*,base-files,netifd,fullconenat-nft,fullconenat-nft,mbedtls,oaf,shortcut-fe,simulated-driver,fast-classifier,fullconenat}
svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/network/services/fullconenat feeds/kiddin9/fullconenat

rm -rf package/kernel/{ath10k-ct,mt76,rtl8812au-ct}
rm -rf feeds/packages/net/xtables-addons package/feeds/packages/{openvswitch,ksmbd} package/feeds/routing/batman-adv

rm -rf devices/common/patches/{glinet,imagebuilder.patch,fix.patch,iptables.patch,targets.patch,kernel-defaults.patch,disable_flock.patch}

rm -rf toolchain/musl

svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/toolchain/musl toolchain/musl

make defconfig
