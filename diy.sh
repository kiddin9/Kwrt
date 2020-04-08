#!/bin/bash
#=================================================
svn co --force https://github.com/coolsnowwolf/lede/trunk/package/lean package/lean && svn revert -R package/lean
rm -Rf package/lean/qBittorrent/patches
sed -i 's/PKG_SOURCE_URL:=.*/PKG_SOURCE_URL:=https:\/\/github.com\/c0re100\/qBittorrent-Enhanced-Edition/g' package/lean/qBittorrent/Makefile
sed -i 's/PKG_HASH.*/PKG_SOURCE_PROTO:=git\nPKG_SOURCE_VERSION:=latest/g' package/lean/qBittorrent/Makefile
sed -i '/PKG_BUILD_DIR/d' package/lean/qBittorrent/Makefile
sed -i 's/+python$/+python3/g' package/lean/luci-app-qbittorrent/Makefile
rm -Rf package/feeds/packages/php7
svn co https://github.com/openwrt/packages/branches/openwrt-19.07/lang/php7 package/feeds/packages/php7
git clone https://github.com/MatteoRagni/AmuleWebUI-Reloaded files/usr/share/amule/webserver/AmuleWebUI-Reloaded
git clone https://github.com/P3TERX/aria2.conf files/usr/share/aria2
rm -Rf package/lean/antileech/src/*
git clone https://github.com/persmule/amule-dlp.antiLeech package/lean/antileech/src

cd package/feeds
git clone https://github.com/rufengsuixing/luci-app-adguardhome
git clone https://github.com/jerrykuku/luci-theme-argon
git clone https://github.com/pymumu/luci-app-smartdns -b lede
git clone https://github.com/lisaac/luci-app-diskman
mkdir parted && cp luci-app-diskman/Parted.Makefile parted/Makefile
git clone https://github.com/tty228/luci-app-serverchan
git clone https://github.com/brvphoenix/luci-app-wrtbwmon
git clone https://github.com/brvphoenix/wrtbwmon
git clone https://github.com/destan19/OpenAppFilter
svn co https://github.com/jsda/packages2/trunk/ntlf9t/luci-app-advancedsetting

svn co https://github.com/Lienol/openwrt-package/trunk/lienol/luci-app-passwall
svn co https://github.com/Lienol/openwrt-package/trunk/package/tcping
svn co https://github.com/Lienol/openwrt-package/trunk/package/chinadns-ng
svn co https://github.com/Lienol/openwrt-package/trunk/package/brook

git clone https://github.com/lisaac/luci-app-dockerman
git clone https://github.com/garypang13/openwrt-adguardhome
git clone https://github.com/garypang13/luci-app-php-kodexplorer
git clone https://github.com/garypang13/luci-app-eqos
cd -

cp -Rf ../diy/* ./
sed -i 's/root\/.aria2/usr\/share\/aria2/g' files/usr/share/aria2/aria2.conf
sed -i 's/root\/Download/data\/download\/aria2/g' files/usr/share/aria2/*
sed -i '/resolvfile=/d' package/feeds/luci-app-adguardhome/root/etc/init.d/AdGuardHome
sed -i 's/+uhttpd //g' feeds/luci/collections/luci/Makefile
sed -i '/_redirect2ssl/d' package/feeds/*/nginx/Makefile
sed -i '/init_lan/d' package/feeds/*/nginx/files/nginx.init
sed -i "s/sed '\/^$\/d' \"\$config_file_tmp\" >\"\$config_file\"/cd \/usr\/share\/aria2 \&\& sh .\/tracker.sh\ncat \/usr\/share\/aria2\/aria2.conf > \"\$config_file\"\n\
echo '' >> \"\$config_file\"\nsed '\/^$\/d' \"\$config_file_tmp\" >> \"\$config_file\"/g" package/feeds/packages/aria2/files/aria2.init
sed -i 's/runasuser "$config_dir"/runasuser "$config_dir"\nwget -P "$config_dir" -O "$config_dir\/nodes.dat" \
http:\/\/upd.emule-security.org\/nodes.dat/g' package/*/luci-app-amule/root/etc/init.d/amule
sed -i '$a /etc/smartdns' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /www/kod/config' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/qBittorrent' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /root/amule' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/amule' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/aria2' package/base-files/files/lib/upgrade/keep.d/base-files-essential
find target/linux/x86 -name "config*" | xargs -i sed -i '$a CONFIG_64BIT=y\n# CONFIG_WLAN is not set\n# CONFIG_WIRELESS is not set\
\nCONFIG_NETFILTER=y\nCONFIG_NETFILTER_XTABLES=y\nCONFIG_NETFILTER_XT_MATCH_STRING=y\nCONFIG_HWMON=y\nCONFIG_SENSORS_CORETEMP=y' {}
sed -i '/continue$/d' package/*/luci-app-ssr-plus/root/usr/bin/ssr-switch
sed -i 's/if test_proxy/sleep 3600\nif test_proxy/g' package/*/luci-app-ssr-plus/root/usr/bin/ssr-switch
sed -i 's/ uci.cursor/ luci.model.uci.cursor/g' package/*/luci-app-ssr-plus/root/usr/share/shadowsocksr/subscribe.lua
sed -i 's/service_start $PROG/service_start $PROG -R/g' package/feeds/packages/php7/files/php7-fpm.init
sed -i 's/ +kmod-fs-exfat//g' package/*/automount/Makefile
sed -i 's/net.netfilter.nf_conntrack_max=16384/net.netfilter.nf_conntrack_max=105535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
wget -P package/network/config/firewall/patches/ https://github.com/coolsnowwolf/lede/raw/master/package/network/config/firewall/patches/fullconenat.patch
sed -i "s/('Drop invalid packets'));/('Drop invalid packets'));\n o = s.option(form.Flag, 'fullcone', _('Enable FullCone NAT'));/g" \
package/feeds/*/luci-app-firewall/htdocs/luci-static/resources/view/firewall/zones.js
sed -i "s/option forward		REJECT/option forward		REJECT\n	option fullcone	1/g" package/network/config/firewall/files/firewall.config
sed -i "s/option bbr '0'/option bbr '1'/g" package/*/luci-app-flowoffload/root/etc/config/flowoffload
sed -i 's/getElementById("cbid.amule.main/getElementById("widget.cbid.amule.main/g' package/lean/luci-app-amule/luasrc/view/amule/overview_status.htm
getversion(){
if !(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/$1/releases/latest) | grep -o -E "[0-9.]+")
then
  git ls-remote --tags git://github.com/$1 | cut -d/ -f3- | sort -t. -nk1,2 -k3 | awk '/^[^{]*$/{version=$1}END{print version}' | grep -o -E "[0-9.]+"
fi
}
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion v2ray/v2ray-core)/g" package/lean/v2ray/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion aria2/aria2)/g" package/feeds/*/aria2/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion Neilpang/acme.sh)/g" package/feeds/*/acme/Makefile
# sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion netdata/netdata)/g" package/feeds/*/netdata/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion tsl0922/ttyd)/g" package/feeds/*/ttyd/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion docker/docker-ce)/g" package/feeds/*/docker-ce/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion cifsd-team/cifsd)/g" package/feeds/*/ksmbd/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion cifsd-team/cifsd-tools)/g" package/feeds/*/ksmbd-tools/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=v$(getversion AdguardTeam/AdGuardHome)/g" package/feeds/openwrt-adguardhome/Makefile
find package/feeds/*/aria2/ package/feeds/*/acme/ package/feeds/*/netdata/ package/feeds/*/ttyd/ package/feeds/*/docker-ce/ package/lean/v2ray/ \
package/feeds/*/ksmbd/ package/feeds/*/ksmbd-tools/ -maxdepth 2 -name "Makefile" | xargs -i sed -i "s/PKG_HASH:=.*/PKG_HASH:=skip/g" {}
sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' package/feeds/*/Makefile
find package/feeds/*/ package/lean/ -maxdepth 3 ! -path "*shadowsocksr-libev*" -name "Makefile" ! -path "*rblibtorrent1*" -name "Makefile" \
| xargs -i sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=latest/g" {}
find package/feeds/*/ package/lean/ -maxdepth 3 -name "Makefile" | xargs -i sed -i "s/SUBDIRS=/M=/g" {}
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk
sed -i 's/PKG_BUILD_DIR:=/PKG_BUILD_DIR?=/g' feeds/luci/luci.mk
find package/feeds/*/ package/lean/ -maxdepth 3 -path "*luci-app*" -name "Makefile" | xargs -i sed -i 's/$(INCLUDE_DIR)\/package.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/feeds/*/ package/lean/ -maxdepth 3 -d -name "zh-cn" | xargs -i rename -v 's/zh-cn/zh_Hans/' {}
find package/feeds/*/ package/lean/ -maxdepth 3 -name "Makefile" | xargs -i sed -i "/bin\/upx/d" {}
find package/feeds/*/ package/lean/ -maxdepth 3 -name "Makefile" | xargs -i sed -i "/po2lmo /d" {}
find package/feeds/*/ package/lean/ -maxdepth 3 -name "Makefile" | xargs -i sed -i "/luci\/i18n/d" {}
sed -i "/\.po/d" package/feeds/luci-app-diskman/Makefile
find package/feeds/*/ package/lean/ -maxdepth 3 -name "Makefile" | xargs -i sed -i "s/+luci\( \|\$\)//g" {}
find package/feeds/*/ package/lean/ -maxdepth 3 -name "Makefile" | xargs -i sed -i "s/+nginx\( \|\$\)/+nginx-ssl\1/g" {}
sed -i "s/askfirst/respawn/g" target/linux/x86/base-files/etc/inittab
