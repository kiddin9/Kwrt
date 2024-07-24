From 467ef0219a65a3dd63ce27f41e54f09bf1f2ad64 Mon Sep 17 00:00:00 2001
From: kiddin9 <48883331+kiddin9@users.noreply.github.com>
Date: Mon, 4 Mar 2024 08:01:42 +0800
Subject: [PATCH] Update image.mk

Signed-off-by: kiddin9 <48883331+kiddin9@users.noreply.github.com>
---
 include/image.mk | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/image.mk b/include/image.mk
index 4b6acbe1aad6a..f307dea1ca9a3 100644
--- a/include/image.mk
+++ b/include/image.mk
@@ -313,6 +313,44 @@ ifdef CONFIG_TARGET_ROOTFS_TARGZ
   endef
 endif
 
+define Device/Build/targz
+  $$(_TARGET): $(if $(CONFIG_JSON_OVERVIEW_IMAGE_INFO), \
+	  $(BUILD_DIR)/json_info_files/$$(ROOTFSTZ).json, \
+	  $(BIN_DIR)/$$(ROOTFSTZ))
+
+  $(call Device/Export,$(BUILD_DIR)/json_info_files/$$(ROOTFSTZ).json,$(1))
+
+  $(BUILD_DIR)/json_info_files/$$(ROOTFSTZ).json: $(BIN_DIR)/$$(ROOTFSTZ)
+	@mkdir -p $$(shell dirname $$@)
+	DEVICE_ID="$(1)" \
+	SOURCE_DATE_EPOCH=$(SOURCE_DATE_EPOCH) \
+	FILE_NAME="$$(notdir $$^)" \
+	FILE_DIR="$(BIN_DIR)" \
+	FILE_TYPE="rootfs" \
+	FILE_FILESYSTEM="rootfs" \
+	DEVICE_IMG_PREFIX="$$(DEVICE_IMG_PREFIX)" \
+	DEVICE_VENDOR="$$(DEVICE_VENDOR)" \
+	DEVICE_MODEL="$$(DEVICE_MODEL)" \
+	DEVICE_VARIANT="$$(DEVICE_VARIANT)" \
+	DEVICE_ALT0_VENDOR="$$(DEVICE_ALT0_VENDOR)" \
+	DEVICE_ALT0_MODEL="$$(DEVICE_ALT0_MODEL)" \
+	DEVICE_ALT0_VARIANT="$$(DEVICE_ALT0_VARIANT)" \
+	DEVICE_ALT1_VENDOR="$$(DEVICE_ALT1_VENDOR)" \
+	DEVICE_ALT1_MODEL="$$(DEVICE_ALT1_MODEL)" \
+	DEVICE_ALT1_VARIANT="$$(DEVICE_ALT1_VARIANT)" \
+	DEVICE_ALT2_VENDOR="$$(DEVICE_ALT2_VENDOR)" \
+	DEVICE_ALT2_MODEL="$$(DEVICE_ALT2_MODEL)" \
+	DEVICE_ALT2_VARIANT="$$(DEVICE_ALT2_VARIANT)" \
+	DEVICE_TITLE="$$(DEVICE_TITLE)" \
+	DEVICE_PACKAGES="$$(DEVICE_PACKAGES)" \
+	TARGET="$(BOARD)" \
+	SUBTARGET="$(if $(SUBTARGET),$(SUBTARGET),generic)" \
+	VERSION_NUMBER="$(VERSION_NUMBER)" \
+	VERSION_CODE="$(VERSION_CODE)" \
+	SUPPORTED_DEVICES="$$(SUPPORTED_DEVICES)" \
+	$(TOPDIR)/scripts/json_add_image_info.py $$@
+endef
+
 ifdef CONFIG_TARGET_ROOTFS_CPIOGZ
   define Image/Build/cpiogz
 	( cd $(TARGET_DIR); find . | $(STAGING_DIR_HOST)/bin/cpio -o -H newc -R 0:0 | gzip -9n >$(BIN_DIR)/$(IMG_ROOTFS).cpio.gz )
@@ -394,6 +432,7 @@ define Device/Init
   FACTORY_IMG_NAME :=
   IMAGE_SIZE :=
   NAND_SIZE :=
+  ROOTFSTZ = $$(DEVICE_IMG_PREFIX)-rootfs.tar.gz
   KERNEL_PREFIX = $$(DEVICE_IMG_PREFIX)
   KERNEL_SUFFIX := -kernel.bin
   KERNEL_INITRAMFS_SUFFIX = $$(KERNEL_SUFFIX)
@@ -631,6 +670,7 @@ endef
 
 define Device/Build/image
   GZ_SUFFIX := $(if $(filter %dtb %gz,$(2)),,$(if $(and $(findstring ext4,$(1)),$(CONFIG_TARGET_IMAGES_GZIP)),.gz))
+  GZ_SUFFIX := $(if $(filter %dtb %gz,$(2)),,$(if $(and $(findstring ext4,$(1)),$(findstring img,$(2)),$(CONFIG_TARGET_IMAGES_GZIP)),.gz))
   $$(_TARGET): $(if $(CONFIG_JSON_OVERVIEW_IMAGE_INFO), \
 	  $(BUILD_DIR)/json_info_files/$(call DEVICE_IMG_NAME,$(1),$(2)).json, \
 	  $(BIN_DIR)/$(call DEVICE_IMG_NAME,$(1),$(2))$$(GZ_SUFFIX))
@@ -667,6 +707,7 @@ define Device/Build/image
 	FILE_DIR="$(KDIR)/tmp" \
 	FILE_TYPE=$(word 1,$(subst ., ,$(2))) \
 	FILE_FILESYSTEM="$(1)" \
+	KERNEL_INITRAMFS_IMAGE="$(subst $(IMG_PREFIX_EXTRA),,$(KERNEL_INITRAMFS_IMAGE))" \
 	DEVICE_IMG_PREFIX="$(DEVICE_IMG_PREFIX)" \
 	DEVICE_VENDOR="$(DEVICE_VENDOR)" \
 	DEVICE_MODEL="$(DEVICE_MODEL)" \
@@ -758,6 +799,8 @@ define Device/Build
   $(if $(CONFIG_TARGET_ROOTFS_INITRAMFS),$(call Device/Build/initramfs,$(1)))
   $(call Device/Build/kernel,$(1))
 
+  $(if $(CONFIG_TARGET_ROOTFS_TARGZ),$(call Device/Build/targz,$(PROFILE_SANITIZED)))
+
   $$(eval $$(foreach compile,$$(COMPILE), \
     $$(call Device/Build/compile,$$(compile),$(1))))
 
