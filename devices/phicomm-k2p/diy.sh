rm -Rf files/etc/profile.d/sysinfo.sh
find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
rm -Rf target/linux/ramips/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
wget -O devices/phicomm-k2p/patches/5844.patch https://patch-diff.githubusercontent.com/raw/coolsnowwolf/lede/pull/5844.patch
sed -i 's/O2/Os/g' include/target.mk

sed -i 's/PKG_VERSION:=1/PKG_VERSION:=2/' package/feeds/custom/luci-app-ssr-plus/Makefile