#!/bin/bash

shopt -s extglob

curl -sfL https://raw.githubusercontent.com/x-wrt/x-wrt/22.03/target/linux/ramips/patches-5.10/995-0001-hwnat-add-natflow-flow-offload-support.patch -o target/linux/ramips/patches-5.10/995-0001-hwnat-add-natflow-flow-offload-support.patch

svn export --force https://github.com/x-wrt/x-wrt/trunk/target/linux/ramips/files/drivers/net/ethernet/ralink target/linux/ramips/files/drivers/net/ethernet/ralink

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-natflow-users natflow-boot/' target/linux/ramips/Makefile
