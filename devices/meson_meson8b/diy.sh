#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic/hack-6.1

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/meson

rm -rf package/feeds/kiddin9/quectel_Gobinet devices/common/patches/kernel_version.patch devices/common/patches/rootfstargz.patch

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch -o target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch



