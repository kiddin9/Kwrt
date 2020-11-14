#/bin/bash
echo
echo
echo "本脚本仅适用于在Ubuntu环境下编译 https://github.com/garypang13/Actions-OpenWrt"
echo
echo
sleep 2s
sudo apt-get update
sudo apt-get upgrade

sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler ccache xsltproc rename antlr3 gperf curl screen



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





rm -Rf openwrt Actions-OpenWrt
git clone -b master --depth 1 https://github.com/openwrt/openwrt
git clone https://github.com/garypang13/Actions-OpenWrt
cp -Rf Actions-OpenWrt/* openwrt/
cd openwrt
echo "

1. X86_64

2. K2p

3. RedMi_AC2100

4. r2s

5. newifi-d2

6. hiwifi-hc5962

7. XY-C5

8. phicomm-N1

9. Exit

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
		firmware="newifi-d2"
	break
	;;
	6)
		firmware="hiwifi-hc5962"
	break
	;;
	7)
		firmware="XY-C5"
	break
	;;
	8)
		firmware="phicomm-N1"
		make menuconfig
	break
	;;
	9)	exit 0
	;;

esac
done


read -p "请输入后台地址 [回车默认10.0.0.1]: " ip
ip=${ip:-"10.0.0.1"}
echo "您的后台地址为: $ip"


if [ -f "devices/common/feeds.conf" ]; then
          mv devices/common/feeds.conf ./
fi       
if [ -f "devices/$firmware/feeds.conf" ]; then
          mv devices/$firmware/feeds.conf ./
fi
if [ -n "$(ls -A "devices/common/files" 2>/dev/null)" ]; then
	cp -rf devices/common/files files
fi
if [ -n "$(ls -A "devices/$firmware/files" 2>/dev/null)" ]; then
	cp -rf devices/$firmware/files/* files/
fi
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
if [ -n "$(ls -A "devices/common/diy" 2>/dev/null)" ]; then
	cp -Rf devices/common/diy/* ./
fi
if [ -n "$(ls -A "devices/$firmware/diy" 2>/dev/null)" ]; then
	cp -Rf devices/$firmware/diy/* ./
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
sleep 5s

make -j$(($(nproc)+1)) download v=s ; make -j$(($(nproc)+1)) || make -j1 V=s

echo "

编译完成~~~

初始后台地址: $ip
初始用户名密码: root  root

"