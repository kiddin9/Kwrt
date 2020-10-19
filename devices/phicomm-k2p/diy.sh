rm -Rf files/etc/profile.d/sysinfo.sh
rm -Rf target/linux/ramips
rm -Rf target/linux/ramips/.svn target/linux/ramips/files/drivers/net/ethernet/ralink
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips/files/drivers/net/ethernet/ralink target/linux/ramips/files/drivers/net/ethernet/ralink
sed -i 's/O2/Os/g' include/target.mk