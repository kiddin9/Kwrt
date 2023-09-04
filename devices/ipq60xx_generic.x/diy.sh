#!/bin/bash
shopt -s extglob

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ipq60xx target/linux/ipq60xx
rm -rf target/linux/ipq60xx/patches-5.15/{0133-clk-ipq-support-for-resetting-multiple-bits.patch,0168-clk-qcom-ipq6018-fix-networking-resets.patch}
make defconfig

svn co https://github.com/coolsnowwolf/lede/trunk/package/qca package/qca

sed -i "s/+kmod-pppoe/+kmod-pppoe +kmod-bonding/" package/qca/nss/qca-nss-clients-64/Makefile

rm -rf package/kernel/{qca-nss-dp,qca-ssdk}

sed -i "s/CONFIG_ALL_NONSHARED=y/CONFIG_ALL_NONSHARED=n/" .config
sed -i "s/CONFIG_ALL_KMODS=y/CONFIG_ALL_KMODS=n/" .config
make defconfig
sed -i "s/# CONFIG_ALL_NONSHARED is not set/CONFIG_ALL_NONSHARED=y/" .config


