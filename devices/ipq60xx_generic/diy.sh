#!/bin/bash
shopt -s extglob

rm -rf package/boot/uboot-envtools package/kernel package/firmware/ath11k* package/qca target/linux/generic target/linux/ipq60xx package/network/config/netifd feeds/kiddin9/fullconenat toolchain tools/squashfskit4
svn export --force https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/boot/uboot-envtools package/boot/uboot-envtools
svn export --force https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/firmware/ath11k-firmware package/firmware/ath11k-firmware
svn export --force https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/qca package/qca

svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/target/linux/generic target/linux/generic
svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/target/linux/ipq60xx target/linux/ipq60xx
wget -P dl/ https://github.com/coolsnowwolf/openwrt-gl-ax1800/raw/master/dl/linux-4.4.60.tar.xz
svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/kernel package/kernel
svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/network/services/fullconenat feeds/kiddin9/fullconenat
svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/package/network/config/netifd package/network/config/netifd
svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/toolchain toolchain
svn co https://github.com/coolsnowwolf/openwrt-gl-ax1800/trunk/tools/squashfskit4 tools/squashfskit4
rm -rf target/linux/generic/files
rm -rf package/network/config/netifd/patches

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/openwrt-gl-ax1800/master/include/netfilter.mk -o include/netfilter.mk
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/openwrt-gl-ax1800/master/include/quilt.mk -o include/quilt.mk

rm -rf toolchain/.svn
rm -rf feeds/kiddin9/{rtl*,fullconenat-nft,shortcut-fe,netifd} package/kernel/mt76 toolchain/musl package/feeds/packages/{xtables-addons,openvswitch} package/libs/elfutils package/utils/util-linux package/feeds/luci/ucode-mod-html package/libs/openssl package/network/utils/iptables package/feeds/packages/v4l2loopback package/feeds/packages/jool package/network/utils/uqmi
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/toolchain/musl toolchain/musl
svn co https://github.com/openwrt/openwrt/branches/openwrt-23.05/toolchain/glibc toolchain/glibc
svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/package/libs/elfutils package/libs/elfutils
svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/package/utils/util-linux package/utils/util-linux
svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/package/libs/openssl package/libs/openssl
svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/package/network/utils/iptables package/network/utils/iptables
svn co https://github.com/openwrt/openwrt/branches/openwrt-22.03/package/network/utils/uqmi package/network/utils/uqmi

sed -i "s/5.4.0/4.4.0/" toolchain/glibc/common.mk

echo '
CONFIG_PNP_DEBUG_MESSAGES=y
CONFIG_PINCTRL_BAYTRAIL=n
CONFIG_PINCTRL_CHERRYVIEW=n
CONFIG_PINCTRL_BROXTON=n
CONFIG_PINCTRL_SUNRISEPOINT=n
CONFIG_PINCTRL_QDF2XXX=n
CONFIG_GPIO_AMDPT=n
CONFIG_PCC=n
CONFIG_PMIC_OPREGION=n
CCONFIG_RYPTO_CRC32_ARM64=n
' >> ./target/linux/ipq60xx/config-4.4
