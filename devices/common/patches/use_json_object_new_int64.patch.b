--- a/package/feeds/luci/luci-lib-jsonc/src/jsonc.c
+++ b/package/feeds/luci/luci-lib-jsonc/src/jsonc.c
@@ -366,9 +366,7 @@
 	case LUA_TNUMBER:
 		nd = lua_tonumber(L, index);
-		ni = lua_tointeger(L, index);
-
-		if (nd == ni)
-			return json_object_new_int(nd);
-
+		if(nd >= INT64_MIN && nd <= INT64_MAX)
+			return json_object_new_int64(nd);
+		else
 		return json_object_new_double(nd);
 
