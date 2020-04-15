#!/bin/bash
#=================================================
rm -Rf package/custom/*
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean package/custom/lean
rm -Rf package/*/*/qBittorrent/patches
sed -i 's/PKG_SOURCE_URL:=.*/PKG_SOURCE_URL:=https:\/\/github.com\/c0re100\/qBittorrent-Enhanced-Edition/g' package/*/*/qBittorrent/Makefile
sed -i 's/PKG_HASH.*/PKG_SOURCE_PROTO:=git\nPKG_SOURCE_VERSION:=latest/g' package/*/*/qBittorrent/Makefile
sed -i '/PKG_BUILD_DIR/d' package/*/*/qBittorrent/Makefile
sed -i 's/+python$/+python3/g' package/*/*/luci-app-qbittorrent/Makefile
rm -Rf feeds/packages/lang/php7 && svn co https://github.com/openwrt/packages/branches/openwrt-19.07/lang/php7 feeds/packages/lang/php7
rm -Rf files/usr/share/amule/webserver/AmuleWebUI-Reloaded && git clone https://github.com/MatteoRagni/AmuleWebUI-Reloaded files/usr/share/amule/webserver/AmuleWebUI-Reloaded
rm -Rf files/usr/share/aria2 && git clone https://github.com/P3TERX/aria2.conf files/usr/share/aria2
rm -Rf package/*/*/antileech/src/* && git clone https://github.com/persmule/amule-dlp.antiLeech package/custom/lean/antileech/src
rm -Rf tools/upx && svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/default-settings/i18n package/custom/lean/default-settings/po/zh_Hans

mkdir package/custom/first && cd package/custom/first
git clone https://github.com/rufengsuixing/luci-app-adguardhome
git clone https://github.com/jerrykuku/luci-theme-argon -b 19.07_stable
git clone https://github.com/pymumu/luci-app-smartdns -b lede
git clone https://github.com/lisaac/luci-app-diskman
mkdir parted && cp luci-app-diskman/Parted.Makefile parted/Makefile
git clone https://github.com/tty228/luci-app-serverchan
svn co https://github.com/brvphoenix/luci-app-wrtbwmon/trunk/luci-app-wrtbwmon
svn co https://github.com/brvphoenix/wrtbwmon/trunk/wrtbwmon
git clone https://github.com/destan19/OpenAppFilter && mv -f OpenAppFilter/* ./
svn co https://github.com/jsda/packages2/trunk/ntlf9t/luci-app-advancedsetting
git clone https://github.com/lisaac/luci-app-dockerman
svn co https://github.com/coolsnowwolf/packages/trunk/sound/forked-daapd
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-sqm

svn co https://github.com/Lienol/openwrt-package/trunk/lienol/luci-app-passwall
svn co https://github.com/Lienol/openwrt-package/trunk/package/tcping
svn co https://github.com/Lienol/openwrt-package/trunk/package/chinadns-ng
svn co https://github.com/Lienol/openwrt-package/trunk/package/brook
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
svn co https://github.com/solidus1983/luci-theme-opentomato/branches/dev-v19.07/luci/themes/luci-theme-opentomato

git clone https://github.com/garypang13/openwrt-adguardhome
git clone https://github.com/garypang13/luci-app-php-kodexplorer
git clone https://github.com/garypang13/luci-app-eqos
cd -

cp -Rf ../diy/* ./
# wget https://raw.githubusercontent.com/openwrt/luci/openwrt-19.07/luci.mk -O feeds/luci/luci.mk
sed -i 's/ @!/ +@!/g' package/*/*/wrtbwmon/Makefile
sed -i 's/root\/.aria2/usr\/share\/aria2/g' files/usr/share/aria2/aria2.conf
sed -i 's/root\/Download/data\/download\/aria2/g' files/usr/share/aria2/*
sed -i '/resolvfile=/d' package/*/*/luci-app-adguardhome/root/etc/init.d/AdGuardHome
sed -i 's/LUCI_DEPENDS:=/LUCI_DEPENDS:=+transmission-daemon-openssl +transmission-web-control /g' package/*/*/luci-app-transmission/Makefile
sed -i 's/+uhttpd //g' package/*/*/luci/Makefile
sed -i '/_redirect2ssl/d' package/*/*/nginx/Makefile
sed -i '/init_lan/d' package/*/*/nginx/files/nginx.init
sed -i "s/sed '\/^$\/d' \"\$config_file_tmp\" >\"\$config_file\"/cd \/usr\/share\/aria2 \&\& sh .\/tracker.sh\ncat \/usr\/share\/aria2\/aria2.conf > \"\$config_file\"\n\
echo '' >> \"\$config_file\"\nsed '\/^$\/d' \"\$config_file_tmp\" >> \"\$config_file\"/g" package/*/*/aria2/files/aria2.init
sed -i 's/runasuser "$config_dir"/runasuser "$config_dir"\nwget -P "$config_dir" -O "$config_dir\/nodes.dat" \
http:\/\/upd.emule-security.org\/nodes.dat/g' package/*/*/luci-app-amule/root/etc/init.d/amule
sed -i '$a /etc/smartdns' package/base-files/files/etc/sysupgrade.conf
sed -i '$a /www/kod/config' package/base-files/files/etc/sysupgrade.conf
sed -i '$a /etc/qBittorrent' package/base-files/files/etc/sysupgrade.conf
sed -i '$a /root/amule' package/base-files/files/etc/sysupgrade.conf
sed -i '$a /etc/amule' package/base-files/files/etc/sysupgrade.conf
sed -i '$a /etc/aria2' package/base-files/files/etc/sysupgrade.conf
find target/linux/x86 -name "config*" | xargs -i sed -i '$a CONFIG_64BIT=y\n# CONFIG_WLAN is not set\n# CONFIG_WIRELESS is not set\
\nCONFIG_NETFILTER=y\nCONFIG_NETFILTER_XTABLES=y\nCONFIG_NETFILTER_XT_MATCH_STRING=y\nCONFIG_HWMON=y\nCONFIG_SENSORS_CORETEMP=y\nCONFIG_X86_ACPI_CPUFREQ_CPB=y' {}
sed -i '/continue$/d' package/*/*/luci-app-ssr-plus/root/usr/bin/ssr-switch
sed -i 's/if test_proxy/sleep 3600\nif test_proxy/g' package/*/*/luci-app-ssr-plus/root/usr/bin/ssr-switch
sed -i 's/ uci.cursor/ luci.model.uci.cursor/g' package/*/*/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
sed -i 's/service_start $PROG/service_start $PROG -R/g' package/*/*/php7/files/php7-fpm.init
sed -i 's/ +kmod-fs-exfat//g' package/*/*/automount/Makefile
sed -i 's/net.netfilter.nf_conntrack_max=16384/net.netfilter.nf_conntrack_max=105535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
rm -Rf package/network/config/firewall/patches/fullconenat.patch
wget -P package/network/config/firewall/patches/ https://github.com/coolsnowwolf/lede/raw/master/package/network/config/firewall/patches/fullconenat.patch
sed -i "s/('Drop invalid packets'));/('Drop invalid packets'));\n o = s.option(form.Flag, 'fullcone', _('Enable FullCone NAT'));/g" \
package/*/*/luci-app-firewall/htdocs/luci-static/resources/view/firewall/zones.js
sed -i "s/option forward		REJECT/option forward		REJECT\n	option fullcone	1/g" package/network/config/firewall/files/firewall.config
sed -i "s/option bbr '0'/option bbr '1'/g" package/*/*/luci-app-flowoffload/root/etc/config/flowoffload
sed -i 's/getElementById("cbid.amule.main/getElementById("widget.cbid.amule.main/g' package/*/*/luci-app-amule/luasrc/view/amule/overview_status.htm
getversion(){
if !(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/$1/releases/latest) | grep -o -E "[0-9.]+")
then
  git ls-remote --tags git://github.com/$1 | cut -d/ -f3- | sort -t. -nk1,2 -k3 | awk '/^[^{]*$/{version=$1}END{print version}' | grep -o -E "[0-9.]+"
fi
}
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion v2ray/v2ray-core)/g" package/*/*/v2ray/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion aria2/aria2)/g" package/*/*/aria2/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion Neilpang/acme.sh)/g" package/*/*/acme/Makefile
# sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion netdata/netdata)/g" package/*/*/netdata/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion tsl0922/ttyd)/g" package/*/*/ttyd/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion docker/docker-ce)/g" package/*/*/docker-ce/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion cifsd-team/cifsd)/g" package/*/*/ksmbd/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion cifsd-team/cifsd-tools)/g" package/*/*/ksmbd-tools/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=v$(getversion AdguardTeam/AdGuardHome)/g" package/*/*/openwrt-adguardhome/Makefile
find package/*/*/aria2/ package/*/*/acme/ package/*/*/netdata/ package/*/*/ttyd/ package/*/*/docker-ce/ package/*/*/v2ray/ \
package/*/*/ksmbd/ package/*/*/ksmbd-tools/ -maxdepth 2 -name "Makefile" | xargs -i sed -i "s/PKG_HASH:=.*/PKG_HASH:=skip/g" {}
sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' package/custom/*/*/Makefile
find package/custom/*/ -maxdepth 2 ! -path "*shadowsocksr-libev*" -name "Makefile" ! -path "*rblibtorrent1*" -name "Makefile" \
| xargs -i sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=latest/g" {}
find package/custom/*/ -maxdepth 2 -name "Makefile" | xargs -i sed -i "s/SUBDIRS=/M=/g" {}
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk
sed -i 's/PKG_BUILD_DIR:=/PKG_BUILD_DIR?=/g' feeds/luci/luci.mk
sed -i 's/$(INCLUDE_DIR)\/package.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' package/*/*/luci-app-*/Makefile
sed -i "/foreach pkg/d" feeds/luci/luci.mk;
sed -i "/foreach pkg/d" package/*/*/luci-*/Makefile
sed -i '$a $(foreach pkg,$(LUCI_BUILD_PACKAGES),$(eval $(call BuildPackage,$(pkg))))' package/*/*/luci-*/Makefile
find package/*/*/*/ -maxdepth 1 -d -name "i18n" | xargs -i rename -v 's/i18n/po/' {}
find package/*/*/*/ -maxdepth 2 -d -name "zh-cn" | xargs -i rename -v 's/zh-cn/zh_Hans/' {}
sed -i "/bin\/upx/d" package/*/*/*/Makefile
sed -i "/po2lmo /d" package/*/*/*/Makefile
sed -i "/luci\/i18n/d" package/*/*/*/Makefile
sed -i "/*\.po/d" package/*/*/luci-app-*/Makefile
sed -i "s/+luci\( \|\$\)//g"  package/*/*/*/Makefile
sed -i "s/+nginx\( \|\$\)/+nginx-ssl\1/g"  package/*/*/*/Makefile
sed -i "s/askfirst/respawn/g" target/linux/x86/base-files/etc/inittab

date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_REVISION.*/DISTRIB_REVISION=\"Compiled by GaryPang  $date\"/g" package/base-files/files/etc/openwrt_release
sed -i "s/GaryPang$/GaryPang $date/g" package/base-files/files/etc/banner
