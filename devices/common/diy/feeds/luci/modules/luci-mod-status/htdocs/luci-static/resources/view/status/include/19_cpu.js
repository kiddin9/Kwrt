'use strict';
'require rpc';

var callCPUFreeInfo = rpc.declare({
	object: 'luci',
	method: 'getCPUInfo'
});

function progressbar(value, max) {
	var vn = parseInt(value) || 0,
	    mn = parseInt(max) || 100,
	    pc = Math.floor((100 / mn) * vn);

	return E('div', {
		'class': 'cbi-progressbar',
		'title': '%s%% / %s%%'.format(vn, mn, pc)
	}, E('div', { 'style': 'width:%.2f%%'.format(pc) }));
}

return L.Class.extend({
	title: _('CPU'),

	load: function() {
		return L.resolveDefault(callCPUFreeInfo(), {});
	},

	render: function(info) {
		var fields = [
			_('Used'), (info.cpufree) ? info.cpufree : 0, 100
		];

		var table = E('div', { 'class': 'table cpu' });

		for (var i = 0; i < fields.length; i += 3) {
			table.appendChild(E('div', { 'class': 'tr' }, [
				E('div', { 'class': 'td left', 'width': '33%' }, [ fields[i] ]),
				E('div', { 'class': 'td left' }, [
					(fields[i + 1] != null) ? progressbar(fields[i + 1], fields[i + 2], true) : '?'
				])
			]));
		}

		return table;
	}
});
