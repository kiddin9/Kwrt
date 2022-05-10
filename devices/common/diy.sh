#!/bin/bash
#=================================================
shopt -s extglob
rm -rf target/linux package/kernel package/boot package/firmware/linux-firmware include/{kernel-*,netfilter.mk} tools/firmware-utils
#latest="$(curl -sfL https://github.com/openwrt/openwrt/tree/master/include | grep -o 'href=".*>kernel: bump 5.15' | head -1 | cut -d / -f 5 | cut -d '"' -f 1)"
mkdir new; cp -rf .git new/.git
cd new
[ "$latest" ] && git reset --hard $latest || (git checkout master && git reset --hard HEAD)
#git reset --hard HEAD^
[ "$(echo $(git log -1 --pretty=short) | grep "kernel: bump 5.15")" ] && git checkout $latest
cp -rf --parents target/linux package/kernel package/boot package/firmware/linux-firmware include/{kernel-*,netfilter.mk} tools/firmware-utils ../
cd -
sed -i 's/ libelf//' tools/Makefile

kernel_v="$(cat include/kernel-5.15 | grep LINUX_KERNEL_HASH-* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
# sed -i "s?targets/%S/packages?packages/%A/kmods/$kernel_v?" include/feeds.mk
echo "$(date +"%s")" >version.date
sed -i '/$(curdir)\/compile:/c\$(curdir)/compile: package/opkg/host/compile' package/Makefile
sed -i "s/DEFAULT_PACKAGES:=/DEFAULT_PACKAGES:=luci-app-advanced luci-app-firewall luci-app-gpsysupgrade luci-app-opkg luci-app-upnp luci-app-autoreboot \
luci-app-wizard luci-app-attendedsysupgrade dnsmasq-full luci-base luci-compat luci-lib-ipkg fdisk \
coremark wget-ssl curl htop nano zram-swap kmod-lib-zstd kmod-tcp-bbr bash /" include/target.mk
sed -i "/dnsmasq \\\/d" include/target.mk

sh -c "curl -sfL https://github.com/coolsnowwolf/lede/commit/06fcdca1bb9c6de6ccd0450a042349892b372220.patch | patch -d './' -p1 --forward"

sed -i '/	refresh_config();/d' scripts/feeds
[ ! -f feeds.conf ] && {
sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages.git;master' feeds.conf.default
}

rm -rf package/{base-files,network/config/firewall,network/services/dnsmasq,network/services/ppp,system/opkg,libs/mbedtls}

./scripts/feeds update -a
./scripts/feeds install -a -p kiddin9
./scripts/feeds install -a
cd feeds/kiddin9; git pull; cd -

sed -i "s/192.168.1/10.0.0/" package/feeds/kiddin9/base-files/files/bin/config_generate
rm -f package/feeds/packages/libpfring; svn export https://github.com/openwrt/packages/trunk/libs/libpfring package/feeds/kiddin9/libpfring
rm -f package/feeds/packages/xtables-addons; svn export https://github.com/openwrt/packages/trunk/net/xtables-addons package/feeds/kiddin9/xtables-addons
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/packages/master/libs/xr_usb_serial_common/patches/0001-fix-build-with-kernel-5.15.patch -o package/feeds/packages/xr_usb_serial_common/patches/0001-fix-build-with-kernel-5.15.patch

(
svn export --force https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
svn export --force https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/generic/hack-5.15 target/linux/generic/hack-5.15
rm -rf target/linux/generic/hack-5.15/{220-gc_sections*,781-dsa-register*,780-drivers-net*}
) &

sed -i 's?zstd$?zstd ucl upx\n$(curdir)/upx/compile := $(curdir)/ucl/compile?g' tools/Makefile
sed -i 's/\/cgi-bin\/\(luci\|cgi-\)/\/\1/g' `find package/feeds/kiddin9/luci-*/ -name "*.lua" -or -name "*.htm*" -or -name "*.js"` &
sed -i 's/Os/O2/g' include/target.mk
sed -i 's/$(TARGET_DIR)) install/$(TARGET_DIR)) install --force-overwrite --force-maintainer/' package/Makefile
sed -i "/mediaurlbase/d" package/feeds/*/luci-theme*/root/etc/uci-defaults/*
sed -i 's/=bbr/=cubic/' package/kernel/linux/files/sysctl-tcp-bbr.conf

# find target/linux/x86 -name "config*" -exec bash -c 'cat kernel.conf >> "{}"' \;
sed -i '$a CONFIG_ACPI=y\nCONFIG_X86_ACPI_CPUFREQ=y\nCONFIG_NR_CPUS=128\nCONFIG_FAT_DEFAULT_IOCHARSET="utf8"\nCONFIG_CRYPTO_CHACHA20_NEON=y\n \
CONFIG_CRYPTO_CHACHA20POLY1305=y\nCONFIG_BINFMT_MISC=y' `find target/linux -path "target/linux/*/config-*"`
sed -i 's/max_requests 3/max_requests 20/g' package/network/services/uhttpd/files/uhttpd.config
#rm -rf ./feeds/packages/lang/{golang,node}
sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab

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
