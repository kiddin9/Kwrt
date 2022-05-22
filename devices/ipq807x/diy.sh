#!/bin/bash

shopt -s extglob

rm -rf package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k* package/qca package/qat package/kernel
svn export --force https://github.com/Boos4721/openwrt/trunk/package/boot/uboot-envtools package/boot/uboot-envtools
svn export --force https://github.com/Boos4721/openwrt/trunk/package/firmware/ipq-wifi package/firmware/ipq-wifi
svn export --force https://github.com/Boos4721/openwrt/trunk/package/firmware/ath11k-board package/firmware/ath11k-board
svn export --force https://github.com/Boos4721/openwrt/trunk/package/firmware/ath11k-firmware package/firmware/ath11k-firmware
svn export --force https://github.com/Boos4721/openwrt/trunk/package/qca package/qca
svn export --force https://github.com/Boos4721/openwrt/trunk/package/qat package/qat
svn export --force https://github.com/Boos4721/openwrt/trunk/package/kernel package/kernel


rm -rf target/linux/generic target/linux/ipq807x/!(patches-5.15)
svn export --force https://github.com/Boos4721/openwrt/trunk/target/linux/generic target/linux/generic
rm -rf target/linux/generic/hack-5.15/531-debloat_lzma.patch target/linux/generic/hack-5.15/600-bridge_offload.patch
svn co https://github.com/Boos4721/openwrt/trunk/target/linux/ipq807x target/linux/ipq807x
rm -rf target/linux/ipq807x/{.svn,patches-5.15/.svn}
svn co https://github.com/Boos4721/openwrt/trunk/target/linux/ipq807x/patches-5.15 target/linux/ipq807x/patches-5.15

sed -i 's/autocore-arm /my-autocore-arm /' target/linux/ipq807x/Makefile
sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-turboacc/' target/linux/ipq807x/Makefile

echo '
CONFIG_ARM64_CRYPTO=y
CONFIG_CRYPTO_AES_ARM64=y
CONFIG_CRYPTO_AES_ARM64_BS=y
CONFIG_CRYPTO_AES_ARM64_CE=y
CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=y
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
' >> ./target/linux/ipq807x/config-5.15
