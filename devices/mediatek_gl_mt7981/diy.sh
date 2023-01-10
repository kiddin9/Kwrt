#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/feeds/kiddin9/{firewall,rtl*,base-files,netifd}

rm -rf devices/common/patches/{glinet,imagebuilder.patch,iptables.patch,targets.patch,kernel-defaults.patch,disable_flock.patch}

sed -i "s/BOARD:=mediatek$/BOARD:=mediatek_gl/" target/linux/mediatek/Makefile

mv -f target/linux/mediatek target/linux/mediatek_gl

rm -rf toolchain/musl

svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/toolchain/musl toolchain/musl


sed -i "/mtk_openwrt_feed/d" feeds.conf
sed -i "/gl_feed_common/d" feeds.conf
sed -i "/gl_feed_21_02/d" feeds.conf


