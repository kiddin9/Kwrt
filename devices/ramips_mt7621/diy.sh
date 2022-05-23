#!/bin/bash

shopt -s extglob

kernel_v="$(cat include/kernel-5.10 | grep LINUX_KERNEL_HASH-* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
sed -i "s?targets/%S/packages?targets/%S/$kernel_v?" include/feeds.mk

curl -sfL https://raw.githubusercontent.com/x-wrt/x-wrt/master/target/linux/mediatek/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch -o target/linux/ramips/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch

svn export --force https://github.com/x-wrt/x-wrt/trunk/target/linux/ramips/files/drivers/net/ethernet/ralink target/linux/ramips/files/drivers/net/ethernet/ralink

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-natflow-users natflow-boot/' target/linux/ramips/Makefile
