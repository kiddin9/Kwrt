--- a/feeds/luci/modules/luci-mod-network/htdocs/luci-static/resources/view/network/wireless.js
+++ b/feeds/luci/modules/luci-mod-network/htdocs/luci-static/resources/view/network/wireless.js
@@ -884,6 +884,10 @@ return view.extend({
 
 					o = ss.taboption('advanced', form.Flag, 'legacy_rates', _('Allow legacy 802.11b rates'));
 					o.default = o.enabled;
+
+					o = ss.taboption("advanced", form.Flag, 'mu_beamformer', _('MU-MIMO'));
+					o.rmempty = false;
+					o.default = '0';
 
 					o = ss.taboption('advanced', form.Value, 'distance', _('Distance Optimization'), _('Distance to farthest network member in meters.'));
 					o.datatype = 'range(0,114750)';
@@ -904,6 +904,9 @@ return view.extend({
 					o.datatype = 'range(15,65535)';
 					o.placeholder = 100;
 					o.rmempty = true;
+
+					o = ss.taboption('advanced', form.Flag, 'vendor_vht', _('Enable 256-QAM'), _('802.11n 2.4Ghz Only'));
+					o.default = o.disabled;
 				}
 
 
@@ -1413,6 +1413,68 @@ return view.extend({
 
 
 				if (hwtype == 'mac80211') {
+					// Probe 802.11k support
+					o = ss.taboption('encryption', form.Flag, 'ieee80211k', _('802.11k'), _('Enables The 802.11k standard provides information to discover the best available access point'));
+					o.depends({ mode : 'ap', encryption : 'wpa' });
+					o.depends({ mode : 'ap', encryption : 'wpa2' });
+					o.depends({ mode : 'ap-wds', encryption : 'wpa' });
+					o.depends({ mode : 'ap-wds', encryption : 'wpa2' });
+					o.depends({ mode : 'ap', encryption : 'psk' });
+					o.depends({ mode : 'ap', encryption : 'psk2' });
+					o.depends({ mode : 'ap', encryption : 'psk-mixed' });
+					o.depends({ mode : 'ap-wds', encryption : 'psk' });
+					o.depends({ mode : 'ap-wds', encryption : 'psk2' });
+					o.depends({ mode : 'ap-wds', encryption : 'psk-mixed' });
+					o.rmempty = true;
+
+					o = ss.taboption('encryption', form.Flag, 'rrm_neighbor_report', _('Enable neighbor report via radio measurements'));
+					o.default = o.enabled;
+					o.depends({ ieee80211k : '1' });
+					o.rmempty = true;
+
+					o = ss.taboption('encryption', form.Flag, 'rrm_beacon_report', _('Enable beacon report via radio measurements'));
+					o.default = o.enabled;
+					o.depends({ ieee80211k : '1' });
+					o.rmempty = true;
+					// End of 802.11k options
+
+					// Probe 802.11v support
+					o = ss.taboption('encryption', form.Flag, 'ieee80211v', _('802.11v'), _('Enables 802.11v allows client devices to exchange information about the network topology,tating overall improvement of the wireless network.'));
+					o.depends({ mode : 'ap', encryption : 'wpa' });
+					o.depends({ mode : 'ap', encryption : 'wpa2' });
+					o.depends({ mode : 'ap-wds', encryption : 'wpa' });
+					o.depends({ mode : 'ap-wds', encryption : 'wpa2' });
+					o.depends({ mode : 'ap', encryption : 'psk' });
+					o.depends({ mode : 'ap', encryption : 'psk2' });
+					o.depends({ mode : 'ap', encryption : 'psk-mixed' });
+					o.depends({ mode : 'ap-wds', encryption : 'psk' });
+					o.depends({ mode : 'ap-wds', encryption : 'psk2' });
+					o.depends({ mode : 'ap-wds', encryption : 'psk-mixed' });
+					o.rmempty = true;
+
+
+					o = ss.taboption('encryption', form.Flag, 'wnm_sleep_mode', _('extended sleep mode for stations'));
+					o.default = o.disabled;
+					o.depends({ ieee80211v : '1' });
+					o.rmempty = true;
+
+					o = ss.taboption('encryption', form.Flag, 'bss_transition', _('BSS Transition Management'));
+					o.default = o.disabled;
+					o.depends({ ieee80211v : '1' });
+					o.rmempty = true;
+
+					o = ss.taboption('encryption', form.ListValue, 'time_advertisement', _('Time advertisement'));
+					o.depends({ ieee80211v : '1' });
+					o.value('0', _('disabled'));
+					o.value('2', _('UTC time at which the TSF timer is 0'));
+					o.rmempty = true;
+
+					o = ss.taboption('encryption', form.Value, 'time_zone', _('time zone'), _('Local time zone as specified in 8.3 of IEEE Std 1003.1-2004'));
+					o.depends({ time_advertisement : '2' });
+					o.placeholder = 'UTC8';
+					o.rmempty = true;
+					// End of 802.11v options
+
 					// Probe 802.11r support (and EAP support as a proxy for Openwrt)
 					var has_80211r = L.hasSystemFeature('hostapd', '11r') || L.hasSystemFeature('hostapd', 'eap');
 
