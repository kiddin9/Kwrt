#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/kernel/qca* package/firmware/ipq-wifi target/linux/qualcommax target/linux/generic package/devel/perf

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/qualcommax target/linux/generic package/boot package/qca package/firmware/ipq-wifi

wget -N https://github.com/coolsnowwolf/lede/raw/master/include/kernel-6.6 -P include/

sed -i -e "s/wpad-openssl/wpad-basic-mbedtls/" \
	   -e "/KERNEL_TESTING_PATCHVER/d" \
	   -e "s/KERNEL_PATCHVER:=6.12/KERNEL_PATCHVER:=6.6/" \
target/linux/qualcommax/Makefile

sed -i "/ECM_INTERFACE_MAP_T_ENABLE/d"  package/qca/qca-nss-ecm/Makefile

