--- a/package/kernel/mt76/Makefile
+++ b/package/kernel/mt76/Makefile
@@ -262,6 +262,12 @@ define KernelPackage/mt7921-firmware
   TITLE:=MediaTek MT7921 firmware
 endef
 
+define KernelPackage/mt7922-firmware
+  $(KernelPackage/mt76-default)
+  DEPENDS+=+kmod-mt7921-common
+  TITLE:=MediaTek MT7922 firmware
+endef
+
 define KernelPackage/mt792x-common
   $(KernelPackage/mt76-default)
   TITLE:=MediaTek MT792x wireless driver common code
@@ -555,6 +561,14 @@ define KernelPackage/mt7921-firmware/install
 		$(1)/lib/firmware/mediatek
 endef
 
+define KernelPackage/mt7922-firmware/install
+	$(INSTALL_DIR) $(1)/lib/firmware/mediatek
+	cp \
+		$(PKG_BUILD_DIR)/firmware/WIFI_MT7922_patch_mcu_1_1_hdr.bin \
+		$(PKG_BUILD_DIR)/firmware/WIFI_RAM_CODE_MT7922_1.bin \
+		$(1)/lib/firmware/mediatek
+endef
+
 define Package/mt76-test/install
 	mkdir -p $(1)/usr/sbin
 	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/mt76-test $(1)/usr/sbin
@@ -588,6 +602,7 @@ $(eval $(call KernelPackage,mt7916-firmware))
 $(eval $(call KernelPackage,mt7981-firmware))
 $(eval $(call KernelPackage,mt7986-firmware))
 $(eval $(call KernelPackage,mt7921-firmware))
+$(eval $(call KernelPackage,mt7922-firmware))
 $(eval $(call KernelPackage,mt792x-common))
 $(eval $(call KernelPackage,mt792x-usb))
 $(eval $(call KernelPackage,mt7921-common))
