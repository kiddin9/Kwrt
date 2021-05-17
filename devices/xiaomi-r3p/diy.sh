find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
rm -Rf target/linux/ramips/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips/patches-5.4 target/linux/ramips/patches-5.4

rm -rf include/kernel-version.mk
wget -O include/kernel-version.mk https://raw.githubusercontent.com/coolsnowwolf/lede/master/include/kernel-version.mk

sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json