#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

git clone https://github.com/robimarko/nss-packages package/nss-packages
svn co https://github.com/coolsnowwolf/lede/trunk/package/qca package/nss-packages/qca
mv -f package/nss-packages/qca/nss/* package/nss-packages/qca/
rm -rf package/nss-packages/qca/qca-ssdk package/nss-packages/qca/qca-nss-dp package/nss-packages/qca/qca-*-64 package/nss-packages/qca/nss

sed -i "/DEPENDS:/d" package/nss-packages/qca/qca-nss-drv/Makefile

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-qca-nss-drv kmod-qca-nss-ecm-standard kmod-qca-nss-gmac kmod-qca-nss-drv-pppoe kmod-qca-mcs/' target/linux/ipq806x/Makefile