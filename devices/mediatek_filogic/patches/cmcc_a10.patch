--- a/target/linux/mediatek/image/filogic.mk
+++ b/target/linux/mediatek/image/filogic.mk
@@ -500,21 +500,21 @@ define Device/cetron_ct3003
 endef
 TARGET_DEVICES += cetron_ct3003
 
-define Device/cmcc_a10-stock
+define Device/cmcc_a10
   DEVICE_VENDOR := CMCC
-  DEVICE_MODEL := A10 (stock layout)
+  DEVICE_MODEL := A10
   DEVICE_ALT0_VENDOR := SuperElectron
-  DEVICE_ALT0_MODEL := ZN-M5 (stock layout)
+  DEVICE_ALT0_MODEL := ZN-M5
   DEVICE_ALT1_VENDOR := SuperElectron
-  DEVICE_ALT1_MODEL := ZN-M8 (stock layout)
-  DEVICE_DTS := mt7981b-cmcc-a10-stock
+  DEVICE_ALT1_MODEL := ZN-M8
+  DEVICE_DTS := mt7981b-cmcc-a10
   DEVICE_DTS_DIR := ../dts
   SUPPORTED_DEVICES += mediatek,mt7981-spim-snand-rfb
   DEVICE_PACKAGES := kmod-mt7915e kmod-mt7981-firmware mt7981-wo-firmware
   UBINIZE_OPTS := -E 5
   BLOCKSIZE := 128k
   PAGESIZE := 2048
-  IMAGE_SIZE := 65536k
+  IMAGE_SIZE := 114688k
   KERNEL_IN_UBI := 1
   IMAGES += factory.bin
   IMAGE/factory.bin := append-ubi | check-size $$$$(IMAGE_SIZE)
@@ -524,7 +524,7 @@ define Device/cmcc_a10-stock
   KERNEL_INITRAMFS = kernel-bin | lzma | \
 	fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb with-initrd
 endef
-TARGET_DEVICES += cmcc_a10-stock
+TARGET_DEVICES += cmcc_a10
 
 define Device/cmcc_a10-ubootmod
   DEVICE_VENDOR := CMCC
