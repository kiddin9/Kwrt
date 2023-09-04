#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
make defconfig

git clone https://github.com/JiaY-shi/nss-packages.git package/nss-packages

sed -i "s/CONFIG_ALL_NONSHARED=y/CONFIG_ALL_NONSHARED=n/" .config
sed -i "s/CONFIG_ALL_KMODS=y/CONFIG_ALL_KMODS=n/" .config
make defconfig
sed -i "s/# CONFIG_ALL_NONSHARED is not set/CONFIG_ALL_NONSHARED=y/" .config

rm -rf feeds/kiddin9/{fibocom_QMI_WWAN,quectel_Gobinet,shortcut-fe}
