#!/bin/sh

opkg() {
    if [[ `echo $@ | grep -o -E '^install'` ]]; then
	command opkg $@
rm -Rf /lib/upgrade/keep.d/php7*
sed -i 's/service_start $PROG -y/service_start $PROG -R -y/g' /etc/init.d/php7-fpm
sed -i "s/user =.*/user = root/g" /etc/php7-fpm.d/www.conf
/etc/init.d/php7-fpm restart
ln -sf /usr/bin/python3 /usr/bin/python
sed -i 's/extra_setting\"/extra_settings\"/g' /usr/lib/lua/luci/model/cbi/aria2/config.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/aria2.lua
sed -i 's/entry({"admin", "nas", "aria2"}/entry({"admin", "nas"}, firstchild(), _("NAS"), 45).dependent = false\nentry({"admin", "nas", "aria2"}/g' /usr/lib/lua/luci/controller/aria2.lua
sed -i 's/services/nas/g' /usr/lib/lua/luci/view/aria2/*.htm
sed -i 's/ariang/ariang-nginx/g' /usr/lib/lua/luci/view/aria2/settings_header.htm
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/hd_idle.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/samba4.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/ksmbd.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/minidlna.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/transmission.lua
sed -i 's/local page = entry/entry({"admin", "nas"}, firstchild(), _("NAS"), 45).dependent = false\nlocal page = entry/g' /usr/lib/lua/luci/controller/transmission.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/mjpg-streamer.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/xunlei.lua
sed -i 's/services/nas/g'  /usr/lib/lua/luci/view/minidlna_status.htm

if [ -f /etc/config/smartdns ]; then
rm -Rf /etc/smartdns/anti-ad-smartdns.conf
wget -P /etc/smartdns/anti-ad-smartdns.conf https://github.com/privacy-protection-tools/anti-AD/raw/master/anti-ad-smartdns.conf
fi

sleep 2
	[[ ! `pgrep UnblockNeteaseMusic` && `uci get unblockmusic.@unblockmusic[0].enabled` == 1 ]] && {
	/etc/init.d/unblockmusic restart
	}
	[[ ! `pgrep rclone` && `uci get rclone.global.enabled` == 1 ]] && {
	/etc/init.d/rclone restart
	}
	rm -Rf /tmp/luci-modulecache /tmp/luci-indexcache
    else
        command opkg $@
    fi
}
