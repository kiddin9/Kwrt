#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_6.6.sh

sed -i '/bootargs-.* = ".*root=\/dev\/fit0 rootwait";/d' target/linux/mediatek/dts/*

find target/linux/mediatek/filogic/base-files/ -type f -exec sed -i "s/-stock//g" {} \;
find target/linux/mediatek/base-files/ -type f -exec sed -i "s/-stock//g" {} \;

sed -i "s/-stock//g" package/boot/uboot-envtools/files/mediatek_filogic

sed -i "s/openwrt-mediatek-filogic/kwrt-mediatek-filogic/g" target/linux/mediatek/image/filogic.mk
sed -i "s/ fitblk / /g" target/linux/mediatek/image/filogic.mk

