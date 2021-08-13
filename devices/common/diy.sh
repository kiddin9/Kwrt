#!/bin/bash
#=================================================
echo "src-git custom https://github.com/kiddin9/openwrt-packages.git" >>feeds.conf.default
sed -i '/	refresh_config();/d' scripts/feeds
./scripts/feeds update -a
./scripts/feeds install -a -p custom
./scripts/feeds install -a
sed -i 's/Os/O2/g' include/target.mk
rm -Rf tools/upx && svn export https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
rm -Rf tools/ucl && svn export https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
svn co https://github.com/immortalwrt/immortalwrt/branches/master/target/linux/generic/hack-5.4 target/linux/generic/hack-5.4
rm -rf target/linux/generic/hack-5.4/220-gc_sections.patch
#svn co https://github.com/immortalwrt/immortalwrt/branches/master/target/linux/generic/hack-5.10 target/linux/generic/hack-5.10
svn export --force https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/network/services/ppp package/network/services/ppp
svn export --force https://github.com/immortalwrt/immortalwrt/branches/master/package/network/services/dnsmasq package/network/services/dnsmasq
sed -i 's/$(TARGET_DIR)) install/$(TARGET_DIR)) install --force-overwrite/' package/Makefile
sed -i '$a /etc/sysupgrade.conf' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/acme' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/bench.log' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '/\/etc\/profile/d' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '/^\/etc\/profile/d' package/base-files/Makefile
# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
sed -i '$a CONFIG_ACPI=y\nCONFIG_X86_ACPI_CPUFREQ=y\nCONFIG_NR_CPUS=128\nCONFIG_FAT_DEFAULT_IOCHARSET="utf8"\nCONFIG_CRYPTO_CHACHA20_NEON=y\n \
CONFIG_CRYPTO_CHACHA20POLY1305=y\nCONFIG_BINFMT_MISC=y' `find target/linux -path "target/linux/*/config-*"`
sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
#rm -rf ./feeds/packages/lang/{golang,node}
#svn export https://github.com/immortalwrt/packages/trunk/lang/golang feeds/packages/lang/golang
#svn export https://github.com/immortalwrt/packages/trunk/lang/node feeds/packages/lang/node
rm -f package/network/config/firewall/patches/fullconenat.patch
wget -P package/network/config/firewall/patches/ https://github.com/coolsnowwolf/lede/raw/master/package/network/config/firewall/patches/fullconenat.patch
sed -i 's/+python\( \|$\)/+python3/g' package/*/*/*/Makefile
sed -i 's?../../lang?$(TOPDIR)/feeds/packages/lang?g' package/feeds/custom/*/Makefile
sed -i 's/PKG_BUILD_DIR:=/PKG_BUILD_DIR?=/g' feeds/luci/luci.mk
sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json
sed -i "s/askfirst/respawn/g" `find package target -name inittab`
for ipk in $(find package/feeds/custom/* -maxdepth 0); do
	if [[ ! -d "$ipk/patches" && ! "$(grep "codeload.github.com" $ipk/Makefile)" ]]; then
		sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=HEAD/g" `find $ipk/ -maxdepth 1 ! -path *tcping* -name "Makefile"`
	fi	
done
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION=\"%D %C by Kiddin'\"/g" package/base-files/files/etc/openwrt_release
sed -i "s/CONFIG_VERSION_CODE=.*/CONFIG_VERSION_CODE=\"$date\"/g" devices/common/.config
sed -i '$a cgi-timeout = 300' package/feeds/packages/uwsgi/files-luci-support/luci-webui.ini

if [ -f sdk.tar.xz ]; then
	sed -i 's,$(STAGING_DIR_HOST)/bin/upx,upx,' package/feeds/custom/*/Makefile
	mkdir sdk
	tar -xJf sdk.tar.xz -C sdk
	cp -rf sdk/*/staging_dir/* ./staging_dir/
	rm -rf sdk.tar.xz sdk
	sed -i '/\(tools\|toolchain\)\/Makefile/d' Makefile
	if [ -f /usr/bin/python ]; then
		ln -sf /usr/bin/python staging_dir/host/bin/python
	else
		ln -sf /usr/bin/python3 staging_dir/host/bin/python
	fi
	ln -sf /usr/bin/python3 staging_dir/host/bin/python3
fi
