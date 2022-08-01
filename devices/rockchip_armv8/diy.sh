#!/bin/bash

shopt -s extglob

rm -rf package/boot/uboot-rockchip
svn export --force https://github.com/coolsnowwolf/lede/trunk/package/boot/uboot-rockchip package/boot/uboot-rockchip
svn export --force https://github.com/coolsnowwolf/lede/trunk/package/boot/arm-trusted-firmware-rockchip-vendor package/boot/arm-trusted-firmware-rockchip-vendor
rm -rf target/linux/rockchip/!(Makefile|patches-5.10)
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/rockchip target/linux/rockchip
rm -rf target/linux/rockchip/{.svn,patches-5.10/.svn}
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/rockchip/patches-5.10 target/linux/rockchip/patches-5.10
rm -rf target/linux/rockchip/patches-5.10/{002-net-usb*,003-dt-bindings*,006-rockchip-rk3399*}
svn export --force https://github.com/friendlyarm/friendlywrt/trunk/target/linux/rockchip/armv8/base-files/etc/modules.d target/linux/rockchip/armv8/base-files/etc/modules.d

mv -f tmp/r8125 feeds/kiddin9/

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += autocore-arm fdisk lsblk luci-app-cpufreq kmod-drm-rockchip kmod-gpu-lima kmod-usb2 kmod-usb3/' target/linux/rockchip/Makefile

echo '
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-5.10
