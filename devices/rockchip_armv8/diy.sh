#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

rm -rf package/boot

git_clone_path master https://github.com/immortalwrt/immortalwrt package/boot

rm -rf target/linux/generic target/linux/rockchip/!(Makefile)

git_clone_path master https://github.com/immortalwrt/immortalwrt target/linux/generic
git_clone_path master https://github.com/immortalwrt/immortalwrt target/linux/rockchip

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic/hack-6.1

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch -o target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch

rm -rf target/linux/generic/hack-6.1/{410-block-fit-partition-parser.patch,724-net-phy-aquantia*,720-net-phy-add-aqr-phys.patch}

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

mv -f tmp/r8125 feeds/kiddin9/

rm -rf target/linux/rockchip/armv8/base-files/etc/uci-defaults/13_opkg_update

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk
sed -i -e 's,wpad-openssl,wpad-basic-mbedtls,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip/' target/linux/rockchip/Makefile

cp -Rf $SHELL_FOLDER/diy/* ./

sed -i 's/Ariaboard/光影猫/' target/linux/rockchip/image/armv8.mk
sed -i 's,NanoPi R2S$,NanoPi R2S / R2S Plus,' target/linux/rockchip/image/armv8.mk

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-6.1
