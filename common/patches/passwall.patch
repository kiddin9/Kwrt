--- a/package/feeds/custom/luci-app-passwall/luasrc/controller/passwall.lua
+++ b/package/feeds/custom/luci-app-passwall/luasrc/controller/passwall.lua
@@ -35,9 +35,11 @@ function index()
 	entry({"admin", "services", appname, "acl"}, cbi(appname .. "/client/acl"), _("Access control"), 98).leaf = true
 	entry({"admin", "services", appname, "log"}, form(appname .. "/client/log"), _("Watch Logs"), 999).leaf = true
 
+	if nixio.fs.access("/usr/bin/ssr-server") then
 	--[[ Server ]]
 	entry({"admin", "services", appname, "server"}, cbi(appname .. "/server/index"), _("Server-Side"), 99).leaf = true
 	entry({"admin", "services", appname, "server_user"}, cbi(appname .. "/server/user")).leaf = true
+	end
 
 	--[[ API ]]
 	entry({"admin", "services", appname, "server_user_status"}, call("server_user_status")).leaf = true

--- a/package/feeds/custom/luci-app-passwall/root/usr/share/passwall/test.sh
+++ b/package/feeds/custom/luci-app-passwall/root/usr/share/passwall/test.sh
@@ -67,17 +67,12 @@ test_auto_switch() {
 	fi
 
 	status=$(test_proxy)
-	if [ "$status" == 0 ]; then
-		echolog "自动切换检测：${type}_${index}节点正常。"
-		return 0
-	elif [ "$status" == 2 ]; then
+	if [ "$status" == 2 ]; then
 		echolog "自动切换检测：无法连接到网络，请检查网络是否正常！"
 		return 2
-	elif [ "$status" == 1 ]; then
-		echolog "自动切换检测：${type}_${index}节点异常，开始切换节点！"
-		
+	else
 		#检测主节点是否能使用
-		local main_node=$(config_t_get auto_switch tcp_main1)
+		local main_node=$(config_t_get global tcp_node1)
 		if [ "$now_node" != "$main_node" ]; then
 			local node_type=$(echo $(config_n_get $main_node type) | tr 'A-Z' 'a-z')
 			if [ "$node_type" == "socks" ]; then
@@ -98,6 +93,10 @@ test_auto_switch() {
 				return 0
 			fi
 		fi
+		if [ "$status" == 0 ]; then
+			echolog "自动切换检测：${type}_${index}节点正常。"
+			return 0
+		fi
 		
 		local new_node
 		in_backup_nodes=$(echo $b_tcp_nodes | grep $now_node)

--- a/package/feeds/custom/luci-app-passwall/luasrc/model/cbi/passwall/client/auto_switch.lua
+++ b/package/feeds/custom/luci-app-passwall/luasrc/model/cbi/passwall/client/auto_switch.lua
@@ -37,11 +37,6 @@ o.default = "3"
 -- 暂时只支持TCP1
 local tcp_node_num = 1
 for i = 1, tcp_node_num, 1 do
-    o = s:option(ListValue, "tcp_main" .. i, "TCP " .. i .. " " .. translate("Main node"))
-    for k, v in pairs(nodes_table) do
-        o:value(v.id, v.remarks)
-    end
-    
     o = s:option(DynamicList, "tcp_node" .. i, "TCP " .. i .. " " .. translate("List of backup nodes"))
     for k, v in pairs(nodes_table) do
         o:value(v.id, v.remarks)
