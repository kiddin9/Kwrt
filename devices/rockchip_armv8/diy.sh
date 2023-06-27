#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot/uboot-rockchip
svn export --force https://github.com/coolsnowwolf/lede/trunk/package/boot/uboot-rockchip package/boot/uboot-rockchip
svn export --force https://github.com/coolsnowwolf/lede/trunk/package/boot/arm-trusted-firmware-rockchip-vendor package/boot/arm-trusted-firmware-rockchip-vendor
rm -rf target/linux/rockchip/!(Makefile|patches-5.15)
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/rockchip target/linux/rockchip
rm -rf target/linux/rockchip/{.svn,patches-5.15/.svn}
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/rockchip/patches-5.15 target/linux/rockchip/patches-5.15
rm -rf target/linux/rockchip/patches-5.15/{002-net-usb*,204-rockchip-rk3328*,003-dt-bindings*,006-rockchip-rk3399*,072-v6.2-net-phy*,073-v6.2-net-phy*,074-v6.3-net-phy*,075-v6.3-net-phy*,076-v6.3-net-phy*,077-v6.3-net-phy*,078-v6.3-net-phy*,079-v6.3-net-phy*}

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -o package/kernel/linux/modules/video.mk

mv -f tmp/r8125 feeds/kiddin9/

rm -rf target/linux/rockchip/armv8/base-files/etc/uci-defaults/13_opkg_update

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip/' target/linux/rockchip/Makefile

sed -i 's/Ariaboard/光影猫/' target/linux/rockchip/image/armv8.mk

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-5.15
