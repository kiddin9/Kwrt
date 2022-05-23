#!/bin/bash


sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += my-autocore-x86 lm-sensors-detect kmod-r8125 kmod-vmxnet3 kmod-igc kmod-drm-i915 kmod-mlx4-core kmod-usb2 kmod-usb3 fdisk/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/kiddin9/
sed -i 's,kmod-r8169,kmod-r8168,g' target/linux/x86/image/64.mk
sed -i 's/256/1024/g' target/linux/x86/image/Makefile

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
' >> ./target/linux/x86/config-5.10

sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

