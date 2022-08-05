#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
bash $SHELL_FOLDER/../common/kernel_5.15.sh
	
rm -rf package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k* package/qca package/qat target/linux/generic package/kernel/mac80211

svn export --force https://github.com/Boos4721/openwrt/trunk/package/boot/uboot-envtools package/boot/uboot-envtools
svn export --force https://github.com/Boos4721/openwrt/trunk/package/firmware/ipq-wifi package/firmware/ipq-wifi
svn export --force https://github.com/Boos4721/openwrt/trunk/package/firmware/ath11k-board package/firmware/ath11k-board
svn export --force https://github.com/Boos4721/openwrt/trunk/package/firmware/ath11k-firmware package/firmware/ath11k-firmware
svn export --force https://github.com/Boos4721/openwrt/trunk/package/qca package/qca
svn export --force https://github.com/Boos4721/openwrt/trunk/package/qat package/qat

svn export --force https://github.com/Boos4721/openwrt/trunk/package/boot/uboot-envtools package/boot/uboot-envtools
curl -sfL https://raw.githubusercontent.com/Boos4721/openwrt/master/package/kernel/linux/modules/netsupport.mk -o package/kernel/linux/modules/netsupport.mk

function git_sparse_clone() (
          commitid="$1" rurl="$2" localdir="$3" && shift 3
          git clone --filter=blob:none --sparse $rurl $localdir
          cd $localdir
		  git checkout $commitid
          git sparse-checkout init --cone
          git sparse-checkout set $@
          )

git_sparse_clone 0890af20fadfd30b9e201fc7c279cdcabf2120f1 "https://github.com/Boos4721/openwrt" "boos" target/linux/ipq807x target/linux/generic include package/kernel/mac80211
cp -rf boos/target/linux/ipq807x target/linux/
cp -rf boos/target/linux/generic target/linux/
cp -rf boos/package/kernel/mac80211 package/kernel/
cp -rf boos/include/kernel-5.15.mk include/kernel-5.15

kernel_v="$(cat include/kernel-5.15 | grep LINUX_KERNEL_HASH-* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
sed -i "s?targets/%S/.*'?targets/%S/$kernel_v'?" include/feeds.mk

curl -sfL https://raw.githubusercontent.com/Lstions/openwrt-boos/master/target/linux/ipq807x/patches-5.15/608-5.15-qca-nss-ssdk-delete-fdb-entry-using-netdev -o target/linux/ipq807x/patches-5.15/608-5.15-qca-nss-ssdk-delete-fdb-entry-using-netdev.patch

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-turboacc/' target/linux/ipq807x/Makefile

echo '
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
' >> ./target/linux/ipq807x/config-5.15
