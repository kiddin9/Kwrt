--- a/package/feeds/luci/luci-mod-status/htdocs/luci-static/resources/view/status/include/20_memory.js
+++ b/package/feeds/luci/luci-mod-status/htdocs/luci-static/resources/view/status/include/20_memory.js
@@ -32,8 +32,7 @@ return baseclass.extend({
 		    swap = L.isObject(systeminfo.swap) ? systeminfo.swap : {};
 
 		var fields = [
-			_('Total Available'), (mem.available) ? mem.available : (mem.total && mem.free && mem.buffered) ? mem.free + mem.buffered : null, mem.total,
-			_('Used'),            (mem.total && mem.free) ? (mem.total - mem.free) : null, mem.total,
+			_('Used'),            (mem.total && mem.available) ? (mem.total - mem.free - mem.buffered - mem.cached) : null, mem.total,
 		];
 
 		if (mem.buffered)
@@ -43,9 +42,9 @@ return baseclass.extend({
 			fields.push(_('Cached'), mem.cached, mem.total);
 
 		if (swap.total > 0)
-			fields.push(_('Swap free'), swap.free, swap.total);
+			fields.push(_('Swap used'), swap.total - swap.free, swap.total);
 
-		var table = E('table', { 'class': 'table' });
+		var table = E('table', { 'class': 'table memory' });
 
 		for (var i = 0; i < fields.length; i += 3) {
 			table.appendChild(E('tr', { 'class': 'tr' }, [

--- a/package/feeds/luci/luci-mod-status/root/usr/share/rpcd/acl.d/luci-mod-status.json
+++ b/package/feeds/luci/luci-mod-status/root/usr/share/rpcd/acl.d/luci-mod-status.json
@@ -3,7 +3,7 @@
 		"description": "Grant access to realtime statistics",
 		"read": {
 			"ubus": {
-				"luci": [ "getConntrackList", "getRealtimeStats" ],
+				"luci": [ "getConntrackList", "getRealtimeStats", "getCPUBench", "getCPUUsage", "getOnlineUsers" ],
 				"network.rrdns": [ "lookup" ]
 			}
 		}

--- a/package/feeds/luci/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
+++ b/package/feeds/luci/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
@@ -18,6 +18,21 @@ var callSystemInfo = rpc.declare({
 	method: 'info'
 });
 
+var callCPUBench = rpc.declare({
+	object: 'luci',
+	method: 'getCPUBench'
+});
+
+var callCPUInfo = rpc.declare({
+	object: 'luci',
+	method: 'getCPUInfo'
+});
+
+var callTempInfo = rpc.declare({
+	object: 'luci',
+	method: 'getTempInfo'
+});
+
 return baseclass.extend({
 	title: _('System'),
 
@@ -25,6 +45,9 @@ return baseclass.extend({
 		return Promise.all([
 			L.resolveDefault(callSystemBoard(), {}),
 			L.resolveDefault(callSystemInfo(), {}),
+			L.resolveDefault(callCPUBench(), {}),
+			L.resolveDefault(callCPUInfo(), {}),
+			L.resolveDefault(callTempInfo(), {}),
 			L.resolveDefault(callLuciVersion(), { revision: _('unknown version'), branch: 'LuCI' })
 		]);
 	},
@@ -32,7 +56,10 @@ return baseclass.extend({
 	render: function(data) {
 		var boardinfo   = data[0],
 		    systeminfo  = data[1],
-		    luciversion = data[2];
+		    cpubench    = data[2],
+		    cpuinfo     = data[3],
+		    tempinfo    = data[4],
+		    luciversion = data[5];
 
 		luciversion = luciversion.branch + ' ' + luciversion.revision;
 
@@ -53,8 +81,6 @@ return baseclass.extend({
 
 		var fields = [
 			_('Hostname'),         boardinfo.hostname,
-			_('Model'),            boardinfo.model,
-			_('Architecture'),     boardinfo.system,
 			_('Target Platform'),  (L.isObject(boardinfo.release) ? boardinfo.release.target : ''),
 			_('Firmware Version'), (L.isObject(boardinfo.release) ? boardinfo.release.description + ' / ' : '') + (luciversion || ''),
 			_('Kernel Version'),   boardinfo.kernel,
@@ -67,6 +93,24 @@ return baseclass.extend({
 			) : null
 		];
 
+		if (tempinfo.tempinfo) {
+			fields.splice(6, 0, _('Temperature'));
+			fields.splice(7, 0, tempinfo.tempinfo);
+		}
+		if (boardinfo.model == "Default string Default string") {
+			if (cpuinfo.cpuinfo) {
+			fields.splice(2, 0, _('Architecture'));
+			fields.splice(3, 0, cpuinfo.cpuinfo + cpubench.cpubench);
+			}
+		} else {
+			fields.splice(2, 0, _('Model'));
+			fields.splice(3, 0, boardinfo.model + cpubench.cpubench);
+			if (cpuinfo.cpuinfo) {
+			fields.splice(4, 0, _('Architecture'));
+			fields.splice(5, 0, cpuinfo.cpuinfo);
+			}
+		}
+
 		var table = E('table', { 'class': 'table' });
 
 		for (var i = 0; i < fields.length; i += 2) {

--- a/package/feeds/luci/luci-mod-status/htdocs/luci-static/resources/view/status/nftables.js
+++ b/package/feeds/luci/luci-mod-status/htdocs/luci-static/resources/view/status/nftables.js
@@ -675,7 +675,6 @@ return view.extend({
 	checkLegacyRules: function(ipt4save, ipt6save) {
 		if (ipt4save.match(/\n-A /) || ipt6save.match(/\n-A /)) {
 			ui.addNotification(_('Legacy rules detected'), [
-				E('p', _('There are legacy iptables rules present on the system. Mixing iptables and nftables rules is discouraged and may lead to incomplete traffic filtering.')),
 				E('button', {
 					'class': 'btn cbi-button',
 					'click': function() { location.href = 'nftables/iptables' }

--- a/package/feeds/luci/luci-mod-status/htdocs/luci-static/resources/view/status/include/29_ports.js
+++ b/package/feeds/luci/luci-mod-status/htdocs/luci-static/resources/view/status/include/29_ports.js
@@ -309,8 +309,6 @@ return baseclass.extend({
 	},
 
 	render: function(data) {
-		if (L.hasSystemFeature('swconfig'))
-			return null;
 
 		var board = JSON.parse(data[1]),
 		    known_ports = [],
