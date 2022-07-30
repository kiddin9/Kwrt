#!/bin/bash
shopt -s extglob

rm -rf package/boot/uboot-envtools package/kernel package/firmware/ath11k* package/qca target/linux/generic target/linux/ipq60xx package/network/config/netifd feeds/kiddin9/fullconenat toolchain
svn export --force https://github.com/kiddin9/openwrt-ax1800/trunk/package/boot/uboot-envtools package/boot/uboot-envtools
svn export --force https://github.com/kiddin9/openwrt-ax1800/trunk/package/firmware/ath11k-firmware package/firmware/ath11k-firmware
svn export --force https://github.com/kiddin9/openwrt-ax1800/trunk/package/qca package/qca

svn co https://github.com/kiddin9/openwrt-ax1800/trunk/target/linux/generic target/linux/generic
svn co https://github.com/kiddin9/openwrt-ax1800/trunk/target/linux/ipq60xx target/linux/ipq60xx
svn co https://github.com/kiddin9/openwrt-ax1800/trunk/dl dl
svn co https://github.com/kiddin9/openwrt-ax1800/trunk/package/kernel package/kernel
svn co https://github.com/kiddin9/openwrt-ax1800/trunk/package/network/utils/fullconenat feeds/kiddin9/fullconenat
svn co https://github.com/kiddin9/openwrt-ax1800/trunk/package/network/config/netifd package/network/config/netifd
svn co https://github.com/kiddin9/openwrt-ax1800/trunk/toolchain toolchain
rm -rf target/linux/generic/files
rm -rf package/network/config/netifd/patches

curl -sfL https://raw.githubusercontent.com/kiddin9/openwrt-ax1800/master/include/netfilter.mk -o include/netfilter.mk
curl -sfL https://raw.githubusercontent.com/kiddin9/openwrt-ax1800/master/include/quilt.mk -o include/quilt.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-cpufreq automount/' target/linux/ipq60xx/Makefile

rm -f devices/common/patches/usb.patch
rm -rf feeds/packages/net/openvswitch feeds/kiddin9/shortcut-fe feeds/packages/net/xtables-addons package/kernel/mt76

echo '
CONFIG_ARM64_CRYPTO=y
CONFIG_CRYPTO_AES_ARM64=y
CONFIG_CRYPTO_AES_ARM64_BS=y
CONFIG_CRYPTO_AES_ARM64_CE=y
CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=y
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
CONFIG_ACPI=n
CONFIG_PNP_DEBUG_MESSAGES=y
CONFIG_PINCTRL_BAYTRAIL=n
CONFIG_PINCTRL_CHERRYVIEW=n
CONFIG_PINCTRL_BROXTON=n
CONFIG_PINCTRL_SUNRISEPOINT=n
CONFIG_PINCTRL_QDF2XXX=n
CONFIG_GPIO_AMDPT=n
CONFIG_PCC=n
CONFIG_PMIC_OPREGION=n
CCONFIG_RYPTO_CRC32_ARM64=n
' >> ./target/linux/ipq60xx/config-4.4
