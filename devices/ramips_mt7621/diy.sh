#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
#bash $SHELL_FOLDER/../common/kernel_5.15.sh

#curl -sfL https://raw.githubusercontent.com/x-wrt/x-wrt/master/target/linux/mediatek/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch -o target/linux/ramips/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch

#svn export --force https://github.com/x-wrt/x-wrt/trunk/target/linux/ramips/files/drivers/net/ethernet/ralink target/linux/ramips/files/drivers/net/ethernet/ralink

#sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-natflow-users natflow-boot/' target/linux/ramips/Makefile

