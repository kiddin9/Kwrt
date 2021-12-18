#!/bin/bash

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/x86/patches-5.4 target/linux/x86/patches-5.4
rm -rf target/linux/x86/patches-5.4/.svn

sed -i 's,kmod-r8169,kmod-r8168,g' target/linux/x86/image/64.mk

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_DRM=y
CONFIG_DRM_I915=y
' >> ./target/linux/x86/config-5.4

sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

REPO_BRANCH="$(curl -s https://api.github.com/repos/openwrt/openwrt/tags | jq -r '.[].name' | grep v21 | head -n 1 | sed -e 's/v//')"
vermagic="$(curl -sfL https://downloads.openwrt.org/releases/$REPO_BRANCH/targets/x86/64/kmods/ | grep -o 'href="5\..*/"' | cut -d - -f 3 | cut -d / -f 1)"
sed -i "s/^.*vermagic$/\techo "$vermagic" > \$(LINUX_DIR)\/.vermagic/" include/kernel-defaults.mk
