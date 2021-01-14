#!/bin/bash
#=================================================
rm -Rf feeds/custom/diy
mv -f feeds/packages/libs/libx264 feeds/custom/libx264
mv -f feeds/packages/net/openvpn feeds/custom/openvpn
mv -f feeds/packages/admin/netdata feeds/custom/netdata
mv -f feeds/packages/net/shadowsocks-libev feeds/custom/shadowsocks-libev
mv -f feeds/packages/utils/docker feeds/custom/docker
mv -f feeds/packages/utils/dockerd feeds/custom/dockerd
rm -Rf feeds/packages/net/{smartdns,frp,mwan3,miniupnpd,aria2} feeds/luci/applications/{luci-app-dockerman,luci-app-smartdns,luci-app-frpc} feeds/luci/collections/luci-lib-docker
svn co https://github.com/project-openwrt/packages/trunk/lang/python/Flask-RESTful feeds/packages/lang/python/Flask-RESTful
svn co https://github.com/project-openwrt/packages/trunk/lang/node-yarn feeds/packages/lang/node-yarn
./scripts/feeds update luci packages custom
./scripts/feeds install -a
sed -i 's/Os/O2/g' include/target.mk
rm -Rf tools/upx && svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
rm -Rf tools/ucl && svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.4 target/linux/generic/hack-5.4
sed -i "s/'class': 'table'/'class': 'table memory'/g" package/*/*/luci-mod-status/htdocs/luci-static/resources/view/status/include/20_memory.js
sed -i '/depends on PACKAGE_php7-cli || PACKAGE_php7-cgi/d' package/*/*/php7/Makefile
sed -i 's/+acme\( \|$\)/+acme +acme-dnsapi\1/g' package/*/*/luci-app-acme/Makefile
sed -i '/_redirect2ssl/d' package/*/*/nginx/Makefile
sed -i '/init_lan/d' package/*/*/nginx/files/nginx.init
sed -i '$a /etc/sysupgrade.conf' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/amule' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/acme' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/bench.log' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '$a /etc/acme' package/base-files/files/lib/upgrade/keep.d/base-files-essential
sed -i '/\/etc\/profile/d' package/base-files/files/lib/upgrade/keep.d/base-files-essential
# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
find target/linux -path "target/linux/*/config-*" | xargs -i sed -i '$a CONFIG_ACPI=y\nCONFIG_X86_ACPI_CPUFREQ=y\n \
CONFIG_NR_CPUS=128\nCONFIG_FAT_DEFAULT_IOCHARSET="utf8"\nCONFIG_CRYPTO_CHACHA20_NEON=y\nCONFIG_CRYPTO_CHACHA20POLY1305=y\nCONFIG_BINFMT_MISC=y' {}
sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
rm -rf ./feeds/packages/lang/golang
svn co https://github.com/project-openwrt/packages/trunk/lang/golang feeds/packages/lang/golang
mkdir package/network/config/firewall/patches
wget -O package/network/config/firewall/patches/fullconenat.patch https://github.com/coolsnowwolf/lede/raw/master/package/network/config/firewall/patches/fullconenat.patch
sed -i "s/+nginx\( \|$\)/+nginx-ssl\1/g"  package/*/*/*/Makefile
sed -i 's/+python\( \|$\)/+python3/g' package/*/*/*/Makefile
sed -i 's?../../lang?$(TOPDIR)/feeds/packages/lang?g' package/feeds/custom/*/Makefile
sed -i 's?package.mk?package.mk\ninclude $(INCLUDE_DIR)/package_lang.mk?g' package/*/custom/luci-app-*/Makefile
sed -i 's/PKG_BUILD_DIR:=/PKG_BUILD_DIR?=/g' feeds/luci/luci.mk
sed -i '/killall -HUP/d' feeds/luci/luci.mk
find package target -name inittab | xargs -i sed -i "s/askfirst/respawn/g" {}
find package/feeds/custom/*/ -maxdepth 1 -name "Makefile" ! -path "*rclone*" ! -path "*shadowsocksr-libev*" ! -path "*rtl8821cu*" \
| xargs -i sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=latest/g" {}
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V %C by GaryPang'/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
sed -i '$a cgi-timeout = 300' package/feeds/packages/uwsgi/files-luci-support/luci-webui.ini
