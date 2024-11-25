#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf target/linux/qualcommax package/boot/uboot-envtools package/firmware package/kernel/qca-*
git_clone_path ipq50xx-pr https://github.com/hzyitc/openwrt-redmi-ax3000 target/linux/qualcommax package/firmware package/kernel/qca-nss-dp package/kernel/qca-ssdk package/boot/uboot-envtools
