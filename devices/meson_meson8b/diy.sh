#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf feeds/routing/batman-adv

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/meson target/linux/meson

sed -i "s/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.15/" target/linux/meson/Makefile


