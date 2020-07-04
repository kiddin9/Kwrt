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

if [ -f /etc/config/jia ]; then
  sed -i '/=\/tmp\/dnsmasq.ssr/d' /etc/init.d/shadowsocksr
fi
if [ ! -f /usr/bin/ssr-server ]; then
  sed -i '/server-config/d' /usr/lib/lua/luci/controller/shadowsocksr.lua
fi
    [ ! -f /etc/confbak/shadowsocksr ] && {
    [ -f /etc/config/AdGuardHome ] && {
      uci set shadowsocksr.@global[0].pdnsd_enable='0'
      uci del shadowsocksr.@global[0].tunnel_forward
  }
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='1.1.1.1'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='208.67.222.222'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='8.8.8.8'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='8.8.4.4'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='9.9.9.9'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='218.102.23.228'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='210.0.255.250'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='168.95.1.1'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='202.175.82.46'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='77.88.8.8'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='101.101.101.101'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='203.198.7.66'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='202.56.128.30'
  uci add_list shadowsocksr.@access_control[0].wan_fw_ips='149.112.112.112'
  uci commit shadowsocksr
}

sleep 2
	[[ ! `pgrep UnblockNeteaseMusic` && `uci get unblockmusic.@unblockmusic[0].enabled` == 1 ]] && {
	/etc/init.d/unblockmusic restart
	}
	[[ ! `pgrep rclone` && `uci get rclone.global.enabled` == 1 ]] && {
	/etc/init.d/rclone restart
	}
	[[ ! `pgrep ssr-redir` && `uci get shadowsocksr.@global[0].global_server` != 'nil' ]] && {
	/etc/init.d/shadowsocksr restart
	}
	rm -Rf /tmp/luci-modulecache /tmp/luci-indexcache
    else
        command opkg $@
    fi
}
