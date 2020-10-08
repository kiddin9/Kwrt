#!/bin/bash
sed -i "s/+luci\( \|$\)//g"  package/*/*/*/Makefile

wget -O target/linux/rockchip/patches-5.4/002-rockchip-add-hwmon-support-for-SoCs-and-GPUs.patch https://github.com/project-openwrt/openwrt/raw/master/target/linux/rockchip/patches-5.4/002-rockchip-add-hwmon-support-for-SoCs-and-GPUs.patch
wget -O target/linux/rockchip/patches-5.4/003-arm64-dts-rockchip-add-more-cpu-operating-points-for.patch https://github.com/project-openwrt/openwrt/raw/master/target/linux/rockchip/patches-5.4/003-arm64-dts-rockchip-add-more-cpu-operating-points-for.patch
wget -O target/linux/rockchip/patches-5.4/005-arm64-dts-rockchip-Add-RK3328-idle-state.patch https://github.com/project-openwrt/openwrt/raw/master/target/linux/rockchip/patches-5.4/005-arm64-dts-rockchip-Add-RK3328-idle-state.patch
wget -O target/linux/rockchip/patches-5.4/104-rockchip-rk3328-add-i2c0-controller-for-nanopi-r2s.patch https://github.com/project-openwrt/openwrt/raw/master/target/linux/rockchip/patches-5.4/104-rockchip-rk3328-add-i2c0-controller-for-nanopi-r2s.patch
wget -O target/linux/rockchip/patches-5.4/007-rockchip-rk3328-fix-NanoPi-R2S-GMAC-clock-name.patch https://github.com/project-openwrt/openwrt/raw/master/target/linux/rockchip/patches-5.4/007-rockchip-rk3328-fix-NanoPi-R2S-GMAC-clock-name.patch

sed -i "s,'eth1' 'eth0','eth0' 'eth1',g" target/linux/rockchip/armv8/base-files/etc/board.d/02_network
sed -i '/;;/i\set_interface_core 8 "ff160000" "ff160000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
sed -i '/;;/i\set_interface_core 1 "ff150000" "ff150000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
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
# CONFIG_CRYPTO_SHA3_ARM64 is not set
CONFIG_CRYPTO_SHA512_ARM64=y
# CONFIG_CRYPTO_SHA512_ARM64_CE is not set
CONFIG_CRYPTO_SIMD=y
# CONFIG_CRYPTO_SM3_ARM64_CE is not set
# CONFIG_CRYPTO_SM4_ARM64_CE is not set
CONFIG_REALTEK_PHY=y
' >> ./target/linux/rockchip/armv8/config-5.4
