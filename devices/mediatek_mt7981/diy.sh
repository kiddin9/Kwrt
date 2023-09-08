#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/feeds/kiddin9/rtl* package/feeds/packages/gptfdisk package/utils/f2fs-tools

rm -rf devices/common/patches/{fix.patch,iptables.patch,kernel-defaults.patch,targets.patch}

sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2099-12-06/" package/network/config/netifd/Makefile

rm -rf toolchain/musl package/utils/e2fsprogs package/libs/libselinux package/feeds/packages/acl package/feeds/luci/ucode-mod-html package/feeds/luci/rpcd-mod-luci

svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/toolchain/musl toolchain/musl
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/package/utils/e2fsprogs package/utils/e2fsprogs
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/package/libs/libselinux package/libs/libselinux
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/package/utils/ucode package/utils/ucode
#ln -sf $(pwd)/feeds/luci/modules/luci-base package/feeds/kiddin9/

sed -i "s/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-mtk mii_mgr wifi-profile mtkhqos_util wireless-regdb switch regs kmod-warp kmod-mt_wifi kmod-mediatek_hnat kmod-conninfra datconf-lua/" target/linux/mediatek/Makefile
