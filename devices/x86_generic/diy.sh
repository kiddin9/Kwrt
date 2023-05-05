#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
bash $SHELL_FOLDER/../common/kernel_5.15.sh

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/x86/files target/linux/x86/files
rm -rf target/linux/x86/files/.svn

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/x86/patches-5.15 target/linux/x86/patches-5.15
rm -rf target/linux/x86/patches-5.15/.svn

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -o package/kernel/linux/modules/video.mk

svn co https://github.com/openwrt/openwrt/trunk/package/kernel/mt76 package/feeds/kiddin9/mt76
curl -sfL https://raw.githubusercontent.com/immortalwrt/immortalwrt/master/package/kernel/mt76/patches/0001-mt76-allow-VHT-rate-on-2.4GHz.patch -o package/feeds/kiddin9/mt76/patches/0001-mt76-allow-VHT-rate-on-2.4GHz.patch

sed -i "s/ +PACKAGE_kmod-backlight:kmod-backlight//" package/kernel/linux/modules/video.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-usb-hid kmod-mmc kmod-sdhci usbutils pciutils lm-sensors-detect kmod-alx kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8125 kmod-8139cp kmod-8139too kmod-i40e kmod-drm-i915 kmod-drm-amdgpu kmod-mlx4-core kmod-mlx5-core fdisk lsblk/' target/linux/x86/Makefile

mv -f tmp/r81* feeds/kiddin9/
sed -i 's,kmod-r8169,kmod-r8168,g' target/linux/x86/image/*.mk
sed -i 's/256/1024/g' target/linux/x86/image/Makefile

echo '
CONFIG_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_NR_CPUS=512
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_SDIO_UART=y
CONFIG_MMC_TEST=y
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PCI=y
' >> ./target/linux/x86/config-5.15

sed -i "s/DEVICE_MODEL := x86/DEVICE_MODEL := x86\/32/" target/linux/x86/image/generic.mk

sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

