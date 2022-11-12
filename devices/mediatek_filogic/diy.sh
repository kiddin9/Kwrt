#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
bash $SHELL_FOLDER/../common/kernel_5.15.sh

sh -c "curl -sfL https://patch-diff.githubusercontent.com/raw/openwrt/openwrt/pull/11115.patch | patch -d './' -p1 --forward"

rm -rf tools/mkimage
svn co https://github.com/openwrt/openwrt/trunk/tools/mkimage tools/mkimage