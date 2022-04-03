#!/bin/bash

shopt -s extglob
svn export --force https://github.com/friendlyarm/friendlywrt/trunk/target/linux/rockchip/armv8/base-files/usr target/linux/rockchip/armv8/base-files/usr

sed -i 's,-mcpu=generic,-march=armv8-a+crypto+crc -mabi=lp64,g' include/target.mk

sh -c "curl -sfL https://github.com/openwrt/openwrt/commit/a686b71d0143a59a5c8932468dd2a425dccf536b.patch | patch -d './' -p1 --forward"
sh -c "curl -sfL https://github.com/openwrt/openwrt/commit/c27993f039452f14182282d0ac40c5e9810c0803.patch | patch -d './' -p1 --forward"
sh -c "curl -sfL https://github.com/openwrt/openwrt/commit/6c391373850335f7f3a0a3fc6dc39bfebdfb70d1.patch | patch -d './' -p1 --forward"
sh -c "curl -sfL https://github.com/openwrt/openwrt/commit/53c85f2afe9e497599f56bf1bbecca1f734595dc.patch | patch -d './' -p1 --forward"
# sh -c "curl -sfL https://github.com/openwrt/openwrt/commit/9ba39aa45f06e5c935a9816e771682c5533b1e24.patch | patch -d './' -p1 --forward"

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
