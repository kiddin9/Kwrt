#!/bin/bash
#=================================================
rm -Rf package/lean tmp
cd feeds/custom/luci
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus
# git clone https://github.com/rufengsuixing/luci-app-adguardhome
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome
git clone https://github.com/garypang13/luci-theme-edge
git clone https://github.com/jerrykuku/luci-theme-argon
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-acme
svn co https://github.com/coolsnowwolf/packages/trunk/net/miniupnpd
git clone https://github.com/pymumu/luci-app-smartdns -b lede
git clone https://github.com/lisaac/luci-app-diskman
mkdir parted && cp luci-app-diskman/Parted.Makefile parted/Makefile
git clone https://github.com/tty228/luci-app-serverchan
git clone https://github.com/brvphoenix/luci-app-wrtbwmon
git clone https://github.com/brvphoenix/wrtbwmon
git clone https://github.com/destan19/OpenAppFilter && mv -f OpenAppFilter/* ./
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-advancedsetting
git clone https://github.com/lisaac/luci-app-dockerman
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-sqm
git clone https://github.com/garypang13/r8125
git clone https://github.com/ElonH/Rclone-OpenWrt && mv -f Rclone-OpenWrt/* ./
# git clone https://github.com/jefferymvp/luci-app-koolproxyR
svn co https://github.com/chuansao-258/filters-openwrt/trunk/luci-app-koolproxyR
git clone https://github.com/garypang13/luci-app-qbittorrent
git clone https://github.com/jerrykuku/luci-app-vssr
git clone https://github.com/jerrykuku/lua-maxminddb
git clone https://github.com/peter-tank/luci-app-dnscrypt-proxy2
git clone https://github.com/rufengsuixing/luci-app-autoipsetadder
git clone https://github.com/jerrykuku/node-request.git
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/luci-theme-argon

svn co https://github.com/vernesong/OpenClash/branches/master/luci-app-openclash
git clone https://github.com/frainzy1477/luci-app-clash
svn co https://github.com/solidus1983/luci-theme-opentomato/trunk/luci/themes/luci-theme-opentomato
svn co https://github.com/Lienol/openwrt-package/trunk/others/luci-app-syncthing
svn co https://github.com/Lienol/openwrt-package/trunk/others/luci-app-control-timewol
svn co https://github.com/dogbutcat/openwrt-packages/trunk/openwrt-udp2raw
svn co https://github.com/dogbutcat/openwrt-packages/trunk/speederv2

git clone https://github.com/garypang13/openwrt-adguardhome
git clone https://github.com/garypang13/luci-app-eqos
git clone https://github.com/garypang13/luci-app-amule
# git clone https://github.com/garypang13/openwrt-qbittorrent && mv -f openwrt-qbittorrent/* ./
git clone https://github.com/garypang13/openwrt-filerun
git clone https://github.com/garypang13/luci-app-baidupcs-web
svn co https://github.com/openwrt/packages/branches/openwrt-19.07/libs/libdouble-conversion
svn co https://github.com/openwrt/openwrt/branches/openwrt-19.07/package/network/services/samba36
cd -

mv -f feeds/packages/libs/libx264 feeds/custom/luci/libx264
mv -f feeds/packages/net/aria2 feeds/custom/luci/aria2
mv -f feeds/packages/admin/netdata feeds/custom/luci/netdata
rm -Rf feeds/packages/net/miniupnpd

echo -e "\q" | svn co https://github.com/Lienol/openwrt-package/trunk/lienol feeds/custom/luci
rm -rf feeds/custom/luci/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/package/lean feeds/custom/luci
rm -rf feeds/custom/luci/.svn
echo -e "\q" | svn co https://github.com/Lienol/openwrt-package/trunk/package feeds/custom/luci
rm -rf feeds/custom/luci/.svn
echo -e "\q" | svn co https://github.com/project-openwrt/openwrt/branches/openwrt-19.07/package/ctcgfw feeds/custom/luci

rm -Rf feeds/custom/luci/openwrt-chinadns-ng feeds/custom/luci/openwrt-simple-obfs feeds/custom/luci/openwrt-v2ray-plugin
rm -Rf tools/upx && svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
rm -Rf tools/ucl && svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
sed -i 's?zip zstd$?zip zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
./scripts/feeds update -a && ./scripts/feeds install -a
rm -Rf package/*/*/rtl8821cu package/*/*/rtl88x2bu
sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' package/feeds/custom/*/Makefile
sed -i 's/$(MAKE)/$(MAKE) XCFLAGS="-DMULTITHREAD=16 -DUSE_PTHREAD"/g' package/*/*/coremark/Makefile
sed -i 's/-std=\(gnu\|c\)++\(11\|14\)//g' package/feeds/*/*/Makefile
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.4 target/linux/generic/hack-5.4
rm -Rf package/*/*/qBittorrent/patches
rm -Rf package/*/*/luci-app-zerotier/root/etc/init.d/zerotier
rm -Rf files/usr/share/aria2 && git clone https://github.com/P3TERX/aria2.conf files/usr/share/aria2
chmod +x files/usr/share/aria2/*.sh
rm -Rf package/*/*/antileech/src/* && git clone https://github.com/persmule/amule-dlp.antiLeech feeds/custom/luci/antileech/src
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/default-settings/i18n feeds/custom/luci/default-settings/po/zh_Hans
sed -i '/index.htm/d' package/*/*/autocore/Makefile
sed -i "s/'class': 'table'/'class': 'table memory'/g" package/*/*/luci-mod-status/htdocs/luci-static/resources/view/status/include/20_memory.js
sed -i 's/\[ -e "$FILE" \] && . "$FILE"/[ -e "$FILE" ] \&\& \[ -f "\/bin\/bash" \] \&\& env -i bash "$FILE" || . "$FILE"/g' package/base-files/files/etc/profile
sed -i 's/var opts = \[\]/var opts = \["-k"\]/g' package/feeds/luci/luci-mod-system/htdocs/luci-static/resources/view/system/flash.js
sed -i '/depends on PACKAGE_php7-cli || PACKAGE_php7-cgi/d' package/*/*/php7/Makefile
sed -i 's?/etc/config/AdGuardHome?/etc/config/AdGuardHome\n/etc/config/AdGuardHome/AdGuardHome.yaml?g'  package/*/*/luci-app-adguardhome/Makefile
sed -i 's?\(include $(TOPDIR)/feeds/luci/luci.mk\)?define Package/luci-app-ssr-plus/conffiles\n/etc/config/shadowsocksr\nendef\n\1?g'  package/*/*/luci-app-ssr-plus/Makefile
sed -i 's/DEPENDS:= strongswan/DEPENDS:=+strongswan/g' package/*/*/strongswan/Makefile
sed -i '/ipsec.init/d' package/*/*/strongswan/Makefile
sed -i 's/+rclone\( \|$\)/+rclone +fuse-utils\1/g' package/*/*/luci-app-rclone/Makefile
sed -i 's/+acme\( \|$\)/+acme +acme-dnsapi\1/g' package/*/*/luci-app-acme/Makefile
sed -i 's/ @!BUSYBOX_DEFAULT_IP:/ +/g' package/*/*/wrtbwmon/Makefile
sed -i 's/root\/Download/data\/download\/aria2/g' files/usr/share/aria2/*
sed -i '/resolvfile=/d' package/*/*/luci-app-adguardhome/root/etc/init.d/AdGuardHome
sed -i 's/DEPENDS:=/DEPENDS:=+adguardhome /g' package/*/*/luci-app-adguardhome/Makefile
sed -i '/EXTRA_DEPENDS:=nginx-util/d' package/*/*/nginx-util/Makefile
sed -i '/_redirect2ssl/d' package/*/*/nginx/Makefile
sed -i '/init_lan/d' package/*/*/nginx/files/nginx.init
sed -i '$a /etc/sysupgrade.conf' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/smartdns' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/amule' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /www/speedtest/results/telemetry_settings.php' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/php7/custom.ini' package/base-files/files/lib/upgrade/keep.d/base-files-essential
# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
sed -i '$a CONFIG_ACPI=y\nCONFIG_X86_ACPI_CPUFREQ=y\nCONFIG_CPU_FREQ_GOV_CONSERVATIVE=y\nCONFIG_CPU_FREQ_GOV_POWERSAVE=y\nCONFIG_CPU_FREQ_GOV_USERSPACE=y' target/linux/*/config-*
sed -i '/continue$/d' package/*/*/luci-app-ssr-plus/root/usr/bin/ssr-switch
sed -i 's/if test_proxy/sleep 3600\nif test_proxy/g' package/*/*/luci-app-ssr-plus/root/usr/bin/ssr-switch
sed -i 's/ uci.cursor/ luci.model.uci.cursor/g' package/*/*/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
sed -i 's/service_start $PROG/service_start $PROG -R/g' package/*/*/php7/files/php7-fpm.init
sed -i 's/ +kmod-fs-exfat//g' package/*/*/automount/Makefile
rm -Rf package/network/config/firewall/patches/fullconenat.patch
wget -P package/network/config/firewall/patches/ https://github.com/coolsnowwolf/lede/raw/master/package/network/config/firewall/patches/fullconenat.patch
sed -i 's/getElementById("cbid/getElementById("widget.cbid/g' package/*/custom/*/luasrc/view/*/*.htm
getversion(){
ver=$(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/$1/releases/latest) | grep -o -E "[0-9].+")
[ $ver ] && echo $ver || git ls-remote --tags git://github.com/$1 | cut -d/ -f3- | sort -t. -nk1,2 -k3 | awk '/^[^{]*$/{version=$1}END{print version}' | grep -o -E "[0-9].+"
}
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion v2ray/v2ray-core)/g" package/*/*/v2ray/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion AdguardTeam/AdGuardHome)/g" package/*/*/openwrt-adguardhome/Makefile
sed -i "s/PKG_HASH:=.*/PKG_HASH:=skip/g" package/feeds/custom/*/Makefile
find package/*/custom/*/ -maxdepth 2 ! -path "*shadowsocksr-libev*" -name "Makefile" ! -path "*rclone*" -name "Makefile" \
! -path "*ipt2socks*" -name "Makefile" | xargs -i sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=latest/g" {}
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
