#!/bin/bash

shopt -s extglob

curl -sfL https://raw.githubusercontent.com/x-wrt/x-wrt/master/target/linux/mediatek/patches-5.10/995-0001-hwnat-add-natflow-flow-offload-support.patch -o target/linux/mediatek/patches-5.10/995-0001-hwnat-add-natflow-flow-offload-support.patch

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += my-autocore-arm luci-app-cpufreq luci-app-natflow-users natflow-boot/' target/linux/mediatek/Makefile

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
' >> ./target/linux/mediatek/mt7622/config-5.10
