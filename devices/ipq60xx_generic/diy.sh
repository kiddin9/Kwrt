#!/bin/bash
shopt -s extglob

rm -rf package/system/opkg && mv -f feeds/kiddin9/opkg package/system/
rm -rf feeds/kiddin9/{rtl*,nft-fullcone,shortcut-fe,fullconenat} package/kernel/mt76 toolchain/musl package/feeds/packages/{jool,xtables-addons,openvswitch}

rm -rf target/imagebuilder
svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/target/imagebuilder target/imagebuilder
sed -i "/libfakeroot/d" target/imagebuilder/Makefile

svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/toolchain/musl toolchain/musl

svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/network/services/fullconenat feeds/kiddin9/fullconenat

rm -rf devices/common/patches/{targets.patch,kernel-defaults.patch,fix.patch,iptables.patch,disable_flock.patch}


