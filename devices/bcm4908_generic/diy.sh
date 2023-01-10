#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
#bash $SHELL_FOLDER/../common/kernel_5.15.sh

rm -rf package/boot/uboot-bcm4908
svn co https://github.com/openwrt/openwrt/trunk/package/boot/uboot-bcm4908 package/boot/uboot-bcm4908

