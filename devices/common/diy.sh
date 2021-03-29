#!/bin/bash
#=================================================
rm -Rf feeds/custom/diy
rm -Rf feeds/packages/net/{smartdns,mwan3,miniupnpd,aria2,https-dns-proxy,shadowsocks-libev,frp,openvpn} feeds/luci/applications/luci-app-{dockerman,smartdns,frpc,frps,https-dns-proxy}
rm -Rf feeds/packages/utils/cgroupfs-mount
./scripts/feeds update luci packages custom
./scripts/feeds install -a
sed -i 's/Os/O2/g' include/target.mk
rm -Rf tools/upx && svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
rm -Rf tools/ucl && svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
echo -e "\q" | svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/generic/hack-5.4 target/linux/generic/hack-5.4
wget -O target/linux/generic/pending-5.4/601-add-kernel-imq-support.patch https://raw.githubusercontent.com/immortalwrt/immortalwrt/openwrt-21.02/target/linux/generic/pending-5.4/601-add-kernel-imq-support.patch
sed -i "s/'class': 'table'/'class': 'table memory'/g" package/*/*/luci-mod-status/htdocs/luci-static/resources/view/status/include/20_memory.js
sed -i 's/+acme\( \|$\)/+acme +acme-dnsapi\1/g' package/*/*/luci-app-acme/Makefile
sed -i '$a /etc/sysupgrade.conf' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/amule' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/acme' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/bench.log' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/acme' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '/\/etc\/profile/d' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '/^\/etc\/profile/d' package/base-files/Makefile
# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
find target/linux -path "target/linux/*/config-*" | xargs -i sed -i '$a CONFIG_ACPI=y\nCONFIG_X86_ACPI_CPUFREQ=y\n \
CONFIG_NR_CPUS=128\nCONFIG_FAT_DEFAULT_IOCHARSET="utf8"\nCONFIG_CRYPTO_CHACHA20_NEON=y\nCONFIG_CRYPTO_CHACHA20POLY1305=y\nCONFIG_BINFMT_MISC=y' {}
sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
rm -rf ./feeds/packages/lang/{golang,node}
svn co https://github.com/immortalwrt/packages/trunk/lang/golang feeds/packages/lang/golang
svn co https://github.com/immortalwrt/packages/trunk/lang/node feeds/packages/lang/node
mkdir package/network/config/firewall/patches
wget -O package/network/config/firewall/patches/fullconenat.patch https://github.com/coolsnowwolf/lede/raw/master/package/network/config/firewall/patches/fullconenat.patch
sed -i "s/+nginx\( \|$\)/+nginx-ssl\1/g"  package/*/*/*/Makefile
sed -i 's/+python\( \|$\)/+python3/g' package/*/*/*/Makefile
sed -i 's?../../lang?$(TOPDIR)/feeds/packages/lang?g' package/feeds/custom/*/Makefile
sed -i 's?include \.\./\.\.?include $(TOPDIR)/feeds/packages?g' package/feeds/packages/*/*
sed -i 's?package.mk?package.mk\ninclude $(INCLUDE_DIR)/package_lang.mk?g' package/*/custom/luci-app-*/Makefile
sed -i 's?+pdnsd-alt??' package/feeds/custom/luci-app-turboacc/Makefile
sed -i 's/PKG_BUILD_DIR:=/PKG_BUILD_DIR?=/g' feeds/luci/luci.mk
sed -i '/killall -HUP/d' feeds/luci/luci.mk
find package target -name inittab | xargs -i sed -i "s/askfirst/respawn/g" {}
for ipk in $(find package/feeds/custom/* -maxdepth 0); do	
	if [[ ! -d "$ipk/patches" && ! "$(grep "codeload.github.com" $ipk/Makefile)" ]]; then
		find $ipk/ -maxdepth 1 ! -path *tcping* -name "Makefile" \
		| xargs -i sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=HEAD/g" {}
	fi	
done
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V %C by GaryPang'/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
sed -i '$a cgi-timeout = 300' package/feeds/packages/uwsgi/files-luci-support/luci-webui.ini

if [ -f sdk.tar.xz ]; then
	sed -i 's,$(STAGING_DIR_HOST)/bin/upx,upx,' package/feeds/custom/*/Makefile
	mkdir sdk
	tar -xJf sdk.tar.xz -C sdk
	cp -rf sdk/*/build_dir ./
	cp -rf sdk/*/staging_dir/* ./staging_dir/
	rm -rf sdk.tar.xz sdk
	sed -i '/\(tools\|toolchain\)\/Makefile/d' Makefile
	ln -sf /usr/bin/python staging_dir/host/bin/python
	ln -sf /usr/bin/python3 staging_dir/host/bin/python3
fi
