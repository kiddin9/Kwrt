#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_5.15.sh

rm -rf feeds/kiddin9/{rtl8821cu,rtl88x2bu} package/kernel/mt76

git clone https://github.com/robimarko/nss-packages --depth 1 package/nss-packages


echo "
CONFIG_PACKAGE_kmod-ipt-coova=n
CONFIG_PACKAGE_kmod-pf-ring=n
" >> devices/common/.config

