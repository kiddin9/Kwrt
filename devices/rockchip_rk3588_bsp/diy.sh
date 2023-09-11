#!/bin/bash

shopt -s extglob

sed -i "s/SUBTARGETS:=armv8$/SUBTARGETS:=rk3588_bsp/" target/linux/rockchip/Makefile
sed -i "s/SUBTARGET:=armv8$/SUBTARGET:=rk3588_bsp/" target/linux/rockchip/armv8/target.mk

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip/' target/linux/rockchip/Makefile

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-5.10

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

rm -rf package/devel/perf package/feeds/kiddin9/{shortcut-fe,oaf,fast-classifier,rtl8821cu,rtl88x2bu} package/kernel/rtl8812au-ct package/kernel/ath10k-ct package/feeds/routing/batman-adv

sed -i "/KernelPackage,dma-buf/d" package/kernel/linux/modules/other.mk

sed -i "/friendlyelec/d" package/feeds/kiddin9/base-files/files/lib/preinit/02_sysinfo

sed -i "s/ath11k ath11k-ahb ath11k-pci //" package/kernel/mac80211/ath.mk

mv -f target/linux/rockchip/image/armv8.mk target/linux/rockchip/image/rk3588_bsp.mk

mv -f target/linux/rockchip/armv8 target/linux/rockchip/rk3588_bsp

#curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -o package/kernel/linux/modules/video.mk

