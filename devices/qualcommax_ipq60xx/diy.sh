#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))


rm -rf devices/common/patches/{wifi-scripts.patch,curl.patch}

wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/openwrt-24.10/target/imagebuilder/files/Makefile -P target/imagebuilder/files/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/openwrt-24.10/package/base-files/files/sbin/sysupgrade -P package/base-files/files/sbin/
wget -N https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-24.10/package/network/config/firewall/Makefile -P package/network/config/firewall/

git clone https://github.com/LiBwrt/nss-packages nss-packages

mv -f nss-packages/* package/feeds/kiddin9/

rm -rf feeds/kiddin9/shortcut-fe feeds/kiddin9/fibocom_QMI_WWAN feeds/kiddin9/quectel_QMI_WWAN feeds/kiddin9/xtables-wgobfs feeds/kiddin9/fullconenat-nft/

rm -rf package/feeds/packages/ovpn-dco package/feeds/packages/xr_usb_serial_common package/feeds/packages/openvswitch package/feeds/packages/xtables-addons

rm -rf package/libs/libnftnl/patches/001-libnftnl-add-fullcone-expression-support.patch package/network/config/firewall4/patches/001-firewall4-Add-fullcone-support.patch

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-qca-mcs kmod-qca-nss-drv-igs kmod-qca-nss-drv-l2tpv2 kmod-qca-nss-drv-lag-mgr kmod-qca-nss-drv-map-t kmod-qca-nss-drv-pppoe kmod-qca-nss-drv-pptp kmod-qca-nss-drv-qdisc kmod-qca-nss-macsec/' target/linux/qualcommax/Makefile

sed -i "s/LiBwrt/Kwrt/Ig" package/base-files/files/bin/config_generate package/base-files/image-config.in package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc config/Config-images.in Config.in include/u-boot.mk include/version.mk || true