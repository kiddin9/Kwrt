#!/bin/bash

shopt -s extglob
rm -rf package/boot/uboot-rockchip target/linux/rockchip/patches-5.10/.svn
svn export --force https://github.com/friendlyarm/friendlywrt/branches/master/package/boot/uboot-rockchip package/boot/uboot-rockchip
svn export --force https://github.com/friendlyarm/friendlywrt/branches/master/target/linux/rockchip/armv8/base-files target/linux/rockchip/armv8/base-files
curl -sfLo target/linux/rockchip/image/armv8.mk https://raw.githubusercontent.com/friendlyarm/friendlywrt/master/target/linux/rockchip/image/armv8.mk
svn co https://github.com/friendlyarm/friendlywrt/branches/master/target/linux/rockchip/patches-5.10 target/linux/rockchip/patches-5.10
rm -rf target/linux/rockchip/armv8/base-files/{etc/{uci-defaults/vendor.defaults,inittab,banner},root}

sed -i 's,-mcpu=generic,-march=armv8-a+crypto+crc -mabi=lp64,g' include/target.mk

sed -i '/;;/i\ethtool -K eth1 rx off tx off && logger -t disable-offloading "disabed rk3328 ethernet tcp/udp offloading tx/rx"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += my-autocore-arm luci-app-cpufreq/' target/linux/rockchip/Makefile

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
CONFIG_MOTORCOMM_PHY=y
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-5.10
