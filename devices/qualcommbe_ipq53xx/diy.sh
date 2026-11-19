#!/bin/bash

shopt -s extglob

rm -rf target/linux/generic target/linux/qualcommbe package/kernel package/firmware package/boot

git_clone_path main https://github.com/openwrt/openwrt package/kernel

rm -rf package/kernel/mac80211
git_clone_path master https://github.com/coolsnowwolf/lede  target/linux/generic target/linux/qualcommbe package/boot package/firmware package/kernel/mac80211 package/kernel/rtl837x
rm package/kernel/mac80211/patches-qualcommbe/build/160-backports-sockaddr_unsized-is-in-6.18.57.patch

wget -N https://github.com/coolsnowwolf/lede/raw/refs/heads/master/include/kernel-6.18 -P target/linux/generic/

wget -N https://github.com/openwrt/openwrt/raw/refs/heads/main/include/kernel.mk -P include/

wget -N https://github.com/openwrt/openwrt/raw/refs/heads/main/include/netfilter.mk -P include/

rm -rf package/feeds/kiddin9/{quectel_QMI_WWAN,simcom_QMI_WWAN,fibocom_QMI_WWAN,quectel_MHI,rkp-ipid} package/feeds/packages/{v4l2loopback,libpfring,xtables-addons}