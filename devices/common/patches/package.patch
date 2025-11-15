--- a/include/package.mk
+++ b/include/package.mk
@@ -354,3 +354,11 @@ dist:
 
 distcheck:
 	$(Build/DistCheck)
+
+ifndef Package/$(PKG_NAME)/conffiles
+define Package/$(PKG_NAME)/conffiles
+/etc/config/
+/etc/$(PKG_NAME)/
+endef
+endif
+

--- a/package/Makefile
+++ b/package/Makefile
@@ -118,8 +118,11 @@ endif
 
 	$(call prepare_rootfs,$(TARGET_DIR),$(TOPDIR)/files)
 
+PACKAGE_SUFFIX:=$(if $(CONFIG_USE_APK),apk,ipk)
 $(curdir)/index: FORCE
 	@echo Generating package index...
+	$(FIND) $(wildcard $(PACKAGE_SUBDIRS)) -path $(PACKAGE_DIR) -prune -o \
+    -type f -name '*.$(PACKAGE_SUFFIX)' -exec $(CP) -t $(PACKAGE_DIR)/ {} +
 ifneq ($(CONFIG_USE_APK),)
 	@for d in $(PACKAGE_SUBDIRS); do \
 		mkdir -p $$d; \
