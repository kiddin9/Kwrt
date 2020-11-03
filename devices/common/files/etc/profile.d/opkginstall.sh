#!/bin/sh

opkg() {
	if [[ $(echo $@ | grep -o -E '^install') ]]; then
		command opkg --force-checksum --force-overwrite $@
		#rm -Rf /lib/upgrade/keep.d/php7*
		#sed -i 's/service_start $PROG -y/service_start $PROG -R -y/g' /etc/init.d/php7-fpm
		#sed -i "s/user =.*/user = root/g" /etc/php7-fpm.d/www.conf
		#/etc/init.d/php7-fpm restart

		while :; do
			[[ -f /etc/init.d/unblockmusic && "$(uci get unblockmusic.@unblockmusic[0].enabled)" == 1 && ! "$(pgrep UnblockNeteaseMusic)" ]] && {
				/etc/init.d/unblockmusic restart
			}
			[ "$(pgrep UnblockNeteaseMusic)" ] && {
				break
			}
		done
		rm -Rf /tmp/luci-*
	else
		command opkg --force-checksum --force-overwrite $@
	fi
	rm -f /var/lock/opkg.lock
}
