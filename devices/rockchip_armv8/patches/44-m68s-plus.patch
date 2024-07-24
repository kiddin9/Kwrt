--- a/package/boot/uboot-rockchip/Makefile
+++ b/package/boot/uboot-rockchip/Makefile
@@ -186,7 +186,8 @@ define U-Boot/mrkaio-m68s-rk3568
   $(U-Boot/Default/rk3568)
   NAME:=Mrkaio M68S
   BUILD_DEVICES:= \
-    ezpro_mrkaio-m68s
+    ezpro_mrkaio-m68s \
+    ezpro_mrkaio-m68s-plus
 endef
 
 define U-Boot/nanopi-r5c-rk3568

--- a/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
+++ b/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
@@ -9,7 +9,7 @@ rockchip_setup_interfaces()
 	case "$board" in
 	ariaboard,photonicat|\
 	armsom,sige7|\
-	ezpro,mrkaio-m68s|\
+	ezpro,mrkaio-m68s*|\
 	firefly,rk3568-roc-pc|\
 	friendlyarm,nanopi-r2c|\
 	friendlyarm,nanopi-r2c-plus|\
@@ -59,7 +59,7 @@ rockchip_setup_macs()
 
 	case "$board" in
 	armsom,sige7|\
-	ezpro,mrkaio-m68s|\
+	ezpro,mrkaio-m68s*|\
 	friendlyarm,nanopc-t6|\
 	friendlyarm,nanopi-r2c|\
 	friendlyarm,nanopi-r2s|\

--- a/target/linux/rockchip/image/armv8.mk
+++ b/target/linux/rockchip/image/armv8.mk
@@ -30,6 +30,16 @@ define Device/ezpro_mrkaio-m68s
 endef
 TARGET_DEVICES += ezpro_mrkaio-m68s
 
+define Device/ezpro_mrkaio-m68s-plus
+  DEVICE_VENDOR := EZPRO
+  DEVICE_MODEL := Mrkaio M68S Plus
+  SOC := rk3568
+  UBOOT_DEVICE_NAME := mrkaio-m68s-rk3568
+  BOOT_FLOW := pine64-img
+  DEVICE_PACKAGES := kmod-r8125 kmod-ata-ahci kmod-ata-ahci-platform kmod-nvme kmod-scsi-core
+endef
+TARGET_DEVICES += ezpro_mrkaio-m68s-plus
+
 define Device/firefly_roc-rk3328-cc
   DEVICE_VENDOR := Firefly
   DEVICE_MODEL := ROC-RK3328-CC
