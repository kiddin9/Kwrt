#!/bin/bash

shopt -s extglob
rm -rf package/boot/uboot-rockchip
svn export --force https://github.com/immortalwrt/immortalwrt/branches/master/package/boot/uboot-rockchip package/boot/uboot-rockchip
svn export --force https://github.com/immortalwrt/immortalwrt/branches/master/package/boot/arm-trusted-firmware-rockchip-vendor package/boot/arm-trusted-firmware-rockchip-vendor
rm -rf target/linux/rockchip/!(Makefile|patches-5.10)
svn co https://github.com/immortalwrt/immortalwrt/branches/master/target/linux/rockchip target/linux/rockchip
rm -rf target/linux/rockchip/{.svn,patches-5.10/.svn}
svn co https://github.com/immortalwrt/immortalwrt/branches/master/target/linux/rockchip/patches-5.10 target/linux/rockchip/patches-5.10
rm -Rf target/linux/rockchip/patches-5.10/{006-*-NanoPi-R,007-*-R4S}.patch
curl -sfL https://raw.githubusercontent.com/immortalwrt/immortalwrt/master/package/kernel/linux/modules/video.mk -o package/kernel/linux/modules/video.mk

curl -sfL https://raw.githubusercontent.com/friendlyarm/friendlywrt/master-v21.02/target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol.sh --create-dirs -o files/usr/bin/fa-fancontrol.sh
curl -sfL https://raw.githubusercontent.com/friendlyarm/friendlywrt/master-v21.02/target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol-direct.sh --create-dirs -o files/usr/bin/fa-fancontrol-direct.sh
curl -sfL https://raw.githubusercontent.com/friendlyarm/friendlywrt/master-v21.02/target/linux/rockchip/armv8/base-files/etc/init.d/fa-fancontrol --create-dirs -o files/etc/init.d/fa-fancontrol
chmod +x files/usr/bin/fa-*.sh files/etc/init.d/fa-fancontrol

sed -i 's,-mcpu=generic,-march=armv8-a+crypto+crc -mabi=lp64,g' include/target.mk

sed -i '/;;/i\ethtool -K eth1 rx off tx off && logger -t disable-offloading "disabed rk3328 ethernet tcp/udp offloading tx/rx"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity

sed -i -e 's,kmod-r8169,kmod-r8168,g' target/linux/rockchip/image/armv8.mk

echo '
CONFIG_ARM64_CRYPTO=y
CONFIG_CRYPTO_AES_ARM64=y
CONFIG_CRYPTO_AES_ARM64_BS=y
CONFIG_CRYPTO_AES_ARM64_CE=y
CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_GHASH_ARM64_CE=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_ARM64_CE=y
CONFIG_CRYPTO_SHA256_ARM64=y
CONFIG_CRYPTO_SHA2_ARM64_CE=y
CONFIG_CRYPTO_SHA512_ARM64=y
CONFIG_CRYPTO_SIMD=y
CONFIG_REALTEK_PHY=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
' >> ./target/linux/rockchip/armv8/config-5.10
