#!/bin/bash
#=================================================

./scripts/feeds update -a
mv -f feeds/packages/libs/libx264 feeds/custom/libx264
mv -f feeds/packages/net/aria2 feeds/custom/aria2
mv -f feeds/packages/admin/netdata feeds/custom/netdata
rm -Rf feeds/packages/net/smartdns
rm -Rf feeds/packages/net/miniupnpd
svn co https://github.com/project-openwrt/packages/trunk/lang/python/Flask-RESTful feeds/packages/lang/python/Flask-RESTful
./scripts/feeds update packages custom
./scripts/feeds install -a
rm -Rf tools/upx && svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
rm -Rf tools/ucl && svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' package/*/custom/*/Makefile
sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
sed -i 's/-std=\(gnu\|c\)++\(11\|14\)//g' package/feeds/*/*/Makefile
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.4 target/linux/generic/hack-5.4
rm -Rf target/linux/generic/hack-5.4/641-sch_cake-fix-IP-protocol-handling-in-the-presence-of.patch
echo -e "\q" | svn co https://github.com/project-openwrt/openwrt/branches/master/package/network/utils/iptables/patches package/network/utils/iptables/patches
rm -Rf package/*/*/luci-app-zerotier/root/etc/init.d/zerotier
rm -Rf files/usr/share/aria2 && git clone https://github.com/P3TERX/aria2.conf files/usr/share/aria2
chmod +x files/usr/share/aria2/*.sh
rm -Rf package/*/*/antileech/src/* && git clone https://github.com/persmule/amule-dlp.antiLeech feeds/custom/antileech/src
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/default-settings/i18n feeds/custom/default-settings/po/zh_Hans
sed -i '/rpcd_/d' package/*/*/autocore/Makefile
sed -i "s/'class': 'table'/'class': 'table memory'/g" package/*/*/luci-mod-status/htdocs/luci-static/resources/view/status/include/20_memory.js
sed -i 's/\[ -e "$FILE" \] && . "$FILE"/[ -e "$FILE" ] \&\& \[ -f "\/bin\/bash" \] \&\& env -i bash "$FILE" || . "$FILE"/g' package/base-files/files/etc/profile
sed -i '/depends on PACKAGE_php7-cli || PACKAGE_php7-cgi/d' package/*/*/php7/Makefile
sed -i 's?/etc/config/AdGuardHome?/etc/config/AdGuardHome\n/etc/config/AdGuardHome/AdGuardHome.yaml?g'  package/*/*/luci-app-adguardhome/Makefile
sed -i 's/DEPENDS:= strongswan/DEPENDS:=+strongswan/g' package/*/*/strongswan/Makefile
sed -i '/ipsec.init/d' package/*/*/strongswan/Makefile
sed -i 's/+rclone\( \|$\)/+rclone +fuse-utils\1/g' package/*/*/luci-app-rclone/Makefile
sed -i 's/+acme\( \|$\)/+acme +acme-dnsapi\1/g' package/*/*/luci-app-acme/Makefile
sed -i 's/ @!BUSYBOX_DEFAULT_IP:/ +/g' package/*/*/wrtbwmon/Makefile
sed -i 's/root\/Download/data\/download\/aria2/g' files/usr/share/aria2/*
sed -i '/resolvfile=/d' package/*/*/luci-app-adguardhome/root/etc/init.d/AdGuardHome
sed -i '/_redirect2ssl/d' package/*/*/nginx/Makefile
sed -i '/init_lan/d' package/*/*/nginx/files/nginx.init
sed -i '$a /etc/sysupgrade.conf' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/smartdns' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/amule' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /www/speedtest/results/telemetry_settings.php' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/php7/custom.ini' package/base-files/files/lib/upgrade/keep.d/base-files-essential
# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
sed -i '$a CONFIG_ACPI=y\nCONFIG_X86_ACPI_CPUFREQ=y\nCONFIG_CPU_FREQ_GOV_CONSERVATIVE=y\nCONFIG_CPU_FREQ_GOV_POWERSAVE=y\nCONFIG_CPU_FREQ_GOV_USERSPACE=y\nCONFIG_NR_CPUS=128\nCONFIG_FAT_DEFAULT_IOCHARSET="utf8"' target/linux/*/config-*
sed -i 's/if test_proxy/sleep 3600\nif test_proxy/g' package/*/*/luci-app-ssr-plus/root/usr/bin/ssr-switch
sed -i 's/ uci.cursor/ luci.model.uci.cursor/g' package/*/*/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
sed -i 's/service_start $PROG/service_start $PROG -R/g' package/*/*/php7/files/php7-fpm.init
sed -i 's/ +kmod-fs-exfat//g' package/*/*/automount/Makefile
sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
mkdir package/network/config/firewall/patches
wget -O package/network/config/firewall/patches/fullconenat.patch https://github.com/coolsnowwolf/lede/raw/master/package/network/config/firewall/patches/fullconenat.patch
sed -i 's/getElementById("cbid/getElementById("widget.cbid/g' package/*/custom/*/luasrc/view/*/*.htm
getversion(){
ver=$(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/$1/releases/latest) | grep -o -E "[0-9].+")
[ $ver ] && echo $ver || git ls-remote --tags git://github.com/$1 | cut -d/ -f3- | sort -t. -nk1,2 -k3 | awk '/^[^{]*$/{version=$1}END{print version}' | grep -o -E "[0-9].+"
}
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion v2ray/v2ray-core)/g" package/*/*/v2ray/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion AdguardTeam/AdGuardHome)/g" package/*/*/AdGuardHome/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion c0re100/qBittorrent-Enhanced-Edition)/g" package/*/*/qBittorrent-Enhanced-Edition/Makefile
sed -i "s/PKG_HASH:=.*/PKG_HASH:=skip/g" package/feeds/custom/*/Makefile
find package/*/custom/*/ -maxdepth 2 ! -path "*shadowsocksr-libev*" -name "Makefile" ! -path "*rclone*" -name "Makefile" ! -path "*subweb*" -name "Makefile" \
! -path "*libtorrent-rasterbar*" -name "Makefile" | xargs -i sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=latest/g" {}
find package/*/custom/*/ -maxdepth 2 -name "Makefile" | xargs -i sed -i "s/SUBDIRS=/M=/g" {}
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk
sed -i '/PKG_BUILD_DIR.*(PKG_NAME)/d' feeds/luci/luci.mk
find package/*/custom/*/ -maxdepth 1 -d -name "i18n" | xargs -i rename -v 's/i18n/po/' {}
find package/*/custom/*/ -maxdepth 2 -d -name "zh-cn" | xargs -i rename -v 's/zh-cn/zh_Hans/' {}
sed -i "/po2lmo /d" package/*/custom/*/Makefile
sed -i "/luci\/i18n/d" package/*/custom/*/Makefile
sed -i "/*\.po/d" package/*/custom/*/Makefile
sed -i "s/+luci\( \|$\)//g"  package/*/*/*/Makefile
sed -i "s/+nginx\( \|$\)/+nginx-ssl\1/g"  package/*/*/*/Makefile
sed -i 's/+python\( \|$\)/+python3/g' package/*/*/*/Makefile
find package target -name inittab | xargs -i sed -i "s/askfirst/respawn/g" {}
sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V %C by GaryPang'/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
