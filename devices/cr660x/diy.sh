#!/bin/bash

shopt -s extglob

svn export --force https://github.com/x-wrt/x-wrt/trunk/package/boot/uboot-envtools package/boot/uboot-envtools

svn export --force https://github.com/x-wrt/x-wrt/trunk/package/kernel/mt76 package/kernel/mt76
rm -rf target/linux/ramips/!(patches-5.15)
svn co https://github.com/x-wrt/x-wrt/trunk/target/linux/ramips target/linux/ramips
rm -rf target/linux/ramips/{.svn,patches-5.15/.svn}
svn co https://github.com/x-wrt/x-wrt/trunk/target/linux/ramips/patches-5.15 target/linux/ramips/patches-5.15

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-natflow-users natflow-boot/' target/linux/ramips/Makefile
