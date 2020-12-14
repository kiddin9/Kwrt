#!/bin/bash

find target/linux/rockchip/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
rm -Rf target/linux/rockchip/.svn
echo -e "\q" | svn co https://github.com/project-openwrt/openwrt/branches/master/target/linux/rockchip target/linux/rockchip

sed -i "s,'eth1' 'eth0','eth0' 'eth1',g" target/linux/rockchip/armv8/base-files/etc/board.d/02_network

sed -i '/;;/i\set_interface_core 8 "ff160000" "ff160000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
sed -i '/;;/i\set_interface_core 1 "ff150000" "ff150000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
sed -i '/;;/i\ethtool -K eth0 rx off tx off && logger -t disable-offloading "disabed rk3328 ethernet tcp/udp offloading tx/rx"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity

sed -i 's/ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305/ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256/' package/feeds/custom/luci-app-ssr-plus/root/usr/share/ssrplus/gentrojanconfig
sed -i 's/TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256/TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256/' package/feeds/custom/luci-app-ssr-plus/root/usr/share/ssrplus/gentrojanconfig
