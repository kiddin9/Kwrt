#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/amlogic package/boot/uboot-amlogic

sed -i "s/wpad-openssl/wpad-basic-mbedtls/" target/linux/amlogic/image/meson8b.mk



