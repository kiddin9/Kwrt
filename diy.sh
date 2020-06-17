#!/bin/bash
#=================================================
cd feeds/custom/luci
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus
git clone https://github.com/rufengsuixing/luci-app-adguardhome
git clone https://github.com/jerrykuku/luci-theme-argon
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-acme
git clone https://github.com/pymumu/luci-app-smartdns -b lede
git clone https://github.com/lisaac/luci-app-diskman
mkdir parted && cp luci-app-diskman/Parted.Makefile parted/Makefile
git clone https://github.com/tty228/luci-app-serverchan
git clone https://github.com/brvphoenix/luci-app-wrtbwmon
git clone https://github.com/brvphoenix/wrtbwmon
git clone https://github.com/destan19/OpenAppFilter && mv -f OpenAppFilter/* ./
svn co https://github.com/jsda/packages2/trunk/ntlf9t/luci-app-advancedsetting
git clone https://github.com/lisaac/luci-app-dockerman
svn co https://github.com/coolsnowwolf/packages/trunk/sound/forked-daapd
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-sqm
git clone https://github.com/garypang13/r8125
git clone https://github.com/ElonH/Rclone-OpenWrt && mv -f Rclone-OpenWrt/* ./
git clone https://github.com/jefferymvp/luci-app-koolproxyR

svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-passwall
svn co https://github.com/Lienol/openwrt-package/trunk/package/tcping
git clone https://github.com/pexcn/openwrt-chinadns-ng.git chinadns-ng
svn co https://github.com/Lienol/openwrt-package/trunk/package/brook
svn co https://github.com/vernesong/OpenClash/branches/master/luci-app-openclash
git clone https://github.com/frainzy1477/luci-app-clash
svn co https://github.com/Lienol/openwrt-package/trunk/package/ipt2socks
svn co https://github.com/solidus1983/luci-theme-opentomato/trunk/luci/themes/luci-theme-opentomato
svn co https://github.com/Lienol/openwrt-package/trunk/others/luci-app-syncthing
svn co https://github.com/Lienol/openwrt-package/trunk/others/luci-app-control-timewol

git clone https://github.com/garypang13/openwrt-adguardhome
git clone https://github.com/garypang13/luci-app-eqos
# git clone https://github.com/garypang13/openwrt-qbittorrent && mv -f openwrt-qbittorrent/* ./
git clone https://github.com/garypang13/openwrt-filerun
git clone https://github.com/garypang13/luci-app-baidupcs-web
svn co https://github.com/openwrt/packages/branches/openwrt-19.07/libs/libdouble-conversion
svn co https://github.com/Lienol/openwrt-package/trunk/lienol/luci-app-kodexplorer
svn co https://github.com/openwrt/openwrt/branches/openwrt-19.07/package/network/services/samba36
cd -

mv -f feeds/packages/libs/libx264 feeds/custom/luci/libx264
mv -f feeds/packages/net/aria2 feeds/custom/luci/aria2

echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/package/lean feeds/custom/luci
#svn co https://github.com/openwrt/packages/branches/openwrt-19.07/libs/libdouble-conversion feeds/packages/libs/libdouble-conversion
./scripts/feeds update -a && ./scripts/feeds install -a
cp -Rf ./diy/* ./
sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' package/feeds/custom/*/Makefile

rm -Rf package/*/*/autocore
rm -Rf package/*/*/qBittorrent/patches
rm -Rf files/usr/share/amule/webserver/AmuleWebUI-Reloaded && git clone https://github.com/MatteoRagni/AmuleWebUI-Reloaded files/usr/share/amule/webserver/AmuleWebUI-Reloaded
rm -Rf files/usr/share/aria2 && git clone https://github.com/P3TERX/aria2.conf files/usr/share/aria2
rm -Rf package/*/*/antileech/src/* && git clone https://github.com/persmule/amule-dlp.antiLeech package/feeds/custom/antileech/src
rm -Rf tools/upx && svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/default-settings/i18n package/feeds/custom/default-settings/po/zh_Hans

sed -i 's/\[ -e "$FILE" \] && . "$FILE"/[ -e "$FILE" ] \&\& env -i bash "$FILE"/g' package/base-files/files/etc/profile
sed -i 's?"Saving config files..."?"Saving config files..."\nls /overlay/upper/usr/lib/opkg/info/*.list | sed -e "s/.*\\\///" | sed -e "s/\\\.list//" > /etc/installed-opkg\nrm /etc/profile.d/opkginstall.sh /etc/profile.d/sysinfo.sh?g' package/base-files/files/sbin/sysupgrade
sed -i '/depends on PACKAGE_php7-cli || PACKAGE_php7-cgi/d' package/*/*/php7/Makefile
sed -i 's?/etc/config/AdGuardHome?/etc/config/AdGuardHome\n/etc/config/AdGuardHome/AdGuardHome.yaml?g'  package/*/*/luci-app-adguardhome/Makefile
sed -i 's?\(include $(TOPDIR)/feeds/luci/luci.mk\)?define Package/luci-app-ssr-plus/conffiles\n/etc/config/shadowsocksr\nendef\n\1?g'  package/*/*/luci-app-ssr-plus/Makefile
sed -i 's/DEPENDS:= strongswan/DEPENDS:=+strongswan/g' package/*/*/strongswan/Makefile
sed -i 's/+rclone\( \|\$\)/+rclone +fuse-utils\1/g' package/*/*/luci-app-rclone/Makefile
sed -i 's/+acme\( \|\$\)/+acme +acme-dnsapi\1/g' package/*/*/luci-app-acme/Makefile
sed -i 's/+amule\( \|\$\)/+amule +antileech\1/g' package/*/*/luci-app-amule/Makefile
sed -i 's/ @!BUSYBOX_DEFAULT_IP:/ +/g' package/*/*/wrtbwmon/Makefile
sed -i 's/root\/Download/data\/download\/aria2/g' files/usr/share/aria2/*
sed -i '/resolvfile=/d' package/*/*/luci-app-adguardhome/root/etc/init.d/AdGuardHome
sed -i 's/DEPENDS:=/DEPENDS:=+adguardhome /g' package/*/*/luci-app-adguardhome/Makefile
sed -i 's/LUCI_DEPENDS:=/LUCI_DEPENDS:=+transmission-daemon-openssl /g' package/*/*/luci-app-transmission/Makefile
sed -i '/_redirect2ssl/d' package/*/*/nginx/Makefile
sed -i '/init_lan/d' package/*/*/nginx/files/nginx.init
sed -i '$a /etc/sysupgrade.conf' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/smartdns' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/amule' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /www/speedtest/results/telemetry_settings.php' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/installed-opkg' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/php7/custom.ini' package/base-files/files/lib/upgrade/keep.d/base-files-essential
# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
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
sed -i "/foreach pkg/d" feeds/luci/luci.mk;
sed -i 's/$(INCLUDE_DIR)\/package.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' package/*/*/luci-app-*/Makefile
sed -i "/foreach pkg/d" package/*/*/luci-*/Makefile
find package/*/*/luci-*/ package/*/*/luci/ -maxdepth 1 -name Makefile | xargs -i sed -i '$a $(foreach pkg,$(LUCI_BUILD_PACKAGES),$(eval $(call BuildPackage,$(pkg))))' {}
find package/*/custom/*/ -maxdepth 1 -d -name "i18n" | xargs -i rename -v 's/i18n/po/' {}
find package/*/custom/*/ -maxdepth 2 -d -name "zh-cn" | xargs -i rename -v 's/zh-cn/zh_Hans/' {}
sed -i "/bin\/upx/d" package/*/*/*/Makefile
sed -i "/po2lmo /d" package/*/custom/*/Makefile
sed -i "/luci\/i18n/d" package/*/custom/*/Makefile
sed -i "/*\.po/d" package/*/custom/*/Makefile
sed -i "s/+luci\( \|\$\)//g"  package/*/*/*/Makefile
sed -i "s/+nginx\( \|\$\)/+nginx-ssl\1/g"  package/*/*/*/Makefile
sed -i 's/+python\( \|\$\)/+python3/g' package/*/*/*/Makefile
sed -i 's/@IPV6 //g' package/*/*/*/netfilter.mk
sed -i "s/askfirst/respawn/g" target/linux/x86/base-files/etc/inittab
sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V %C by GaryPang'/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
cp -f default-settings package/*/*/default-settings/files/zzz-default-settings
if [ -n "$(ls -A "patches" 2>/dev/null)" ]; then
   find "patches" -type f -name '*.patch'| xargs -i git apply {}
fi
