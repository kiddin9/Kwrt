#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_5.15.sh

rm -rf package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k* package/kernel/mac80211 target/linux/generic package/kernel/ath10k-ct
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/boot/uboot-envtools package/boot/uboot-envtools
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/firmware/ipq-wifi package/firmware/ipq-wifi
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/firmware/ath11k-firmware package/firmware/ath11k-firmware
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/kernel/mac80211 package/kernel/mac80211
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/kernel/qca-nss-dp package/kernel/qca-nss-dp
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/kernel/qca-ssdk package/kernel/qca-ssdk
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/kernel/ath10k-ct package/kernel/ath10k-ct

svn co https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/target/linux/generic target/linux/generic
rm -rf target/linux/generic/.svn
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.15 target/linux/generic/hack-5.15

svn co https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/target/linux/ipq807x target/linux/ipq807x

git clone https://github.com/robimarko/nss-packages --depth 1 package/nss-packages

rm -rf package/network feeds/kiddin9/{rtl8821cu,rtl88x2bu}

svn co https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/network package/network

curl -sfL https://raw.githubusercontent.com/robimarko/openwrt/ipq807x-5.15-pr/include/kernel-5.15 -o include/kernel-5.15

curl -sfL https://raw.githubusercontent.com/robimarko/openwrt/ipq807x-5.15-pr/package/kernel/linux/modules/netsupport.mk -o package/kernel/linux/modules/netsupport.mk


rm -rf package/kernel/mt76

sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab

sed -i '$a  \
CONFIG_CPU_FREQ_GOV_POWERSAVE=y \
CONFIG_CPU_FREQ_GOV_USERSPACE=y \
CONFIG_CPU_FREQ_GOV_ONDEMAND=y \
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y \
' target/linux/ipq807x/config-5.15

echo "
CONFIG_PACKAGE_kmod-ipt-coova=n
CONFIG_PACKAGE_kmod-pf-ring=n
" >> devices/common/.config

