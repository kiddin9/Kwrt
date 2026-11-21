#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.1.sh

#rm -rf package/kernel/mac80211

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/amlogic

mv -f target/linux/amlogic/patches-6.18 target/linux/amlogic/patches-6.12
mv -f target/linux/amlogic/files-6.18 target/linux/amlogic/files-6.12
mv -f target/linux/amlogic/config-6.18 target/linux/amlogic/config-6.12
mv -f target/linux/amlogic/meson8b/config-6.18 target/linux/amlogic/meson8b/config-6.12

sed -i -e "s/6.6/6.12/" \
       -e "s/6.18/6.12/" \
       -e "/KERNEL_TESTING_PATCHVER/d" \
       -e "/autocore-arm/d" \
	   -e "s/ pci pcie//" \
target/linux/amlogic/Makefile

rm -rf package/feeds/kiddin9/{*_QMI_WWAN,quectel_MHI} target/linux/amlogic/patches-6.12/904-net-stmmac-disable-hw-vlan-filter-on-meson8b.patch

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-diskman automount/' target/linux/amlogic/Makefile


