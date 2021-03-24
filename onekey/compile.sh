#/bin/bash
echo
echo
echo "本脚本仅适用于在Ubuntu环境下编译 https://github.com/garypang13/Actions-OpenWrt"
echo
echo
sleep 2s
sudo apt-get update
sudo apt-get upgrade

sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler ccache xsltproc rename antlr3 gperf curl screen upx



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
git clone -b openwrt-21.02 --depth 1 https://github.com/openwrt/openwrt
svn co https://github.com/garypang13/Actions-OpenWrt/trunk/devices openwrt/devices
cd openwrt

echo "

1. X86_64

2. K2p

3. RedMi_AC2100

4. r2s

5. r4s

6. newifi-d2

7. XY-C5

8. Exit

"

while :; do

read -p "你想要编译哪个固件？ " CHOOSE

case $CHOOSE in
	1)
		firmware="x86_64"
	break
	;;
	2)
		firmware="phicomm-k2p"
	break
	;;
	3)
		firmware="redmi-ac2100"
	break
	;;
	4)
		firmware="nanopi-r2s"
	break
	;;
	5)
		firmware="nanopi-r4s"
	break
	;;
	6)
		firmware="newifi-d2"
	break
	;;
	7)
		firmware="XY-C5"
	break
	;;
	8)	exit 0
	;;

esac
done

if [[ $firmware =~ (redmi-ac2100|phicomm-k2p|newifi-d2|k2p-32m-usb|XY-C5|xiaomi-r3p) ]]; then
		wget -cO sdk1.tar.xz https://mirrors.cloud.tencent.com/openwrt/releases/21.02-SNAPSHOT/targets/ramips/mt7621/openwrt-sdk-21.02-SNAPSHOT-ramips-mt7621_gcc-8.4.0_musl.Linux-x86_64.tar.xz
elif [[ $firmware =~ (nanopi-r2s|nanopi-r4s) ]]; then
		wget -cO sdk1.tar.xz https://mirrors.cloud.tencent.com/openwrt/releases/21.02-SNAPSHOT/targets/rockchip/armv8/openwrt-sdk-21.02-SNAPSHOT-rockchip-armv8_gcc-8.4.0_musl.Linux-x86_64.tar.xz
elif [[ $firmware == "x86_64" ]]; then
		wget -cO sdk1.tar.xz https://mirrors.cloud.tencent.com/openwrt/releases/21.02-SNAPSHOT/targets/x86/64/openwrt-sdk-21.02-SNAPSHOT-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz
fi


read -p "请输入后台地址 [回车默认10.0.0.1]: " ip
ip=${ip:-"10.0.0.1"}
echo "您的后台地址为: $ip"
cp -rf devices/common/* ./
cp -rf devices/$firmware/* ./
./scripts/feeds update -a
cp -Rf ./diy/* ./
if [ -f "devices/common/diy.sh" ]; then
		chmod +x devices/common/diy.sh
		/bin/bash "devices/common/diy.sh"
fi
if [ -f "devices/$firmware/diy.sh" ]; then
		chmod +x devices/$firmware/diy.sh
		/bin/bash "devices/$firmware/diy.sh"
fi
if [ -f "devices/common/default-settings" ]; then
	sed -i 's/10.0.0.1/$ip/' devices/common/default-settings
	cp -f devices/common/default-settings package/*/*/default-settings/root/etc/uci-defaults/99-default-settings
fi
if [ -f "devices/$firmware/default-settings" ]; then
	sed -i 's/10.0.0.1/$ip/' devices/$firmware/default-settings
	cat -f devices/$firmware/default-settings >> package/*/*/default-settings/root/etc/uci-defaults/99-default-settings
fi
if [ -n "$(ls -A "devices/common/patches" 2>/dev/null)" ]; then
          find "devices/common/patches" -type f -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 --forward"
fi
if [ -n "$(ls -A "devices/$firmware/patches" 2>/dev/null)" ]; then
          find "devices/$firmware/patches" -type f -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 --forward"
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

if [ -f sdk1.tar.xz ]; then
	mkdir sdk
	tar -xJf sdk1.tar.xz -C sdk
	mv -f sdk/*/build_dir ./build_dir
	cp -rf sdk/*/staging_dir/* ./staging_dir/
	rm -rf sdk sdk1.tar.xz
	ln -sf /usr/bin/python staging_dir/host/bin/python
	ln -sf /usr/bin/python3 staging_dir/host/bin/python3
	sed -i '/\(tools\|toolchain\)\/Makefile/d' Makefile
	sed -i 's,$(STAGING_DIR_HOST)/bin/upx,upx,' package/feeds/custom/*/Makefile
fi

make -j$(($(nproc)+1)) download v=s ; make -j$(($(nproc)+1)) || make -j1 V=s

if [ "$?" == "0" ]; then
echo "

编译完成~~~

初始后台地址: $ip
初始用户名密码: root  root

"
fi