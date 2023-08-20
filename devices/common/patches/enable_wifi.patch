--- a/package/kernel/mac80211/files/lib/wifi/mac80211.sh
+++ b/package/kernel/mac80211/files/lib/wifi/mac80211.sh
@@ -203,7 +203,6 @@ detect_mac80211() {
 			set wireless.${name}.channel=${channel}
 			set wireless.${name}.band=${mode_band}
 			set wireless.${name}.htmode=$htmode
-			set wireless.${name}.disabled=1
 
 			set wireless.default_${name}=wifi-iface
 			set wireless.default_${name}.device=${name}
@@ -213,5 +212,6 @@ detect_mac80211() {
 			set wireless.default_${name}.encryption=none
 EOF
 		uci -q commit wireless
+  		wifi reload
 	done
 }