#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/firmware/ipq-wifi package/firmware/ath11k-firmware target/linux/qualcommax/{dts,files,image,ipq50xx}

git_clone_path main https://github.com/openwrt/openwrt mv target/linux/qualcommax

git_clone_path main https://github.com/openwrt/openwrt package/boot package/firmware/ipq-wifi package/firmware/ath11k-firmware
