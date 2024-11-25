#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/kernel/qca-* package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k-firmware

git_clone_path ipq50xx-mainline-kernel-5.15-openwrt-23.05 https://github.com/hzyitc/openwrt-redmi-ax3000 target/linux/ipq50xx package/firmware/ipq-wifi package/firmware/ath11k-firmware package/boot/uboot-envtools

sed -i "s/wpad-basic-wolfssl/wpad-basic-mbedtls/" target/linux/ipq50xx/Makefile