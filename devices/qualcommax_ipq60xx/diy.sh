#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.6.sh

rm -rf package/boot/uboot-envtools package/firmware/ipq-wifi
git_clone_path master https://github.com/coolsnowwolf/lede target/linux/qualcommax/ipq60xx package/firmware/ipq-wifi package/boot/uboot-envtools

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/qualcommax/files/arch/arm64/boot/dts/qcom

git_clone_path ipq60xx-devel https://github.com/JiaY-shi/openwrt mv target/linux/qualcommax/patches-6.6

wget -N https://github.com/coolsnowwolf/lede/raw/master/target/linux/qualcommax/image/ipq60xx.mk -P target/linux/qualcommax/image/

sed -i "s/wpad-openssl/wpad-basic-mbedtls/" target/linux/qualcommax/Makefile





