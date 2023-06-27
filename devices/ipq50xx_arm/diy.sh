#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/feeds/kiddin9/rtl* feeds/kiddin9/{shortcut-fe,fullconenat-nft,dnsmasq,fibocom_QMI_WWAN} package/kernel/mt76 package/kernel/exfat package/feeds/packages/{fuse*,gl-mifi-mcu,jool,siit,libpfring,xr_usb_serial_common,xtables-addons} package/feeds/luci/ucode-mod-html package/feeds/luci/rpcd-mod-luci package/kernel/nat46 package/kernel/ath10k-ct package/devel/perf

rm -rf devices/common/patches/{fix.patch,iptables.patch,kernel-defaults.patch,targets.patch}

rm -rf toolchain/musl package/utils/e2fsprogs package/libs/libselinux package/feeds/packages/acl

svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/toolchain/musl toolchain/musl
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/package/utils/e2fsprogs package/utils/e2fsprogs
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/package/libs/libselinux package/libs/libselinux
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/package/utils/ucode package/utils/ucode
#ln -sf $(pwd)/feeds/luci/modules/luci-base package/feeds/kiddin9/