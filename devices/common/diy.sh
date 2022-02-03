#!/bin/bash
#=================================================
shopt -s extglob
commitid="$(curl -sfL https://github.com/openwrt/openwrt/commits/master/include | grep -o 'href=".*>kernel: bump 5.10' | head -1 | cut -d / -f 5 | cut -d "#" -f 1)"
version="$(git rev-parse HEAD)"
git checkout $commitid
git checkout HEAD^
[ "$(echo $(git log -1 --pretty=short) | grep "kernel: bump 5.10")" ] && git checkout $commitid
kernel_v="$(cat include/kernel-5.10 | grep LINUX_KERNEL_HASH-5.10* | cut -f 2 -d - | cut -f 1 -d ' ')"
sed -i "s?targets/%S/packages?packages/%A/kmods/$kernel_v?" include/feeds.mk
mv -f target/linux package/kernel package/firmware/linux-firmware include/kernel-version.mk include/kernel-5.10 include/kernel-defaults.mk .github/
git checkout $version
echo "$(date +"%s")" >version.date
rm -rf target/linux package/kernel package/firmware/linux-firmware include/kernel-version.mk include/kernel-5.10 include/kernel-defaults.mk
mv -f .github/linux target/
mv -f .github/kernel package/
mv -f .github/linux-firmware package/firmware/
mv -f  .github/kernel-version.mk .github/kernel-5.10 .github/kernel-defaults.mk include/
sed -i 's/ libelf//' tools/Makefile

sed -i '/$(curdir)\/compile:/c\$(curdir)/compile: package/opkg/host/compile' package/Makefile

sed -i "s/DEFAULT_PACKAGES:=/DEFAULT_PACKAGES:=luci-app-advanced luci-app-firewall luci-app-gpsysupgrade luci-app-opkg luci-app-bypass luci-app-upnp luci-app-autoreboot \
luci-app-wizard luci-app-attendedsysupgrade luci-theme-edge luci-theme-bootstrap dnsmasq-full luci-ssl-nginx luci-base luci-compat luci-lib-ipkg \
coremark my-default-settings wget-ssl curl htop nano iptables-mod-fullconenat zram-swap kmod-lib-zstd kmod-tcp-bbr bash \
wpad-basic-wolfssl kmod-usb2 kmod-usb3 automount /" include/target.mk
sed -i "/dnsmasq \\\/d" include/target.mk
sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += my-autocore-arm luci-app-cpufreq kmod-hwmon-pwmfan/' target/linux/rockchip/Makefile

sed -i '/	refresh_config();/d' scripts/feeds
[ ! -f feeds.conf ] && {
sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages.git;master' feeds.conf.default
}

rm -rf package/{base-files,network/config/firewall,network/services/dnsmasq,network/services/ppp,system/opkg,libs/mbedtls}

./scripts/feeds update -a
./scripts/feeds install -a -p kiddin9
./scripts/feeds install -a
cd feeds/kiddin9; git pull; cd -

(
svn export --force https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
svn export --force https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.10 target/linux/generic/hack-5.10
rm -rf target/linux/generic/hack-5.10/{220-gc_sections*,781-dsa-register*}
) &

sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
sed -i 's/\/cgi-bin\/\(luci\|cgi-\)/\/\1/g' `find package/feeds/kiddin9/luci-*/ -name "*.lua" -or -name "*.htm*" -or -name "*.js"` &
sed -i 's/Os/O2/g' include/target.mk
sed -i 's/$(TARGET_DIR)) install/$(TARGET_DIR)) install --force-overwrite/' package/Makefile
sed -i "/mediaurlbase/d" package/feeds/*/luci-theme*/root/etc/uci-defaults/*
sed -i '/root:/c\root:$1$tTPCBw1t$ldzfp37h5lSpO9VXk4uUE\/:18336:0:99999:7:::' package/feeds/kiddin9/base-files/files/etc/shadow
sed -i 's/=bbr/=cubic/' package/kernel/linux/files/sysctl-tcp-bbr.conf

# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
sed -i '$a CONFIG_ACPI=y\nCONFIG_X86_ACPI_CPUFREQ=y\nCONFIG_NR_CPUS=128\nCONFIG_FAT_DEFAULT_IOCHARSET="utf8"\nCONFIG_CRYPTO_CHACHA20_NEON=y\n \
CONFIG_CRYPTO_CHACHA20POLY1305=y\nCONFIG_BINFMT_MISC=y' `find target/linux -path "target/linux/*/config-*"`
sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
#rm -rf ./feeds/packages/lang/{golang,node}

sed -i "s/tty1::askfirst/tty1::respawn/g" target/linux/*/base-files/etc/inittab
date=`date +%m.%d.%Y`
sed -i -e "/\(# \)\?REVISION:=/c\REVISION:=$date" -e '/VERSION_CODE:=/c\VERSION_CODE:=$(REVISION)' include/version.mk

sed -i "s/^.*vermagic$/\techo '1' > \$(LINUX_DIR)\/.vermagic/" include/kernel-defaults.mk
sed -i 's/ +kmod-thermal//' package/kernel/mt76/Makefile

sed -i \
	-e "s/+\(luci\|luci-ssl\|uhttpd\)\( \|$\)/\2/" \
	-e "s/+nginx\( \|$\)/+nginx-ssl\1/" \
	-e 's/+python\( \|$\)/+python3/' \
	-e 's?../../lang?$(TOPDIR)/feeds/packages/lang?' \
	package/feeds/kiddin9/*/Makefile

(
if [ -f sdk.tar.xz ]; then
	sed -i 's,$(STAGING_DIR_HOST)/bin/upx,upx,' package/feeds/kiddin9/*/Makefile
	mkdir sdk
	tar -xJf sdk.tar.xz -C sdk
	cp -rf sdk/*/staging_dir/* ./staging_dir/
	rm -rf sdk.tar.xz sdk
	rm -rf `find "staging_dir/host/" -maxdepth 2 -name 'libelf*'` || true
	sed -i '/\(tools\|toolchain\)\/Makefile/d' Makefile
	if [ -f /usr/bin/python ]; then
		ln -sf /usr/bin/python staging_dir/host/bin/python
	else
		ln -sf /usr/bin/python3 staging_dir/host/bin/python
	fi
	ln -sf /usr/bin/python3 staging_dir/host/bin/python3
fi
) &
