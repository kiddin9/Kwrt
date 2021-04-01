find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
rm -Rf target/linux/ramips/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips/patches-5.4 target/linux/ramips/patches-5.4

rm -rf target/linux/ramips/files/drivers/net/ethernet/ralink
svn co https://github.com/x-wrt/x-wrt/trunk/target/linux/ramips/files/drivers/net/ethernet/ralink target/linux/ramips/files/drivers/net/ethernet/ralink

sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json

sed -i 's/PKG_VERSION:=1/PKG_VERSION:=2/' package/feeds/custom/luci-app-bypass/Makefile

sed -i 's/ +lua-maxminddb//' package/feeds/custom/luci-app-bypass/Makefile
sed -i '/status_bottom/d' package/feeds/custom/luci-app-bypass/luasrc/model/cbi/bypass/base.lua
rm -Rf package/feeds/custom/luci-app-bypass/{root/www,root/usr/share/bypass/GeoLite2-Country.mmdb}
