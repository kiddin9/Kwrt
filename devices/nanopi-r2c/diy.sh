#!/bin/bash

shopt -s extglob
rm -rf package/boot/uboot-rockchip
svn export --force https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/uboot-rockchip package/boot/uboot-rockchip
svn export --force https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/arm-trusted-firmware-rockchip-vendor package/boot/arm-trusted-firmware-rockchip-vendor
rm -rf target/linux/rockchip/!(Makefile|patches-5.4)
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/rockchip target/linux/rockchip
rm -rf target/linux/rockchip/{.svn,patches-5.4/.svn}
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/rockchip/patches-5.4 target/linux/rockchip/patches-5.4
curl -sfL https://git.io/J0klE -o package/kernel/linux/modules/video.mk

curl -sfL https://raw.githubusercontent.com/friendlyarm/friendlywrt/master-v21.02/target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol.sh --create-dirs -o files/usr/bin/fa-fancontrol.sh
curl -sfL https://raw.githubusercontent.com/friendlyarm/friendlywrt/master-v21.02/target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol-direct.sh --create-dirs -o files/usr/bin/fa-fancontrol-direct.sh
curl -sfL https://raw.githubusercontent.com/friendlyarm/friendlywrt/master-v21.02/target/linux/rockchip/armv8/base-files/etc/init.d/fa-fancontrol --create-dirs -o files/etc/init.d/fa-fancontrol
chmod +x files/usr/bin/fa-*.sh files/etc/init.d/fa-fancontrol

sed -i 's,-mcpu=generic,-march=armv8-a+crypto+crc -mabi=lp64,g' include/target.mk

sed -i "s,'eth1' 'eth0','eth0' 'eth1',g" target/linux/rockchip/armv8/base-files/etc/board.d/02_network

sed -i '/set_interface_core 4 "eth1"/a\set_interface_core 8 "ff160000" "ff160000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
sed -i '/set_interface_core 4 "eth1"/a\set_interface_core 1 "ff150000" "ff150000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity

sed -i '/;;/i\ethtool -K eth1 rx off tx off && logger -t disable-offloading "disabed rk3328 ethernet tcp/udp offloading tx/rx"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity

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
' >> ./target/linux/rockchip/armv8/config-5.4


