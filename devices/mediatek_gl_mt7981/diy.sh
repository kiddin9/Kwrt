#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/feeds
./scripts/feeds install -a -p gl_feed_mtk -f
./scripts/feeds install -a -p gl_feed_common -f
./scripts/feeds install -a -p gl_feed_21_02 -f
./scripts/feeds install -a -p mtk_openwrt_feed -f
./scripts/feeds install -a -p kiddin9 -f
./scripts/feeds install -a

rm -rf package/feeds/kiddin9/{firewall,rtl*,base-files,netifd}

rm -rf devices/common/patches/{imagebuilder.patch,fix.patch,iptables.patch,targets.patch,kernel-defaults.patch,disable_flock.patch}

sed -i "s/BOARD:=mediatek$/BOARD:=mediatek_gl/" target/linux/mediatek/Makefile

mv -f target/linux/mediatek target/linux/mediatek_gl

rm -rf toolchain/musl

svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/toolchain/musl toolchain/musl

echo "
CONFIG_FEED_gl_feed_mtk=n
CONFIG_FEED_gl_feed_common=n
CONFIG_FEED_gl_feed_21_02=n
CONFIG_FEED_mtk_openwrt_feed=n
" >> devices/common/.config


