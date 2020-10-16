#!/bin/sh

opkg() {
    if [[ `echo $@ | grep -o -E '^install'` ]]; then
	command opkg $@
#rm -Rf /lib/upgrade/keep.d/php7*
#sed -i 's/service_start $PROG -y/service_start $PROG -R -y/g' /etc/init.d/php7-fpm
#sed -i "s/user =.*/user = root/g" /etc/php7-fpm.d/www.conf
#/etc/init.d/php7-fpm restart

	[[ ! "`pgrep UnblockNeteaseMusic`" && "`uci get unblockmusic.@unblockmusic[0].enabled`" == 1 ]] && {
	/etc/init.d/unblockmusic restart
	}
	rm -Rf /tmp/luci-modulecache /tmp/luci-indexcache*
    else
        command opkg $@
    fi
    rm -f /var/lock/opkg.lock
}
