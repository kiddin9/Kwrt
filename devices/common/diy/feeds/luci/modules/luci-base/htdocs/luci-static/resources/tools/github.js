'use strict';

return L.Class.extend({
    desc: function(description, username, project) {
        var luci_project = 'luci-app-' + project;
        var title = _('if you have any problem, please click to view the project on GitHub : ') + project;
        var luci_title = _('if you have any problem, please click to view the luci ui project on GitHub : ') + luci_project;
        var package_label = 'package-' + project.replace(/-/g, '_') + '-default';
        var luci_label = 'luci-' + project.replace(/-/g, '_') + '-default';

        return "<table style='border: 0; table-layout: auto;'>" +
                    "<tr>" +
                        "<td style='border: 0;'>" + _(description) + "</td>" +
                        "<td style='border: 0;'>" +
                            "<table style='border: 0; table-layout: auto;'>" +
                                "<tr>" +
                                    "<td style='border: 0;'>" +
                                        "<a href='https://github.com/" + username + "/" + project + "' target='_blank' title='" + title + "'>" +
                                            "<img alt='" + project + "' src='https://img.shields.io/badge/" + package_label +  "' />" +
                                            "<img alt='" + project + "' src='https://img.shields.io/github/stars/" + username + "/" + project + "?style=social' />" +
                                        "</a>" +
                                        "<a href='https://github.com/" + username + "/" + luci_project + "' target='_blank' title='" + luci_title + "'>" +
                                            "<img alt='" + luci_project + "' src='https://img.shields.io/badge/" + luci_label + "' />" +
                                            "<img alt='" + luci_project + "' src='https://img.shields.io/github/stars/" + username + "/" + luci_project + "?style=social' />" +
                                        "</a>" +
                                    "</td>" +
                                "</tr>" +
                            "</table>" +
                        "</td>" +
                    "</tr>" +
                "</table>";
    },

    luci_desc: function(description, username, project) {
        var luci_label = 'luci-' + project.replace(/-/g, '_') + '-default';
        project = 'luci-app-' + project;
        var luci_title = _('if you have any problem, please click to view the luci ui project on GitHub : ') + project;
        
        return "<table style='border: 0; table-layout: auto;'>" +
                    "<tr>" +
                        "<td style='border: 0;'>" + _(description) + "</td>" +
                        "<td style='border: 0;'>" +
                            "<a href='https://github.com/" + username + "/" + project + "' target='_blank' title='" + luci_title + "'>" +
                                "<img alt='" + project + "' src='https://img.shields.io/badge/" + luci_label + "' />" +
                                "<img alt='" + project + "' src='https://img.shields.io/github/stars/" + username + "/" + project + "?style=social' />" +
                            "</a>" +
                        "</td>" +
                    "</tr>" +
                "</table>";
    }
});