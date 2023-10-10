#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-6.1 target/linux/generic/hack-6.1

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/meson target/linux/meson

rm -rf package/feeds/kiddin9/quectel_Gobinet

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch -o target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch



