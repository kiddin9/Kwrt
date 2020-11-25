find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
rm -Rf target/linux/ramips/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips

sed -i '/spi-max-frequency/a\\t\tbroken-flash-reset;' target/linux/ramips/dts/mt7621_phicomm_k2p.dts

