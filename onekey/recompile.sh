#/bin/bash
echo
echo
echo "本脚本仅适用于在Ubuntu环境下编译https://github.com/garypang13/Actions-OpenWrt"
echo
echo

if [ "$USER" = "root" ]; then
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
rm -Rf feeds package/feeds files tmp
[ -f ".config" ] && mv .config .config.bak
git fetch --all
git reset --hard origin/master
./scripts/feeds update -a
if [ -n "$(ls -A "common/files" 2>/dev/null)" ]; then
	cp -rf common/files/ files
fi
if [ -n "$(ls -A "x86_64/files" 2>/dev/null)" ]; then
	cp -rf x86_64/files/* files/
fi
if [ -f "common/diy.sh" ]; then
	(
		chmod +x common/diy.sh
		/bin/bash "common/diy.sh"
	)
fi
if [ -f "x86_64/diy.sh" ]; then
	(
		chmod +x x86_64/diy.sh
		/bin/bash "x86_64/diy.sh"
	)
fi
if [ -n "$(ls -A "common/diy" 2>/dev/null)" ]; then
	cp -Rf common/diy/* ./
fi
if [ -n "$(ls -A "x86_64/diy" 2>/dev/null)" ]; then
	cp -Rf x86_64/diy/* ./
fi
if [ -f "common/default-settings" ]; then
	cp -f common/default-settings package/*/*/default-settings/files/zzz-default-settings
fi
if [ -f "x86_64/default-settings" ]; then
	cp -f x86_64/default-settings package/*/*/default-settings/files/zzz-default-settings
fi
if [ -n "$(ls -A "common/patches" 2>/dev/null)" ]; then
          find "common/patches" -type f -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p0 --forward"
fi
if [ -n "$(ls -A "x86_64/patches" 2>/dev/null)" ]; then
          find "x86_64/patches" -type f -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p0 --forward"
fi
[ -f ".config.bak" ] && mv .config.bak .config || mv x86_64/.config .config

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
echo "                      *****6秒后开始编译*****

1.你可以随时按Ctrl+C停止编译

3.大陆用户编译前请准备好梯子,使用大陆白名单或全局模式"
echo
echo
echo
sleep 6s

make -j$(($(nproc)+1)) download v=s ; make -j$(($(nproc)+1)) || make -j1 V=s

echo "

编译完成~~~

后台地址: 10.0.0.1
默认用户名密码: root  root

"