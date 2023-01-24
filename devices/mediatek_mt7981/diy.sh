#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/feeds/kiddin9/rtl*

rm -rf devices/common/patches/{glinet,fix.patch,iptables.patch,kernel-defaults.patch,targets.patch}

rm -rf toolchain/musl

svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/toolchain/musl toolchain/musl
