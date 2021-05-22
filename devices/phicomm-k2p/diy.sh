rm -Rf target/linux/{ramips,generic}
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic target/linux/generic

rm -rf feeds/custom/mt-drivers
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/kernel/mt-drivers package/feeds/custom/mt-drivers

rm -rf include/kernel-version.mk
wget -O include/kernel-version.mk https://raw.githubusercontent.com/coolsnowwolf/lede/master/include/kernel-version.mk

sed -i 's/kmod-mt7615d_dbdc/kmod-mt7615d luci-app-mtwifi/g' target/linux/ramips/image/mt7621.mk

sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json

rm -Rf files/etc/profile.d/sysinfo.sh

sed -i 's/O2/Os/g' include/target.mk

sed -i '/unsplash.com/d' package/feeds/custom/luci-theme-edge/luasrc/view/themes/edge/sysauth.htm

sed -i 's?<img src="<%=media%>/background/3.jpg" alt="img"/>??' package/feeds/custom/luci-theme-edge/luasrc/view/themes/edge/sysauth.htm

rm -f package/feeds/custom/luci-theme-edge/htdocs/luci-static/edge/background/3.jpg

sed -i '/app_update/d' package/feeds/custom/luci-app-bypass/luasrc/controller/bypass.lua

sed -i 's/PKG_VERSION:=1/PKG_VERSION:=2/' package/feeds/custom/luci-app-bypass/Makefile

sed -i 's/ +unzip +lua-maxminddb//' package/feeds/custom/luci-app-bypass/Makefile

sed -i '/status_bottom/d' package/feeds/custom/luci-app-bypass/luasrc/model/cbi/bypass/base.lua

rm -Rf package/feeds/custom/luci-app-bypass/{root/www,root/usr/share/bypass/GeoLite2-Country.mmdb}
