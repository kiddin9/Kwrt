#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

git clone https://github.com/qosmio/nss-packages package/nss-packages

#rm -rf target/linux/ipq806x
#svn co https://github.com/APCCV/OpenWRT-23.05.0-rc1-NSS/trunk/target/linux/ipq806x target/linux/ipq806x

#sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-qca-nss-drv kmod-qca-nss-drv-qdisc kmod-qca-nss-ecm-standard kmod-qca-nss-gmac kmod-qca-nss-drv-pppoe kmod-qca-nss-drv-pptp kmod-nss-ifb qca-nss-crypto qca-nss-drv-igs/' target/linux/ipq806x/Makefile