--- a/package/feeds/luci/luci-mod-system/htdocs/luci-static/resources/view/system/flash.js
+++ b/package/feeds/luci/luci-mod-system/htdocs/luci-static/resources/view/system/flash.js
@@ -101,7 +101,7 @@ return view.extend({
 		/* Currently the sysupgrade rpc call will not return, hence no promise handling */
 		fs.exec('/sbin/firstboot', [ '-r', '-y' ]);
 
-		ui.awaitReconnect('192.168.1.1', 'openwrt.lan');
+		ui.awaitReconnect('10.0.0.1', 'kwrt.lan');
 	},
 
 	handleRestore: function(ev) {
@@ -163,7 +163,7 @@ return view.extend({
 					E('p', { 'class': 'spinning' }, _('The system is rebooting now. If the restored configuration changed the current LAN IP address, you might need to reconnect manually.'))
 				]);
 
-				ui.awaitReconnect(window.location.host, '192.168.1.1', 'openwrt.lan');
+				ui.awaitReconnect(window.location.host, '10.0.0.1', 'kwrt.lan');
 			}, this))
 			.catch(function(e) { ui.addNotification(null, E('p', e.message)) })
 			.finally(function() { btn.firstChild.data = _('Upload archive...') });
@@ -263,6 +263,7 @@ return view.extend({
 					body.push(E('p', {}, E('label', { 'class': 'btn' }, [
 						opts.backup_pkgs[0], ' ', _('Include in backup a list of current installed packages at /etc/backup/installed_packages.txt')
 					])));
+					opts.backup_pkgs[0].checked = true;
 				};
 
 				var cntbtn = E('button', {
@@ -304,6 +305,10 @@ return view.extend({
 				opts.keep[0].addEventListener('change', function(ev) {
 					opts.skip_orig[0].disabled = !ev.target.checked;
 					opts.backup_pkgs[0].disabled = !ev.target.checked;
+					if (ev.target.checked == false){
+						opts.skip_orig[0].checked =false
+						opts.backup_pkgs[0].checked =false
+					}
 
 				});
 
@@ -337,7 +342,7 @@ return view.extend({
 		if (opts['keep'][0].checked)
 			ui.awaitReconnect(window.location.host);
 		else
-			ui.awaitReconnect('192.168.1.1', 'openwrt.lan');
+			ui.awaitReconnect('10.0.0.1', 'kwrt.lan');
 	},
 
 	handleBackupList: function(ev) {
