#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf target/linux/ipq806x target/linux/generic
svn co https://github.com/APCCV/OpenWRT-23.05.0-rc2-NSS/trunk/target/linux/ipq806x target/linux/ipq806x

svn co https://github.com/APCCV/OpenWRT-23.05.0-rc2-NSS/trunk/target/linux/generic target/linux/generic

curl -sfL https://raw.githubusercontent.com/APCCV/OpenWRT-23.05.0-rc2-NSS/v23.05.0-rc2/include/kernel-5.15 -o include/kernel-5.15

make defconfig

git clone https://github.com/ACwifidude/nss-packages package/nss-packages

sed -i "s/vxlan\/vxlan.ko/vxlan.ko/" package/kernel/linux/modules/netsupport.mk

rm -rf package/feeds/kiddin9/{shortcut-fe,fullconenat,fibocom_QMI_WWAN,fullconenat-nft,fast-classifier,simulated-driver} package/nss-packages/qca-nss-crypto package/nss-packages/qca-nss-cfi

curl -sfL https://raw.githubusercontent.com/APCCV/OpenWRT-23.05.0-rc2-NSS/v23.05.0-rc2/nss-makefile-changes/qca-nss-clients-Makefile -o package/nss-packages/qca-nss-clients/Makefile
curl -sfL https://raw.githubusercontent.com/APCCV/OpenWRT-23.05.0-rc2-NSS/v23.05.0-rc2/nss-makefile-changes/qca-nss-ecm-Makefile -o package/nss-packages/qca-nss-ecm/Makefile

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-qca-nss-drv kmod-qca-nss-ecm-standard kmod-qca-nss-gmac kmod-qca-nss-drv-qdisc kmod-nss-ifb kmod-qca-nss-drv-pppoe kmod-qca-nss-drv-l2tpv2 kmod-qca-nss-drv-tunipip6/' target/linux/ipq806x/Makefile
sed -i "s/CONFIG_ALL_NONSHARED=y/CONFIG_ALL_NONSHARED=n/" .config
sed -i "s/CONFIG_ALL_KMODS=y/CONFIG_ALL_KMODS=n/" .config
make defconfig
sed -i "s/# CONFIG_ALL_NONSHARED is not set/CONFIG_ALL_NONSHARED=y/" .config
sed -i "s/# CONFIG_TARGET_DEVICE_ipq806x_generic_DEVICE_xiaomi_r3d is not set/CONFIG_TARGET_DEVICE_ipq806x_generic_DEVICE_xiaomi_r3d=y/" .config


