#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/firmware/ipq-wifi package/firmware/ath11k-firmware target/linux/qualcommax target/linux/generic

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/qualcommax target/linux/generic package/boot package/firmware/ipq-wifi package/firmware/ath11k-firmware

wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-6.6 -P include/

sed -i "s/wpad-openssl/wpad-basic-mbedtls/" target/linux/qualcommax/Makefile
sed -i "/KERNEL_TESTING_PATCHVER/d" target/linux/qualcommax/Makefile
