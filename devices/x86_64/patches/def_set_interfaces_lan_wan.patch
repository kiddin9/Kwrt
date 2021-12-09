--- a/target/linux/x86/base-files/etc/board.d/02_network
+++ b/target/linux/x86/base-files/etc/board.d/02_network
@@ -22,6 +22,9 @@ traverse-technologies-geos)
 	macaddr="$(cat /sys/class/net/eth0/address)" 2>/dev/null
 	[ -n "$macaddr" ] && ucidef_set_interface_macaddr "wan" "$macaddr"
 	;;
+*)
+	[ "$(ip address | grep ^[0-9] | awk -F: '{print $2}' | sed "s/ //g" | grep '^[e]' | grep -cvE "(@|\.)")" -gt 2 ] && ucidef_set_interfaces_lan_wan "$(ip address | grep ^[0-9] | awk -F: '{print $2}' | sed "s/ //g" | grep '^[e]' | grep -vE "(@|\.|eth1)" | tr "\n" " " | sed "s/ $//")" "eth1"
+	;;
 esac
 board_config_flush
 
