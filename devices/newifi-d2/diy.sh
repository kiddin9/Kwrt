rm -Rf target/linux/ramips
rm -Rf target/linux/ramips/.svn target/linux/ramips/files/drivers/net/ethernet/ralink
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips/files/drivers/net/ethernet/ralink target/linux/ramips/files/drivers/net/ethernet/ralink

