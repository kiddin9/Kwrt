rm -Rf target/linux/{ramips,generic}
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic target/linux/generic

rm -rf include/kernel-version.mk
wget -O include/kernel-version.mk https://raw.githubusercontent.com/coolsnowwolf/lede/master/include/kernel-version.mk

sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json
