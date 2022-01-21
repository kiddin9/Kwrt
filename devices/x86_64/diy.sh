#!/bin/bash

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/x86/patches-5.10 target/linux/x86/patches-5.10
rm -rf target/linux/x86/patches-5.10/.svn

sed -i 's,kmod-r8169,kmod-r8168,g' target/linux/x86/image/64.mk
sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += my-autocore-x86 lm-sensors-detect kmod-r8125 kmod-vmxnet3  kmod-igc/' target/linux/x86/Makefile

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_DRM=y
CONFIG_DRM_I915=y
' >> ./target/linux/x86/config-5.10

sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

