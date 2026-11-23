#!/bin/bash

shopt -s extglob

rm -rf target/linux/generic target/linux/qualcommax package/kernel package/firmware package/boot scripts

git_clone_path main https://github.com/openwrt/openwrt target/linux/generic target/linux/qualcommax package/boot package/firmware package/kernel scripts

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/generic/hack-6.18

wget -N https://github.com/openwrt/openwrt/raw/refs/heads/main/include/kernel.mk -P include/

wget -N https://github.com/openwrt/openwrt/raw/refs/heads/main/include/netfilter.mk -P include/

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.18/613-netfilter_optional_tcp_window_check.patch -P target/linux/generic/pending-6.18/

rm -rf package/feeds/kiddin9/{quectel_QMI_WWAN,simcom_QMI_WWAN,fibocom_QMI_WWAN,quectel_MHI,rkp-ipid} package/feeds/packages/{v4l2loopback,libpfring,xtables-addons}
