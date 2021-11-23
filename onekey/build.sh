#/bin/bash
echo
echo
echo "本脚本仅适用于在Ubuntu环境下编译 https://github.com/kiddin9/OpenWrt_x86-r2s-r4s"
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
echo "|*******************************************|"
echo "|                                           |"
echo "|                                           |"
echo "|           基本环境部署完成......          |"
echo "|                                           |"
echo "|                                           |"
echo "|*******************************************|"
echo
echo


if [ "$USER" == "root" ]; then
	echo
	echo
	echo "请勿使用root用户编译，换一个普通用户吧~~"
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

read -p "你想要编译哪个固件？ " CHOOSE

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
		firmware="Rpi-4B"
	break
	;;
	5)	exit 0
	;;

esac
done

REPO_BRANCH="$(curl -s https://api.github.com/repos/openwrt/openwrt/tags | jq -r '.[].name' | grep v21 | head -n 1 | sed -e 's/v//')"
git clone -b v$REPO_BRANCH --depth 1 https://github.com/openwrt/openwrt
svn export https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/trunk/devices openwrt/devices

cd openwrt
if [[ $firmware == "x86_64" ]]; then
	curl -fL -o sdk.tar.xz https://mirrors.cloud.tencent.com/openwrt/releases/$REPO_BRANCH/targets/x86/64/openwrt-sdk-$REPO_BRANCH-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz || curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02-SNAPSHOT/targets/x86/64/openwrt-sdk-21.02-SNAPSHOT-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz
elif [[ $firmware == nanopi-* ]]; then
	curl -fL -o sdk.tar.xz https://mirrors.cloud.tencent.com/openwrt/releases/$REPO_BRANCH/targets/rockchip/armv8/openwrt-sdk-$REPO_BRANCH-rockchip-armv8_gcc-8.4.0_musl.Linux-x86_64.tar.xz || curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02-SNAPSHOT/targets/rockchip/armv8/openwrt-sdk-21.02-SNAPSHOT-rockchip-armv8_gcc-8.4.0_musl.Linux-x86_64.tar.xz
elif [[ $firmware == "Rpi-4B" ]]; then
	curl -fL -o sdk.tar.xz https://mirrors.cloud.tencent.com/openwrt/releases/$REPO_BRANCH/targets/bcm27xx/bcm2711/openwrt-sdk-$REPO_BRANCH-bcm27xx-bcm2711_gcc-8.4.0_musl.Linux-x86_64.tar.xz || curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02-SNAPSHOT/targets/bcm27xx/bcm2711/openwrt-sdk-21.02-SNAPSHOT-bcm27xx-bcm2711_gcc-8.4.0_musl.Linux-x86_64.tar.xz
fi


read -p "请输入后台地址 [回车默认10.0.0.1]: " ip
ip=${ip:-"10.0.0.1"}
echo "您的后台地址为: $ip"
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
	sed -i "s/10.0.0.1/$ip/" devices/common/default-settings
	cp -f devices/common/default-settings package/*/*/my-default-settings/files/uci.defaults
fi
if [ -f "devices/$firmware/default-settings" ]; then
	sed -i "s/10.0.0.1/$ip/" devices/$firmware/default-settings
	cat devices/$firmware/default-settings >> package/*/*/my-default-settings/files/uci.defaults
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

编译完成~~~

初始后台地址: $ip
初始用户名密码: root  root

"
fi
