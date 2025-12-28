#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.6.sh

rm -rf package/boot target/linux/rockchip

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/rockchip package/boot

wget -N https://github.com/istoreos/istoreos/raw/refs/heads/istoreos-23.05/target/linux/rockchip/patches-5.15/305-r2s-pwm-fan.patch -P target/linux/rockchip/patches-6.12/

wget -N https://github.com/coolsnowwolf/lede/raw/refs/heads/master/target/linux/generic/backport-6.12/203-v6.15-drivers-base-component-add-function-to-query-the-bound.patch -P target/linux/generic/backport-6.12/

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

rm -rf target/linux/rockchip/armv8/base-files/etc/uci-defaults/13_opkg_update package/feeds/kiddin9/pcat-manager package/feeds/kiddin9/*_QMI_WWAN

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk
sed -i -e 's,wpad-openssl,wpad-basic-mbedtls,g' target/linux/rockchip/image/armv8.mk

sed -i -e '/KERNEL_TESTING_PATCHVER/d' -e 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip luci-app-diskman/' -e 's/autocore-arm/autocore/' target/linux/rockchip/Makefile

sed -i 's/Ariaboard/光影猫/' target/linux/rockchip/image/armv8.mk
