#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sed -i '/postgres=5432/d' feeds/packages.index
sed -i '/postgres=5432/d' feeds/packages/net/gnunet/Makefile
./scripts/feeds install -a

sed -i "s/make-ext4fs missing-macros/make-ext4fs meson missing-macros/" tools/Makefile
curl -sfL https://raw.githubusercontent.com/openwrt/openwrt/openwrt-22.03/include/meson.mk -o include/meson.mk
svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/tools/meson tools/meson

rm -rf package/feeds/kiddin9/rtl*

sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2024-12-06/" package/network/config/netifd/Makefile

rm -rf devices/common/patches/{glinet,fix.patch,iptables.patch,kernel-defaults.patch,targets.patch}

rm -rf toolchain/musl

svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/toolchain/musl toolchain/musl
