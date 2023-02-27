#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_5.15.sh

svn export --force https://github.com/openwrt/openwrt/trunk/package/firmware/ipq-wifi package/firmware/ipq-wifi

#sh -c "curl -sfL https://patch-diff.githubusercontent.com/raw/openwrt/openwrt/pull/10778.patch | git apply -p1"


