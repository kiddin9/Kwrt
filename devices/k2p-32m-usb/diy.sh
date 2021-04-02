rm -rf target/linux/ramips
svn co https://github.com/x-wrt/x-wrt/trunk/target/linux/ramips target/linux/ramips

sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json

sed -i 's/PKG_VERSION:=1/PKG_VERSION:=2/' package/feeds/custom/luci-app-bypass/Makefile

sed -i 's/ +lua-maxminddb//' package/feeds/custom/luci-app-bypass/Makefile
sed -i '/status_bottom/d' package/feeds/custom/luci-app-bypass/luasrc/model/cbi/bypass/base.lua
rm -Rf package/feeds/custom/luci-app-bypass/{root/www,root/usr/share/bypass/GeoLite2-Country.mmdb}
