--- a/package/network/config/wifi-scripts/files/lib/netifd/hostapd.sh
+++ b/package/network/config/wifi-scripts/files/lib/netifd/hostapd.sh
@@ -122,6 +122,7 @@ hostapd_common_add_device_config() {
 	config_add_int maxassoc
 	config_add_int reg_power_type
 	config_add_boolean stationary_ap
+	config_add_boolean vendor_vht
 
 	config_add_string acs_chan_bias
 	config_add_array hostapd_options
@@ -141,7 +142,7 @@ hostapd_prepare_device_config() {
 	json_get_vars country country3 country_ie beacon_int:100 doth require_mode legacy_rates \
 		acs_chan_bias local_pwr_constraint spectrum_mgmt_required airtime_mode cell_density \
 		rts_threshold beacon_rate rssi_reject_assoc_rssi rssi_ignore_probe_request maxassoc \
-		mbssid:0 band reg_power_type stationary_ap
+		mbssid:0 band reg_power_type stationary_ap vendor_vht
 
 	hostapd_set_log_options base_cfg
 
@@ -210,6 +211,7 @@ hostapd_prepare_device_config() {
 				set_default rate_list "24000 36000 48000 54000"
 				set_default basic_rate_list "24000"
 			fi
+			[ -n "$vendor_vht" ] && append base_cfg "vendor_vht=$vendor_vht" "$N"
 		;;
 		a)
 			if [ "$cell_density" -eq 1 ]; then
