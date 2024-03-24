#!/bin/bash

rm -rf target/linux package/kernel package/boot package/firmware/linux-firmware package/network/config/wifi-scripts config/Config-images.in

mkdir new; cp -rf .git new/.git
cd new
git reset --hard origin/master

cp -rf --parents target/linux package/kernel package/boot package/firmware/linux-firmware include/kernel-6.1 package/network/config/wifi-scripts config/Config-images.in ../
cd -

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic/hack-6.1

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch -o target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch

rm -rf target/linux/generic/hack-6.1/{410-block-fit-partition-parser.patch,724-net-phy-aquantia*,720-net-phy-add-aqr-phys.patch}

mkdir package/kernel/mt76/patches
curl -sfL https://raw.githubusercontent.com/immortalwrt/immortalwrt/master/package/kernel/mt76/patches/0001-mt76-allow-VHT-rate-on-2.4GHz.patch -o package/kernel/mt76/patches/0001-mt76-allow-VHT-rate-on-2.4GHz.patch

rm -rf package/feeds/kiddin9/quectel_Gobinet

cd feeds/packages
rm -rf libs/xr_usb_serial_common net/coova-chilli net/xtables-addons
git_clone_path master https://github.com/openwrt/packages libs/xr_usb_serial_common
git_clone_path master https://github.com/openwrt/packages net/coova-chilli
git_clone_path master https://github.com/openwrt/packages net/xtables-addons
cd -

sed -i 's/=bbr/=cubic/' package/kernel/linux/files/sysctl-tcp-bbr.conf

sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab

sed -i "s/no-lto,/no-lto no-mold,/" include/package.mk

echo "
CONFIG_TESTING_KERNEL=y

" >> devices/common/.config