#!/bin/bash

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.6.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/x86/files target/linux/x86/patches-6.12

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-fs-f2fs kmod-mmc kmod-sdhci kmod-usb-hid amd64-microcode intel-microcode usbutils pciutils lm-sensors-detect kmod-alx kmod-vmxnet3 kmod-igbvf kmod-iavf kmod-bnx2x kmod-pcnet32 kmod-tulip kmod-r8125 kmod-r8126 kmod-r8101 kmod-8139cp kmod-8139too kmod-i40e kmod-i40evf kmod-mlx4-core kmod-mlx5-core fdisk lsblk/' target/linux/x86/Makefile

sed -i 's/kmod-r8169/kmod-r8168/' target/linux/x86/image/generic.mk

sed -i 's/256/1024/g' target/linux/x86/image/Makefile

sed -i "s/DEVICE_MODEL := x86/DEVICE_MODEL := x86\/32/" target/linux/x86/image/generic.mk


