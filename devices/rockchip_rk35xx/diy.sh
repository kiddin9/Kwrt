#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/feeds/kiddin9/accel-ppp package/devel/perf package/devel/kselftests-bpf package/feeds/routing/batman-adv

rm -rf target/linux/generic/!(*-5.15) target/linux/rockchip package/kernel devices/common/patches/usb-audio.patch

git_clone_path master https://github.com/coolsnowwolf/lede package/boot target/linux/rockchip package/kernel

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/generic

rm -rf  package/kernel/ksmbd

wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-5.10 -P include/
wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-6.1 -P include/
wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-6.6 -P include/

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

mv -f tmp/r8125 feeds/kiddin9/

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/rk35xx.mk
sed -i -e 's,wpad-openssl,wpad-basic-mbedtls,g' target/linux/rockchip/image/rk35xx.mk

wget -N https://github.com/coolsnowwolf/lede/raw/master/include/netfilter.mk -P include/


sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk/' target/linux/rockchip/Makefile

cp -Rf $SHELL_FOLDER/diy/* ./

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/rk35xx/config-5.10
