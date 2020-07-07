'use strict';
'require rpc';

var callEthInfo = rpc.declare({
	object: 'luci',
	method: 'getEthInfo'
});

return L.Class.extend({
	title: _('Interfaces'),

	load: function() {
		return L.resolveDefault(callEthInfo(), {});
	},

	render: function(info) {
		if (info && info.result) {
			var result = "";
			var ports = eval('(' + info.result + ')');
			var tmp = "<div class='table' width='100%' cellspacing='10' style='text-align: center' id='ethinfo'><ul style='list-style: none; margin:0 auto; display: inline-block;'>";
			for (var i in ports) {
				tmp = tmp + String.format(
								'<li style="float: left; margin: 0px 1em;"><span style="line-height:25px">%s</span><br /><small><img draggable="false" src="/luci-static/resources/icons/%s" /><br />%s<br />%s</small></li>',
								ports[i].name,
								ports[i].status ? 'port_up.png' : 'port_down.png',
								ports[i].speed,
								ports[i].duplex ? _('full-duplex') : _('half-duplex'));
			}
			tmp + "</ul></div>";
			result = tmp;
			return result;
		}
	}
});
