
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
