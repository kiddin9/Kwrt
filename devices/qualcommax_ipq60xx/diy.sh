#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/firmware package/boot/uboot-envtools target/linux/qualcommax

git_clone_path openwrt-24.10 https://github.com/LiBwrt-op/openwrt-6.x package/firmware package/boot/uboot-envtools target/linux/qualcommax

wget -N https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-24.10/target/linux/qualcommax/ipq60xx/target.mk -P target/linux/qualcommax/ipq60xx/

rm -rf target/linux/qualcommax/patches-6.6/06*-qca-*.patch
