#!/bin/bash

shopt -s extglob

sed -i "s/BOARD:=rockchip$/BOARD:=rockchip_rk3588/" target/linux/rockchip/Makefile

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip/' target/linux/rockchip/Makefile

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-5.10

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

mv -f target/linux/rockchip target/linux/rockchip_rk3588

rm -rf package/devel/perf package/feeds/kiddin9/{shortcut-fe,oaf,fast-classifier,rtl8821cu,rtl88x2bu} package/kernel/rtl8812au-ct package/kernel/ath10k-ct package/feeds/routing/batman-adv

sed -i "/KernelPackage,dma-buf/d" package/kernel/linux/modules/other.mk

sed -i "/friendlyelec/d" package/feeds/kiddin9/base-files/files/lib/preinit/02_sysinfo

sed -i "s/ath11k ath11k-ahb ath11k-pci //" package/kernel/mac80211/ath.mk

#curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -o package/kernel/linux/modules/video.mk

