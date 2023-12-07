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

rm -rf package/devel/kselftests-bpf package/network/utils/xdp-tools

rm -rf package/boot/uboot-rockchip

git_clone_path master https://github.com/coolsnowwolf/lede package/boot/uboot-rockchip
git_clone_path master https://github.com/coolsnowwolf/lede package/boot/arm-trusted-firmware-rockchip-vendor

rm -rf target/linux/generic target/linux/rockchip/!(Makefile)

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic
git_clone_path master https://github.com/coolsnowwolf/lede target/linux/rockchip

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/include/kernel-5.15 -o include/kernel-5.15

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/linux/modules/video.mk -o package/kernel/linux/modules/video.mk

sed -i "/KernelPackage,ptp/d" package/kernel/linux/modules/other.mk

mv -f tmp/r8125 feeds/kiddin9/

rm -rf target/linux/rockchip/armv8/base-files/etc/uci-defaults/13_opkg_update

sed -i -e 's,kmod-r8168,kmod-r8169,g' target/linux/rockchip/image/armv8.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += fdisk lsblk kmod-drm-rockchip/' target/linux/rockchip/Makefile

sed -i 's/Ariaboard/光影猫/' target/linux/rockchip/image/armv8.mk

cp -Rf $SHELL_FOLDER/diy/* ./

echo '
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/rockchip/armv8/config-5.15
