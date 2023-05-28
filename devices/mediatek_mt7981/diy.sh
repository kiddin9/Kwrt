#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/feeds/kiddin9/rtl*

rm -rf devices/common/patches/{fix.patch,iptables.patch,kernel-defaults.patch,targets.patch}

sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2024-12-06/" package/network/config/netifd/Makefile

rm -rf toolchain/musl package/utils/e2fsprogs package/libs/libselinux package/feeds/packages/acl

svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/toolchain/musl toolchain/musl
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/package/utils/e2fsprogs package/utils/e2fsprogs
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/package/libs/libselinux package/libs/libselinux
ln -sf $(pwd)/feeds/luci/modules/luci-base package/feeds/kiddin9/
