--- a/package/kernel/linux/modules/video.mk
+++ b/package/kernel/linux/modules/video.mk
@@ -225,7 +225,7 @@ define KernelPackage/drm
   SUBMENU:=$(VIDEO_MENU)
   TITLE:=Direct Rendering Manager (DRM) support
   HIDDEN:=1
-  DEPENDS:=+kmod-dma-buf +kmod-i2c-core +PACKAGE_kmod-backlight:kmod-backlight
+  DEPENDS:=+kmod-dma-buf +kmod-i2c-core +LINUX_5_10&&TARGET_x86_geode:kmod-backlight
   KCONFIG:=CONFIG_DRM
   FILES:= \
 	$(LINUX_DIR)/drivers/gpu/drm/drm.ko \
