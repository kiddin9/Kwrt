#!/bin/bash

shopt -s extglob

rm -rf target/linux package/kernel package/boot package/firmware

mkdir new; cp -rf .git new/.git
cd new
git reset --hard origin/master

cp -rf --parents target/linux package/kernel package/boot package/firmware include/kernel* config/Config-images.in config/Config-kernel.in include/image*.mk include/trusted-firmware-a.mk include/bpf.mk scripts/ubinize-image.sh package/utils/bcm27xx-utils package/devel/perf package/network/config/qosify ../
cd -

sed -i "s/^.*vermagic$/\techo '1' > \$(LINUX_DIR)\/.vermagic/" include/kernel-defaults.mk

#sed -i "s/\$(PKG_VERSION)-\$(PKG_RELEASE)/\$(PKG_VERSION)-r\$(PKG_RELEASE)/" include/package-defaults.mk

cp -rf devices/common/patches/rootfstargz.patch.main devices/common/patches/rootfstargz.patch
cp -rf devices/common/patches/qca-ssdk.patch.main devices/common/patches/qca-ssdk.patch
cp -rf devices/common/patches/ebpf.patch.main devices/common/patches/ebpf.patch

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic/hack-6.1

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch -P target/linux/generic/pending-6.1/

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -P package/kernel/linux/modules/

rm -rf target/linux/generic/hack-6.1/{410-block-fit-partition-parser.patch,724-net-phy-aquantia*,720-net-phy-add-aqr-phys.patch}

wget -N https://raw.githubusercontent.com/openwrt/openwrt/main/include/u-boot.mk -P include/

wget -N https://raw.githubusercontent.com/immortalwrt/immortalwrt/master/package/kernel/mt76/patches/0001-mt76-allow-VHT-rate-on-2.4GHz.patch -P package/kernel/mt76/patches/

cd feeds/packages
rm -rf kernel libs/xr_usb_serial_common net/xtables-addons
git_clone_path master https://github.com/openwrt/packages kernel libs/xr_usb_serial_common net/xtables-addons
cd ../../

wget -N https://raw.githubusercontent.com/openwrt/packages/master/net/coova-chilli/patches/011-kernel517.patch -P package/feeds/packages/coova-chilli/patches/

sed -i 's/=bbr/=cubic/' package/kernel/linux/files/sysctl-tcp-bbr.conf

sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab

sed -i "s/no-lto,/no-lto no-mold,/" include/package.mk

sed -i "s/OpenWrt/Kwrt/g" package/base-files/files/bin/config_generate package/base-files/image-config.in config/Config-images.in Config.in include/u-boot.mk include/version.mk package/network/config/wifi-scripts/files/lib/wifi/mac80211.sh || true