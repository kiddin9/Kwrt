#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/openwrt-24.10/target/imagebuilder/files/Makefile -P target/imagebuilder/files/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/openwrt-24.10/package/base-files/files/sbin/sysupgrade -P package/base-files/files/sbin/
wget -N https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-24.10/package/network/config/firewall/Makefile -P package/network/config/firewall/
wget -N https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-24.10/package/network/services/dnsmasq/files/dnsmasq.init -P package/network/services/dnsmasq/files/
wget -N https://github.com/openwrt/openwrt/raw/refs/heads/openwrt-24.10/package/network/config/wifi-scripts/files/lib/netifd/hostapd.sh -P package/network/config/wifi-scripts/files/lib/netifd/
wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/main/include/target.mk -P include/

git clone https://github.com/LiBwrt/nss-packages nss-packages

mv -f nss-packages/* package/feeds/kiddin9/

sed -i "/ECM_INTERFACE_RAWIP_ENABLE/d"  package/feeds/kiddin9/qca-nss-ecm/Makefile

rm -rf feeds/kiddin9/{fullconenat-nft,xtables-wgobfs,shortcut-fe} package/devel/perf package/feeds/packages/{libpfring,ovpn-dco,xr_usb_serial_common,openvswitch,xtables-addons}

rm -rf target/linux/generic/hack-6.6/220-arm-gc_sections.patch

sed -i "s/wpad-openssl/wpad-basic-mbedtls/" target/linux/qualcommax/Makefile

sed -i "s/LiBwrt/Kwrt/Ig" package/base-files/files/bin/config_generate package/base-files/image-config.in package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc config/Config-images.in Config.in include/u-boot.mk include/version.mk || true

sed -i -e "s/set \${s}.country='\${country || ''}'/set \${s}.country='\${country || \"CN\"}'/g" -e "s/set \${s}.disabled=.*/set \${s}.disabled='0'/" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
