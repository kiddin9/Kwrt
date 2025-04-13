--- a/package/feeds/luci/luci-mod-network/htdocs/luci-static/resources/view/network/wireless.js
+++ b/package/feeds/luci/luci-mod-network/htdocs/luci-static/resources/view/network/wireless.js
@@ -1026,6 +1026,12 @@ return view.extend({
 					o.placeholder = 100;
 					o.rmempty = true;
 
+					o = ss.taboption("advanced", form.Flag, 'mu_beamformer', _('MU-MIMO'));
+					o.default = '1';
+
+					o = ss.taboption('advanced', form.Flag, 'vendor_vht', _('Enable 256-QAM'), _('802.11n 2.4Ghz Only'));
+					o.default = o.disabled;
+
 					o = ss.taboption('advanced', form.Flag, 'rxldpc', _('Rx LDPC'), _('Low-Density Parity-Check'));
 					o.default = '1';
 
