#!/bin/bash

shopt -s extglob

sed -i "s/BOARD:=rockchip$/BOARD:=rockchip_rk3588/" target/linux/rockchip/Makefile

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip/' target/linux/rockchip/Makefile

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-5.10

mv -f target/linux/rockchip target/linux/rockchip_rk3588

rm -rf package/feeds/packages/glib2 package/devel/perf package/feeds/kiddin9/{shortcut-fe,fibocom_QMI_WWAN,oaf} package/feeds/packages/bluez

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.10 target/linux/generic/hack_5.10
rm -rf target/linux/generic/hack_5.10/{220-gc_sections*,781-dsa-register*,780-drivers-net*,996-fs-ntfs3*,100-update-mtk_wed_h.patch}

#curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -o package/kernel/linux/modules/video.mk

