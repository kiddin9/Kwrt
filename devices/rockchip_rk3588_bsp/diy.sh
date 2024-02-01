#!/bin/bash

shopt -s extglob

sed -i "s/SUBTARGETS:=armv8$/SUBTARGETS:=rk3588_bsp/" target/linux/rockchip/Makefile
sed -i "s/SUBTARGET:=armv8$/SUBTARGET:=rk3588_bsp/" target/linux/rockchip/armv8/target.mk

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip/' target/linux/rockchip/Makefile

rm -rf package/network/utils/xdp-tools package/devel/kselftests-bpf

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-6.1

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

rm -rf feeds/kiddin9/{quectel_MHI,shortcut-fe,quectel_Gobinet,rtl88*} devices/common/patches/kernel_version.patch devices/common/patches/rootfstargz.patch

sed -i "/friendlyelec/d" package/feeds/kiddin9/base-files/files/lib/preinit/02_sysinfo

mv -f target/linux/rockchip/image/armv8.mk target/linux/rockchip/image/rk3588_bsp.mk

mv -f target/linux/rockchip/armv8 target/linux/rockchip/rk3588_bsp

sed -i "s/BUILD_SUBTARGET:=armv8/BUILD_SUBTARGET:=rk3588_bsp/" package/boot/uboot-rockchip/Makefile

#curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -o package/kernel/linux/modules/video.mk

