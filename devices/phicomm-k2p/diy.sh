rm -Rf files/etc/profile.d/sysinfo.sh

find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
rm -Rf target/linux/ramips/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips/patches-5.4 target/linux/ramips/patches-5.4

sed -i 's/O2/Os/g' include/target.mk

sed -i '/app_update/d' package/feeds/custom/luci-app-bypass/luasrc/controller/bypass.lua

sed -i 's/PKG_VERSION:=1/PKG_VERSION:=2/' package/feeds/custom/luci-app-bypass/Makefile

sed -i 's/ +unzip +lua-maxminddb//' package/feeds/custom/luci-app-bypass/Makefile

sed -i '/status_bottom/d' package/feeds/custom/luci-app-bypass/luasrc/model/cbi/bypass/bypass.lua

rm -Rf package/feeds/custom/luci-app-bypass/root/www package/feeds/custom/luci-app-bypass/root/usr/share/bypass/GeoLite2-Country.mmdb
