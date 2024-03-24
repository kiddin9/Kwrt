#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

rm -rf target/linux/qualcommax/!(Makefile) package/kernel/qca-* package/boot/uboot-envtools package/firmware/ipq-wifi
git_clone_path master https://github.com/coolsnowwolf/lede target/linux/qualcommax
git_clone_path master https://github.com/coolsnowwolf/lede package/qca
git_clone_path master https://github.com/coolsnowwolf/lede package/boot/uboot-envtools
git_clone_path master https://github.com/coolsnowwolf/lede package/firmware/ipq-wifi





