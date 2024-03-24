#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

git_clone_path master https://github.com/openwrt/openwrt target/linux/qualcommax