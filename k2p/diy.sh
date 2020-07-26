rm -Rf files/etc/profile.d/sysinfo.sh
find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
wget -P https://github.com/privacy-protection-tools/anti-AD/raw/master/anti-ad-smartdns.conf files/etc/smartdns/anti-ad-smartdns.conf
