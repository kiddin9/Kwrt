#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

rm -rf target/linux/qualcommax target/linux/generic/!(*-5.15) package/kernel/qca-* devices/common/patches/qca-ssdk.patch package/boot/uboot-envtools package/firmware/ipq-wifi
git_clone_path master https://github.com/coolsnowwolf/lede target/linux/qualcommax package/firmware/ipq-wifi package/boot/uboot-envtools package/qca

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/generic

wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-6.1 -P include/

sed -i "s/wpad-openssl/wpad-basic-mbedtls/" target/linux/qualcommax/Makefile





