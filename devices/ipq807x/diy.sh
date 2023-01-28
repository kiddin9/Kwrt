#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_5.15.sh

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.15 target/linux/generic/hack-5.15

rm -rf feeds/kiddin9/{rtl8821cu,rtl88x2bu} package/kernel/mt76

curl -sfL https://raw.githubusercontent.com/Boos4721/openwrt/master/target/linux/ipq807x/patches-5.15/700-ipq8074-overclock-cpu-2.2ghz.patch -o target/linux/ipq807x/patches-5.15/700-ipq8074-overclock-cpu-2.2ghz.patch

echo "
CONFIG_PACKAGE_kmod-ipt-coova=n
CONFIG_PACKAGE_kmod-pf-ring=n
" >> devices/common/.config

