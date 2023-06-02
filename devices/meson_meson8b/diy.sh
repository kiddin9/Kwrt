#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf target/linux/generic feeds/routing/batman-adv

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic target/linux/generic
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/meson target/linux/meson

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/include/kernel-5.10 -o include/kernel-5.10

svn co https://github.com/openwrt/routing/branches/openwrt-22.03/batman-adv feeds/routing/batman-adv
