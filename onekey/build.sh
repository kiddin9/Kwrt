#/bin/bash
echo
echo
echo "This script is only suitable for compiling in Ubuntu environment https://github.com/kiddin9/OpenWrt_x86-r2s-r4s"
echo
echo
sleep 2s
sudo apt-get update
sudo apt-get upgrade

sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc-s1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils libelf-dev autoconf automake libtool autopoint device-tree-compiler ccache xsltproc rename antlr3 gperf curl screen upx-ucl jq



clear 
echo
echo 
echo 
echo "|*************************************************|"
echo "|                                                 |"
echo "|                                                 |"
echo "| The basic environment deployment is complete... |"
echo "|                                                 |"
echo "|                                                 |"
echo "|*************************************************|"
echo
echo


if [ "$USER" == "root" ]; then
	echo
	echo
	echo "Do not use the root user to compile, change to a normal user~~"
	sleep 3s
	exit 0
fi





rm -Rf openwrt

echo "

1. X86_64

2. r2s

3. r4s

4. Rpi-4B

5. Exit

"

while :; do

read -p "Which firmware do you want to compile? " CHOOSE

case $CHOOSE in
	1)
		firmware="x86_64"
	break
	;;
	2)
		firmware="nanopi-r2s"
	break
	;;
	3)
		firmware="nanopi-r4s"
	break
	;;
	4)
	        firmware="nanopi-r2c"
	breaK
	;;
	5)
		firmware="Rpi-4B"
	break
	;;
	6)	exit 0
	;;

esac
done

REPO_BRANCH="$(curl -s https://api.github.com/repos/openwrt/openwrt/tags | jq -r '.[].name' | grep v21 | head -n 1 | sed -e 's/v//')"
git clone -b v$REPO_BRANCH https://github.com/openwrt/openwrt
svn export https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/trunk/devices openwrt/devices

cd openwrt
if [[ $firmware == "x86_64" ]]; then
	curl -fL -o sdk.tar.xz https://mirrors.cloud.tencent.com/openwrt/releases/$REPO_BRANCH/targets/x86/64/openwrt-sdk-$REPO_BRANCH-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz || curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02-SNAPSHOT/targets/x86/64/openwrt-sdk-21.02-SNAPSHOT-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz
elif [[ $firmware == nanopi-* ]]; then
	curl -fL -o sdk.tar.xz https://mirrors.cloud.tencent.com/openwrt/releases/$REPO_BRANCH/targets/rockchip/armv8/openwrt-sdk-$REPO_BRANCH-rockchip-armv8_gcc-8.4.0_musl.Linux-x86_64.tar.xz || curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02-SNAPSHOT/targets/rockchip/armv8/openwrt-sdk-21.02-SNAPSHOT-rockchip-armv8_gcc-8.4.0_musl.Linux-x86_64.tar.xz
elif [[ $firmware == "Rpi-4B" ]]; then
	curl -fL -o sdk.tar.xz https://mirrors.cloud.tencent.com/openwrt/releases/$REPO_BRANCH/targets/bcm27xx/bcm2711/openwrt-sdk-$REPO_BRANCH-bcm27xx-bcm2711_gcc-8.4.0_musl.Linux-x86_64.tar.xz || curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02-SNAPSHOT/targets/bcm27xx/bcm2711/openwrt-sdk-21.02-SNAPSHOT-bcm27xx-bcm2711_gcc-8.4.0_musl.Linux-x86_64.tar.xz
fi


read -p "Please enter the background address [Enter default 10.0.0.1]: " ip
ip=${ip:-"10.0.0.1"}
echo "The device IP address is: $ip"
cp -rf devices/common/* ./
cp -rf devices/$firmware/* ./
if [ -f "devices/common/diy.sh" ]; then
		chmod +x devices/common/diy.sh
		/bin/bash "devices/common/diy.sh"
fi
if [ -f "devices/$firmware/diy.sh" ]; then
		chmod +x devices/$firmware/diy.sh
		/bin/bash "devices/$firmware/diy.sh"
fi
cp -Rf ./diy/* ./
if [ -f "devices/common/default-settings" ]; then
	sed -i 's/10.0.0.1/$ip/' package/*/*/my-default-settings/files/etc/uci-defaults/99-default-settings
fi
if [ -f "devices/$firmware/default-settings" ]; then
	sed -i "s/10.0.0.1/$ip/" devices/$firmware/default-settings
	cat devices/$firmware/default-settings >> package/*/*/my-default-settings/files/etc/uci-defaults/99-default-settings
fi
if [ -n "$(ls -A "devices/common/patches" 2>/dev/null)" ]; then
          find "devices/common/patches" -type f -name '*.patch' ! -name '*.revert.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 --forward"
fi
if [ -n "$(ls -A "devices/$firmware/patches" 2>/dev/null)" ]; then
          find "devices/$firmware/patches" -type f -name '*.patch' ! -name '*.revert.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 --forward"
fi
cp devices/common/.config .config
echo >> .config
cat devices/$firmware/.config >> .config
make defconfig
for i in $(make --file=preset_pkg.mk presetpkg); do
	sed -i "\$a CONFIG_PACKAGE_$i=y" .config
done
make menuconfig
echo
echo
echo
echo "                      *****5秒后开始编译*****

1.你可以随时按Ctrl+C停止编译

3.大陆用户编译前请准备好梯子,使用大陆白名单或全局模式"
echo
echo
echo
sleep 3s

make -j$(($(nproc)+1)) download -j$(($(nproc)+1)) &
make -j$(($(nproc)+1)) || make -j1 V=s

if [ "$?" == "0" ]; then
echo "
	sed -i "s/10.0.0.1/$ip/" devices/$firmware/default-settings
	cat devices/$firmware/default-settings >> package/*/*/my-default-settings/files/etc/uci-defaults/99-default-settings
fi
if [ -n "$(ls -A "devices/common/patches" 2>/dev/null)" ]; then
          find "devices/common/patches" -type f -name '*.patch' ! -name '*.revert.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 --forward"
fi
if [ -n "$(ls -A "devices/$firmware/patches" 2>/dev/null)" ]; then
          find "devices/$firmware/patches" -type f -name '*.patch' ! -name '*.revert.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 --forward"
fi
cp devices/common/.config .config
echo >> .config
cat devices/$firmware/.config >> .config
make defconfig
for i in $(make --file=preset_pkg.mk presetpkg); do
	sed -i "\$a CONFIG_PACKAGE_$i=y" .config
done
make menuconfig
echo
echo
echo
echo "                      *****Start compiling after 5 seconds*****

1. You can stop compiling at any time by pressing Ctrl+C

3. For mainland users, please prepare the ladder before compiling, and use the mainland whitelist or global mode"
echo
echo
echo
sleep 3s

make -j$(($(nproc)+1)) download -j$(($(nproc)+1)) &
make -j$(($(nproc)+1)) || make -j1 V=s

if [ "$?" == "0" ]; then
echo "

Compilation complete~~~

Initial backend address: $ip
Initial username and password: root  root

"
fi


Compilation complete~~~

Initial backend address: $ip
Initial username and password: root  root

"
fi
