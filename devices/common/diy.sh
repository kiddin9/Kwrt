#!/bin/bash
#=================================================
rm -Rf feeds/custom/diy
./scripts/feeds update luci packages custom
./scripts/feeds install -a -p custom
./scripts/feeds install -a
sed -i 's/Os/O2/g' include/target.mk
rm -rf target/linux package/kernel
svn export https://github.com/openwrt/openwrt/trunk/target/linux target/linux
curl -L https://raw.githubusercontent.com/openwrt/openwrt/master/include/kernel-version.mk>include/kernel-version.mk
svn export https://github.com/openwrt/openwrt/trunk/package/kernel package/kernel
curl -L https://raw.githubusercontent.com/openwrt/openwrt/master/include/kernel-defaults.mk>include/kernel-defaults.mk
rm -Rf tools/upx && svn export https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
rm -Rf tools/ucl && svn export https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
sed -i 's/ libelf//' tools/Makefile
svn co https://github.com/immortalwrt/immortalwrt/branches/master/target/linux/generic/hack-5.4 target/linux/generic/hack-5.4
svn co https://github.com/immortalwrt/immortalwrt/branches/master/target/linux/generic/hack-5.10 target/linux/generic/hack-5.10
svn export --force https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/network/services/ppp package/network/services/ppp
svn export --force https://github.com/openwrt/openwrt/trunk/package/libs/libnfnetlink package/libs/libnfnetlink
svn export --force https://github.com/immortalwrt/immortalwrt/branches/master/package/network/services/dnsmasq package/network/services/dnsmasq
sed -i "s/'class': 'table'/'class': 'table memory'/g" package/*/*/luci-mod-status/htdocs/luci-static/resources/view/status/include/20_memory.js
sed -i 's/$(TARGET_DIR)) install/$(TARGET_DIR)) install --force-overwrite/' package/Makefile
sed -i '$a /etc/sysupgrade.conf' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/amule' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/acme' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/bench.log' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '/\/etc\/profile/d' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '/^\/etc\/profile/d' package/base-files/Makefile
# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
find target/linux -path "target/linux/*/config-*" | xargs -i sed -i '$a CONFIG_ACPI=y\nCONFIG_X86_ACPI_CPUFREQ=y\n \
CONFIG_NR_CPUS=128\nCONFIG_FAT_DEFAULT_IOCHARSET="utf8"\nCONFIG_CRYPTO_CHACHA20_NEON=y\nCONFIG_CRYPTO_CHACHA20POLY1305=y\nCONFIG_BINFMT_MISC=y' {}
sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
#rm -rf ./feeds/packages/lang/{golang,node}
#svn export https://github.com/immortalwrt/packages/trunk/lang/golang feeds/packages/lang/golang
#svn export https://github.com/immortalwrt/packages/trunk/lang/node feeds/packages/lang/node
mkdir package/network/config/firewall/patches
curl -L https://github.com/coolsnowwolf/lede/raw/master/package/network/config/firewall/patches/fullconenat.patch>package/network/config/firewall/patches/fullconenat.patch
sed -i "s/+nginx\( \|$\)/+nginx-ssl\1/g"  package/*/*/*/Makefile
sed -i 's/+python\( \|$\)/+python3/g' package/*/*/*/Makefile
sed -i 's?../../lang?$(TOPDIR)/feeds/packages/lang?g' package/feeds/custom/*/Makefile
sed -i 's/PKG_BUILD_DIR:=/PKG_BUILD_DIR?=/g' feeds/luci/luci.mk
sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json
find package target -name inittab | xargs -i sed -i "s/askfirst/respawn/g" {}
for ipk in $(find package/feeds/custom/* -maxdepth 0); do
	if [[ ! -d "$ipk/patches" && ! "$(grep "codeload.github.com" $ipk/Makefile)" ]]; then
		find $ipk/ -maxdepth 1 ! -path *tcping* -name "Makefile" \
		| xargs -i sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=HEAD/g" {}
	fi	
done
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION=\"%D %V %C by Kiddin'\"/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
sed -i '$a cgi-timeout = 300' package/feeds/packages/uwsgi/files-luci-support/luci-webui.ini

if [ -f sdk.tar.xz ]; then
	sed -i 's,$(STAGING_DIR_HOST)/bin/upx,upx,' package/feeds/custom/*/Makefile
	mkdir sdk
	tar -xJf sdk.tar.xz -C sdk
	cp -rf sdk/*/staging_dir/* ./staging_dir/
	rm -rf sdk.tar.xz sdk
	find "staging_dir/host/" -maxdepth 2 -name 'libelf*' | xargs -i rm -rf {} || true
	sed -i '/\(tools\|toolchain\)\/Makefile/d' Makefile
	if [ -f /usr/bin/python ]; then
		ln -sf /usr/bin/python staging_dir/host/bin/python
	else
		ln -sf /usr/bin/python3 staging_dir/host/bin/python
	fi
	ln -sf /usr/bin/python3 staging_dir/host/bin/python3
fi
