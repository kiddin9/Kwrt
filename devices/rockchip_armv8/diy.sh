#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))
bash $SHELL_FOLDER/../common/kernel_5.15.sh

rm -rf package/boot/uboot-rockchip
svn export --force https://github.com/coolsnowwolf/lede/trunk/package/boot/uboot-rockchip package/boot/uboot-rockchip
svn export --force https://github.com/coolsnowwolf/lede/trunk/package/boot/arm-trusted-firmware-rockchip-vendor package/boot/arm-trusted-firmware-rockchip-vendor
rm -rf target/linux/rockchip/!(Makefile|patches-5.15)
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/rockchip target/linux/rockchip
rm -rf target/linux/rockchip/{.svn,patches-5.15/.svn}
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/rockchip/patches-5.15 target/linux/rockchip/patches-5.15
rm -rf target/linux/rockchip/patches-5.15/{002-net-usb*,003-dt-bindings*,006-rockchip-rk3399*}

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -o package/kernel/linux/modules/video.mk

sed -i "s/#TARGET_DEVICES += hinlink_opc-h68k/TARGET_DEVICES += hinlink_opc-h68k/" target/linux/rockchip/image/armv8.mk

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

mv -f tmp/r8125 feeds/kiddin9/

rm -rf target/linux/rockchip/armv8/base-files/etc/uci-defaults/13_opkg_update

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip kmod-gpu-lima/' target/linux/rockchip/Makefile

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-5.15
