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

rm -Rf Actions-OpenWrt openwrt/common openwrt/files openwrt/devices && git clone https://github.com/garypang13/Actions-OpenWrt
cp -Rf Actions-OpenWrt/* openwrt/
cd openwrt

[ $(grep '^CONFIG_TARGET.*DEVICE.*=y' .config | sed -r 's/.*DEVICE_(.*)=y/\1/') == generic ] && {
 firmware=$(grep '^CONFIG_TARGET.*DEVICE.*=y' .config | sed -r 's/CONFIG_TARGET_(.*)_DEVICE_.*=y/\1/')
 } || { firmware=$(grep '^CONFIG_TARGET.*DEVICE.*=y' .config | sed -r 's/.*DEVICE_(.*)=y/\1/')
 }

if [ $firmware == "xiaomi_redmi-router-ac2100" ]; then
	firmware="redmi-ac2100"
elif [ $firmware == "phicomm_k2p" ]; then
	firmware="phicomm-k2p"
elif [ $firmware == "x86_64" ]; then
	firmware="x86_64"
elif [ $firmware == "friendlyarm_nanopi-r2s" ]; then
	firmware="nanopi-r2s"
elif [ $firmware == "xiaoyu_xy-c5" ]; then
	firmware="XY-C5"
elif [ $firmware == "hiwifi_hc5962" ]; then
	firmware="hiwifi-hc5962"
elif [ $firmware == "d-team_newifi-d2" ]; then
	firmware="newifi-d2"
else
	echo "无法识别固件类型,请退出"
fi
echo

read -p "请输入后台地址 [回车默认10.0.0.1]: " ip
ip=${ip:-"10.0.0.1"}
echo "您的后台地址为: $ip"

rm -Rf feeds package/feeds tmp
make clean
[ -f ".config" ] && mv .config .config.bak
git fetch --all
git reset --hard origin/master
if [ -n "$(ls -A "devices/common/files" 2>/dev/null)" ]; then
	cp -rf devices/common/files/ files
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
if [ -n "$(ls -A "devices/common/diy" 2>/dev/null)" ]; then
	cp -Rf devices/common/diy/* ./
fi
if [ -n "$(ls -A "devices/$firmware/diy" 2>/dev/null)" ]; then
	cp -Rf devices/$firmware/diy/* ./
fi
if [ -f "devices/common/default-settings" ]; then
	sed -i 's/10.0.0.1/$ip/' devices/common/default-settings
	cp -f devices/common/default-settings package/*/*/default-settings/root/etc/uci-defaults/99-default-settings
fi
if [ -f "devices/$firmware/default-settings" ]; then
	sed -i 's/10.0.0.1/$ip/' devices/$firmware/default-settings
	cat devices/$firmware/default-settings >> package/*/*/default-settings/root/etc/uci-defaults/99-default-settings
fi
if [ -n "$(ls -A "devices/common/patches" 2>/dev/null)" ]; then
          find "devices/common/patches" -type f -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 --forward"
fi
if [ -n "$(ls -A "devices/$firmware/patches" 2>/dev/null)" ]; then
          find "devices/$firmware/patches" -type f -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 --forward"
fi
[ -f ".config.bak" ] && mv .config.bak .config || {
cp devices/common/.config .config
echo >> .config
cat devices/$firmware/.config >> .config
}

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
