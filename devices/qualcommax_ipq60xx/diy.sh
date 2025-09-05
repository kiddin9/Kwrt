#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf package/boot package/firmware/ipq-wifi target/linux/qualcommax target/linux/generic package/kernel package/firmware/ath11k-firmware

git_clone_path k6.12-nss https://github.com/LiBwrt/openwrt-6.x target/linux/qualcommax target/linux/generic package/kernel package/boot package/firmware/ipq-wifi package/firmware/ath11k-firmware

wget -N https://github.com/openwrt/openwrt/raw/refs/heads/main/include/kernel-version.mk -P include/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/main/config/Config-kernel.in -P config/
wget -N https://github.com/LiBwrt/openwrt-6.x/raw/refs/heads/k6.12-nss/include/image-commands.mk -P include/
wget -N https://github.com/LiBwrt/openwrt-6.x/raw/refs/heads/k6.12-nss/scripts/tplink-mkimage-2022.py -P scripts/
wget -N https://github.com/LiBwrt/openwrt-6.x/raw/refs/heads/k6.12-nss/config/Config-ipq.in -P config/
wget -N https://github.com/LiBwrt/openwrt-6.x/raw/refs/heads/k6.12-nss/Config.in -P ./

chmod +x scripts/tplink-mkimage-2022.py

git clone https://github.com/qosmio/nss-packages.git package/nss-packages
git clone https://github.com/qosmio/sqm-scripts-nss.git package/sqm-scripts-nss

sed -i "/ECM_INTERFACE_RAWIP_ENABLE/d"  package/nss-packages/qca-nss-ecm/Makefile

rm -rf feeds/kiddin9/{xtables-wgobfs,shortcut-fe} package/devel/perf package/feeds/packages/{ovpn-dco,xr_usb_serial_common,openvswitch,xtables-addons}

sed -i "s/luci uboot-envtools wpad-openssl/luci uboot-envtools wpad-mbedtls/" target/linux/qualcommax/Makefile
