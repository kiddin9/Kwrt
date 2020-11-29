'use strict';
'require view';
'require dom';
'require rpc';
'require network';

function render_port_status(node, portstate) {
	if (!node)
		return null;

	if (!portstate || !portstate.link)
		dom.content(node, [
			E('img', { src: L.resource('icons/port_down.png') }),
			E('br'),
			_('no link'),
		]);
	else
		dom.content(node, [
			E('img', { src: L.resource('icons/port_up.png') }),
			E('br'),
			'%d'.format(portstate.speed) + _('baseT'),
			E('br'),
			portstate.duplex ? _('full-duplex') : _('half-duplex'),
		]);

	return node;
}

var callSwconfigFeatures = rpc.declare({
	object: 'luci',
	method: 'getSwconfigFeatures',
	params: [ 'switch' ],
	expect: { '': {} }
});

var callSwconfigPortState = rpc.declare({
	object: 'luci',
	method: 'getSwconfigPortState',
	params: [ 'switch' ],
	expect: { result: [] }
});

return view.extend({
	title: _('Interfaces'),
	load: function() {
		return network.getSwitchTopologies().then(function(topologies) {
			var tasks = [];

			for (var switch_name in topologies) {
				tasks.push(callSwconfigFeatures(switch_name).then(L.bind(function(features) {
					this.features = features;
				}, topologies[switch_name])));
				tasks.push(callSwconfigPortState(switch_name).then(L.bind(function(ports) {
					this.portstate = ports;
				}, topologies[switch_name])));
			}

			return Promise.all(tasks).then(function() { return topologies });
		});
	},

	render: function(topologies) {
			var switch_name     = "switch0",
			    topology        = topologies[switch_name];
				var tables="<table class='table cbi-section-table'>"
				var labels="<tr class='tr cbi-section-table-titles'>"
				var states="<tr class='tr cbi-section-table-titles'>"
				for (var j = 0; Array.isArray(topology.ports) && j < topology.ports.length; j++) {
				var portspec = topology.ports[j],
				    portstate = Array.isArray(topology.portstate) ? topology.portstate[portspec.num] : null;
				var state = render_port_status(E('small', {
					'data-switch': switch_name,
					'data-port': portspec.num
				}), portstate);
				labels = labels + String.format('<th class="th cbi-section-table-cell">%s</th>',portspec.label);
				states = states + String.format('<th class="th cbi-section-table-cell">%s</th>',state.innerHTML);
			
			}
			labels + "</tr>";
			tables = tables + labels + states
			tables + "</table>";
			return tables;

	}
});
