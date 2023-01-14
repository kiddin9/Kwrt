#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

#bash $SHELL_FOLDER/../common/kernel_5.15.sh

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.15 target/linux/generic/hack-5.15

rm -rf feeds/kiddin9/{rtl8821cu,rtl88x2bu} package/kernel/mt76

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

