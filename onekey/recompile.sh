#/bin/bash
echo
echo
echo "本脚本仅适用于在Ubuntu环境下编译 https://github.com/garypang13/Actions-OpenWrt"
echo
echo

if [ "$USER" == "root" ]; then
	echo
	echo
	echo "请勿使用root用户编译，换一个普通用户吧~~"
	sleep 3s
	exit 0
fi

echo
echo

clear

#rm -Rf Actions-OpenWrt && git clone https://github.com/garypang13/Actions-OpenWrt
#cp -Rf Actions-OpenWrt/* openwrt/
cd openwrt

[ $(grep '^CONFIG_TARGET.*DEVICE.*=y' .config | sed -r 's/.*DEVICE_(.*)=y/\1/') == generic ] && {
 firmware=$(grep '^CONFIG_TARGET.*DEVICE.*=y' .config | sed -r 's/CONFIG_TARGET_(.*)_DEVICE_.*=y/\1/')
 } || { firmware=$(grep '^CONFIG_TARGET.*DEVICE.*=y' .config | sed -r 's/.*DEVICE_(.*)=y/\1/')
 }

if [ $firmware == "xiaomi_redmi-router-ac2100" ]; then
        (
          firmware="redmi_ac2100"
        )
elif [ $firmware == "phicomm_k2p" ]; then
        (
          firmware="k2p"
        )
elif [ $firmware == "x86_64" ]; then
        (
	firmware="x86_64"
        )
else
		firmware="other"
		make menuconfig
fi
echo

read -p "请输入后台地址 [回车默认10.0.0.1]: " ip
ip=${ip:-"10.0.0.1"}
echo "您的后台地址为: $ip"

rm -Rf feeds package/feeds files tmp
[ -f ".config" ] && mv .config .config.bak
git fetch --all
git reset --hard origin/master
if [ -n "$(ls -A "common/files" 2>/dev/null)" ]; then
	cp -rf common/files/ files
fi
if [ -n "$(ls -A "$firmware/files" 2>/dev/null)" ]; then
	cp -rf $firmware/files/* files/
fi
if [ -f "common/diy.sh" ]; then
	(
		chmod +x common/diy.sh
		/bin/bash "common/diy.sh"
	)
fi
if [ -f "$firmware/diy.sh" ]; then
	(
		chmod +x $firmware/diy.sh
		/bin/bash "$firmware/diy.sh"
	)
fi
if [ -n "$(ls -A "common/diy" 2>/dev/null)" ]; then
	cp -Rf common/diy/* ./
fi
if [ -n "$(ls -A "$firmware/diy" 2>/dev/null)" ]; then
	cp -Rf $firmware/diy/* ./
fi
if [ -f "common/default-settings" ]; then
	sed -i 's/10.0.0.1/$ip/' common/default-settings
	cp -f common/default-settings package/*/*/default-settings/files/zzz-default-settings
fi
if [ -f "$firmware/default-settings" ]; then
	sed -i 's/10.0.0.1/$ip/' $firmware/default-settings
	cat $firmware/default-settings >> package/*/*/default-settings/files/zzz-default-settings
fi
if [ -n "$(ls -A "common/patches" 2>/dev/null)" ]; then
          find "common/patches" -type f -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p0 --forward"
fi
if [ -n "$(ls -A "$firmware/patches" 2>/dev/null)" ]; then
          find "$firmware/patches" -type f -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p0 --forward"
fi
[ -f ".config.bak" ] && mv .config.bak .config || mv $firmware/.config .config

[ firmware == "other" ] || {
while true; do
read -p "是否增删插件? [y/N]: " YN
case ${YN:-N} in
	[Yy])
		make menuconfig
	echo ""
	;;
	[Nn]) 
	make defconfig
		break
	;;
esac
done
}
echo
echo
echo "                      *****5秒后开始编译*****

1.你可以随时按Ctrl+C停止编译

3.大陆用户编译前请准备好梯子,使用大陆白名单或全局模式"
echo
echo
sleep 5s

make -j$(($(nproc)+1)) download v=s ; make -j$(($(nproc)+1)) || make -j1 V=s

echo "

编译完成~~~

初始后台地址: $ip
初始用户名密码: root  root

"