#!/bin/bash
#=================================================
shopt -s extglob
sed -i '/	refresh_config();/d' scripts/feeds
./scripts/feeds update -a
./scripts/feeds install -a -p custom
./scripts/feeds install -a
cd feeds/custom; git pull; cd -
sed -i 's/\/cgi-bin\/\(luci\|cgi-\)/\/\1/g' `find package/feeds/custom/luci-*/ -name "*.lua" -or -name "*.htm*" -or -name "*.js"` &
sed -i 's/Os/O2/g' include/target.mk
svn export --force https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
svn export --force https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/generic/hack-5.4 target/linux/generic/hack-5.4
rm -rf target/linux/generic/hack-5.4/220-gc_sections.patch
#svn co https://github.com/immortalwrt/immortalwrt/branches/master/target/linux/generic/hack-5.10 target/linux/generic/hack-5.10
svn export --force https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/network/services/ppp package/network/services/ppp
svn export --force https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/network/services/dnsmasq package/network/services/dnsmasq
sed -i 's/$(TARGET_DIR)) install/$(TARGET_DIR)) install --force-overwrite/' package/Makefile
sed -i 's/root:.*/root:$1$tTPCBw1t$ldzfp37h5lSpO9VXk4uUE\/:18336:0:99999:7:::/g' package/base-files/files/etc/shadow
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
curl -L https://git.io/J0klM --create-dirs -o package/network/config/firewall/patches/fullconenat.patch
sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json
sed -i "s/askfirst/respawn/g" `find package target -name inittab`

sed -i \
	-e "s/+\(luci\|luci-ssl\)\( \|$\)/+luci-ssl-nginx\2/" \
	-e "s/+nginx\( \|$\)/+nginx-ssl\1/" \
	-e 's/+python\( \|$\)/+python3/' \
	-e 's?../../lang?$(TOPDIR)/feeds/packages/lang?' \
	package/feeds/custom/*/Makefile

for ipk in $(ls -d package/feeds/custom/*); do
	if [[ ! -d "$ipk/patches" ]]; then
		sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{7,\}/PKG_SOURCE_VERSION:=HEAD/g" !(luci-app*)/Makefile
	fi	
done
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION=\"%D %C by Kiddin'\"/g" package/base-files/files/etc/openwrt_release
sed -i "s/CONFIG_VERSION_CODE=.*/CONFIG_VERSION_CODE=\"$date\"/g" devices/common/.config
sed -i '$a cgi-timeout = 300' package/feeds/packages/uwsgi/files-luci-support/luci-webui.ini
sed -i 's/limit-as.*/limit-as = 5000/' package/feeds/packages/uwsgi/files-luci-support/luci-webui.ini

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
