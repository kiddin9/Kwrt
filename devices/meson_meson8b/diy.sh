#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/meson

rm -rf package/feeds/kiddin9/rtl8188eu package/feeds/kiddin9/rtl8192eu package/feeds/kiddin9/rtl8812au-ac
