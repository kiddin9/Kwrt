#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

function git_clone_path() {
          branch="$1" rurl="$2" localdir="gitemp" && shift 2
          git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
          if [ "$?" != 0 ]; then
            echo "error on $rurl"
            return 0
          fi
          cd $localdir
          git sparse-checkout init --cone
          git sparse-checkout set $@
          mv -n $@/* ../$@/ || cp -rf $@ ../$(dirname "$@")/
		  cd ..
		  rm -rf gitemp
          }

rm -rf feeds/kiddin9/{rtl*,fullconenat-nft} package/feeds/luci/rpcd-mod-luci toolchain/musl package/feeds/packages/gptfdisk package/utils/f2fs-tools package/utils/e2fsprogs package/libs/libselinux package/feeds/packages/acl package/feeds/packages/libevdev

rm -rf devices/common/patches/{rootfstargz.patch,kernel_version.patch,seccomp.patch,iptables.patch,kernel-defaults.patch,targets.patch}

#sed -i "/KernelPackage,sound-soc-core/d" package/kernel/linux/modules/sound.mk
#sed -i "/KernelPackage,multimedia-input/d" package/kernel/linux/modules/video.mk

git_clone_path openwrt-23.05 https://github.com/openwrt/openwrt toolchain/musl
git_clone_path openwrt-23.05 https://github.com/openwrt/openwrt package/utils/e2fsprogs
git_clone_path openwrt-23.05 https://github.com/openwrt/openwrt package/utils/ucode
git_clone_path openwrt-23.05 https://github.com/openwrt/openwrt package/libs/libselinux
#ln -sf $(pwd)/feeds/luci/modules/luci-base package/feeds/kiddin9/

sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2099-12-06/" package/network/config/netifd/Makefile

sed -i "s/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-mtk mii_mgr wifi-profile mtkhqos_util wireless-regdb switch regs kmod-warp kmod-mt_wifi kmod-mediatek_hnat kmod-conninfra datconf-lua/" target/linux/mediatek/Makefile
