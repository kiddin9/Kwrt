#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.6.sh

rm -rf package/boot target/linux/rockchip linux/generic

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/rockchip linux/generic

git_clone_path c74ed3282cf0aabd550203f0e500c0f4dcd2a872 https://github.com/coolsnowwolf/lede package/boot

rm -rf package/boot/uboot-rk35xx/patches/001-cmd-fix_source.patch

wget -N https://github.com/istoreos/istoreos/raw/istoreos-22.03/target/linux/rockchip/patches-5.10/305-r2s-pwm-fan.patch -P target/linux/rockchip/patches-6.6/
wget -N https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-24.10/target/linux/rockchip/Makefile -P target/linux/rockchip/

wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-6.6 -P include/

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

#sed -i -e "s/configs\/dilusense-\(.*-.*_defconfig\)/configs\/\1/" \
#	   -e "s/configs\/sharevdi-\(.*-.*_defconfig\)/configs\/\1/" \
#	   -e "s/configs\/rongpin-\(.*-.*_defconfig\)/configs\/\1/" \
#	   -e "s/configs\/rocktech-\(.*-.*_defconfig\)/configs\/\1/" \
#	   -e "s/configs\/advantech-\(.*-.*_defconfig\)/configs\/\1/" \
#	   package/boot/uboot-rockchip/patches/*

mv -f tmp/r8125 feeds/kiddin9/

rm -rf target/linux/rockchip/armv8/base-files/etc/uci-defaults/13_opkg_update package/feeds/kiddin9/pcat-manager

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk
sed -i -e 's,wpad-openssl,wpad-basic-mbedtls,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip/' target/linux/rockchip/Makefile

cp -Rf $SHELL_FOLDER/diy/* ./

sed -i 's/Ariaboard/光影猫/' target/linux/rockchip/image/armv8.mk

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-6.6
