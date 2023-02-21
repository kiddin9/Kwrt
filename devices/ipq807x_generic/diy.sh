#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_5.15.sh

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.15 target/linux/generic/hack-5.15
svn co https://github.com/robimarko/nss-packages/tree/main/qca/qca-ssdk-shell package/network/utils/qca-ssdk-shell

rm -rf feeds/kiddin9/{rtl8821cu,rtl88x2bu} package/kernel/mt76

echo "
CONFIG_PACKAGE_kmod-ipt-coova=n
CONFIG_PACKAGE_kmod-pf-ring=n
" >> devices/common/.config

