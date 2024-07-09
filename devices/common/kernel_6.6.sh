#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic/hack-6.6

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.6/613-netfilter_optional_tcp_window_check.patch -o target/linux/generic/pending-6.6/613-netfilter_optional_tcp_window_check.patch

curl -sfL https://raw.githubusercontent.com/openwrt/packages/master/libs/dmx_usb_module/patches/101-fix-kernel-6.6-builds.patch -o package/feeds/packages/dmx_usb_module/patches/101-fix-kernel-6.6-builds.patch

curl -sfL https://raw.githubusercontent.com/openwrt/packages/master/libs/libpfring/patches/102-remove-sendpage.patch -o package/feeds/packages/libpfring/patches/102-remove-sendpage.patch

curl -sfL https://raw.githubusercontent.com/openwrt/openwrt/main/package/devel/kselftests-bpf/Makefile -o package/devel/kselftests-bpf/Makefile

rm -rf target/linux/generic/hack-6.6/{410-block-fit-partition-parser.patch,724-net-phy-aquantia*,720-net-phy-add-aqr-phys.patch}
