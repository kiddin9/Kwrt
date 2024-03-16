#!/bin/bash

shopt -s extglob

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic/hack-6.1

sed -i "s/mi-router-wr30u-stock/mi-router-wr30u/" package/boot/uboot-envtools/files/mediatek_filogic
sed -i "s/mi-router-wr30u-stock/mi-router-wr30u/" target/linux/mediatek/filogic/base-files/etc/board.d/01_leds
sed -i "s/mi-router-wr30u-stock/mi-router-wr30u/" target/linux/mediatek/filogic/base-files/etc/board.d/02_network
sed -i "s/mi-router-wr30u-stock/mi-router-wr30u/" target/linux/mediatek/filogic/base-files/lib/upgrade/platform.sh

rm -rf package/feeds/kiddin9/quectel_Gobinet devices/common/patches/kernel_version.patch devices/common/patches/rootfstargz.patch target/linux/generic/hack-6.1/{410-block-fit-partition-parser.patch,724-net-phy-aquantia*,720-net-phy-add-aqr-phys.patch}

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch -o target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch

rm -rf package/feeds/packages/libpfring
