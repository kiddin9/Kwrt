#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sh -c "curl -sfL https://github.com/openwrt/openwrt/commit/2e6d19ee32399e37c7545aefc57d41541a406d55.patch | patch -d './' -p1 --forward" || true


#sh -c "curl -sfL https://patch-diff.githubusercontent.com/raw/openwrt/openwrt/pull/11287.patch | patch -d './' -p1 --forward"

#curl -sfL https://raw.githubusercontent.com/x-wrt/x-wrt/master/target/linux/mediatek/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch -o target/linux/ramips/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch

#svn export --force https://github.com/x-wrt/x-wrt/trunk/target/linux/ramips/files/drivers/net/ethernet/ralink target/linux/ramips/files/drivers/net/ethernet/ralink

#sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-natflow-users natflow-boot/' target/linux/ramips/Makefile

