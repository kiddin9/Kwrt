--- /feeds/custom/luci/qBittorrent/Makefile
+++ /feeds/custom/luci/qBittorrent/Makefile
@@ -7,6 +7,5 @@
 PKG_SOURCE:=$(PKG_NAME)-release-$(PKG_VERSION).tar.gz
-PKG_SOURCE_URL:=https://codeload.github.com/qbittorrent/qBittorrent/tar.gz/release-$(PKG_VERSION)?
-PKG_HASH:=skip
-
-PKG_BUILD_DIR:=$(BUILD_DIR)/qBittorrent-release-$(PKG_VERSION)
+PKG_SOURCE_URL:=https://github.com/c0re100/qBittorrent-Enhanced-Edition
+PKG_SOURCE_PROTO:=git
+PKG_SOURCE_VERSION:=latest
 
