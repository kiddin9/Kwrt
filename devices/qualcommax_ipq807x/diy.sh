#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

git_clone_path master https://github.com/openwrt/openwrt target/linux/qualcommax

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic/hack-6.6

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.6/613-netfilter_optional_tcp_window_check.patch -o target/linux/generic/pending-6.6/613-netfilter_optional_tcp_window_check.patch

rm -rf target/linux/generic/hack-6.6/{410-block-fit-partition-parser.patch,724-net-phy-aquantia*,720-net-phy-add-aqr-phys.patch}