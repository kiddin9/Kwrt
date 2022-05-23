#!/bin/bash

rm -rf target/linux package/kernel package/boot package/firmware/linux-firmware include/{kernel-*,netfilter.mk} tools/firmware-utils
latest="$(curl -sfL https://github.com/openwrt/openwrt/commits/master/include | grep -o 'href=".*>kernel: bump 5.15' | head -1 | cut -d / -f 5 | cut -d '"' -f 1)"
mkdir new; cp -rf .git new/.git
cd new
[ "$latest" ] && git reset --hard $latest || (git checkout master && git reset --hard HEAD)
git checkout HEAD^
[ "$(echo $(git log -1 --pretty=short) | grep "kernel: bump 5.15")" ] && git checkout $latest
cp -rf --parents target/linux package/kernel package/boot package/firmware/linux-firmware include/{kernel-*,netfilter.mk} tools/firmware-utils package/utils/ucode ../
cd -
svn export --force https://github.com/openwrt/packages/trunk/kernel feeds/packages/kernel
rm -f package/feeds/packages/xtables-addons; svn export https://github.com/openwrt/packages/trunk/net/xtables-addons package/feeds/kiddin9/xtables-addons
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/x86/patches-5.15 target/linux/x86/patches-5.15
rm -rf target/linux/x86/patches-5.15/.svn

kernel_v="$(cat include/kernel-5.15 | grep LINUX_KERNEL_HASH-* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
sed -i "s?targets/%S/packages?targets/%S/$kernel_v?" include/feeds.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += my-autocore-x86 lm-sensors-detect kmod-r8125 kmod-vmxnet3 kmod-igc kmod-drm-i915 kmod-mlx4-core kmod-usb2 kmod-usb3 fdisk/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/kiddin9/
sed -i 's,kmod-r8169,kmod-r8168,g' target/linux/x86/image/64.mk
sed -i 's/256/1024/g' target/linux/x86/image/Makefile

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
' >> ./target/linux/x86/config-5.15

sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

