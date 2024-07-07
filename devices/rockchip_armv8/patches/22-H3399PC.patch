diff --git a/package/boot/uboot-rockchip/Makefile b/package/boot/uboot-rockchip/Makefile
index 096692f4214..54df60aa350 100644
--- a/package/boot/uboot-rockchip/Makefile
+++ b/package/boot/uboot-rockchip/Makefile
@@ -51,7 +51,8 @@ define U-Boot/nanopi-r2s-rk3328
   $(U-Boot/Default/rk3328)
   NAME:=NanoPi R2S
   BUILD_DEVICES:= \
-    friendlyarm_nanopi-r2s
+    friendlyarm_nanopi-r2s \
+    friendlyarm_nanopi-neo3
 endef
 
 define U-Boot/orangepi-r1-plus-rk3328
@@ -141,6 +141,27 @@ define U-Boot/rockpro64-rk3399
     pine64_rockpro64
 endef
 
+define U-Boot/rongpin-king3399-rk3399
+  $(U-Boot/Default/rk3399)
+  NAME:=Rongpin King3399
+  BUILD_DEVICES:= \
+    rongpin_king3399
+endef
+
+define U-Boot/rocktech-mpc1903-rk3399
+  $(U-Boot/Default/rk3399)
+  NAME:=Rocktech MPC1903
+  BUILD_DEVICES:= \
+    rocktech_mpc1903
+endef
+
+define U-Boot/sharevdi-h3399pc-rk3399
+  $(U-Boot/Default/rk3399)
+  NAME:=SHAREVDI H3399PC
+  BUILD_DEVICES:= \
+    sharevdi_h3399pc
+endef
+
 
 # RK3566 boards
 
@@ -300,6 +307,9 @@ UBOOT_TARGETS := \
   nanopi-r4se-rk3399 \
   rock-pi-4-rk3399 \
   rockpro64-rk3399 \
+  rongpin-king3399-rk3399 \
+  rocktech-mpc1903-rk3399 \
+  sharevdi-h3399pc-rk3399 \
   nanopi-r2c-rk3328 \
   nanopi-r2c-plus-rk3328 \
   nanopi-r2s-rk3328 \
diff --git a/target/linux/rockchip/armv8/base-files/etc/board.d/02_network b/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
index 7eb99ade652..92ede0f46e6 100644
--- a/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
+++ b/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
@@ -18,6 +18,9 @@ rockchip_setup_interfaces()
 	friendlyarm,nanopi-r4s-enterprise|\
 	friendlyarm,nanopi-r6c|\
 	radxa,rockpi-e|\
+	rocktech,mpc1903|\
+	sharevdi,h3399pc|\
+	nlnet,xgp|\
 	xunlong,orangepi-r1-plus|\
 	xunlong,orangepi-r1-plus-lts)
 		ucidef_set_interfaces_lan_wan 'eth1' 'eth0'
@@ -59,7 +60,10 @@ rockchip_setup_macs()
 	friendlyarm,nanopi-r2c|\
 	friendlyarm,nanopi-r2s|\
 	lunzn,fastrhino-r66s|\
-	lunzn,fastrhino-r68s)
+	lunzn,fastrhino-r68s|\
+	rocktech,mpc1903|\
+	nlnet,xgp|\
+	sharevdi,h3399pc)
 		wan_mac=$(macaddr_generate_from_mmc_cid mmcblk0)
 		lan_mac=$(macaddr_add "$wan_mac" 1)

--- a/target/linux/rockchip/image/armv8.mk
+++ b/target/linux/rockchip/image/armv8.mk
@@ -280,6 +280,46 @@
 endef
 TARGET_DEVICES += radxa_rock-pi-e
 
+define Device/friendlyarm_nanopi-neo3
+  DEVICE_VENDOR := FriendlyARM
+  DEVICE_MODEL := NanoPi NEO3
+  SOC := rk3328
+  UBOOT_DEVICE_NAME := nanopi-r2s-rk3328
+  BOOT_FLOW := pine64-bin
+endef
+TARGET_DEVICES += friendlyarm_nanopi-neo3
+
+define Device/rongpin_king3399
+  DEVICE_VENDOR := Rongpin
+  DEVICE_MODEL := King3399
+  SOC := rk3399
+  UBOOT_DEVICE_NAME := rongpin-king3399-rk3399
+  BOOT_FLOW := pine64-bin
+  DEVICE_PACKAGES := kmod-r8168 -urngd kmod-brcmfmac cypress-firmware-4356-sdio rongpin-king3399-firmware wpad-basic-mbedtls
+endef
+TARGET_DEVICES += rongpin_king3399
+
+define Device/rocktech_mpc1903
+  DEVICE_VENDOR := Rocktech
+  DEVICE_MODEL := MPC1903
+  SOC := rk3399
+  SUPPORTED_DEVICES := rocktech,mpc1903
+  UBOOT_DEVICE_NAME := rocktech-mpc1903-rk3399
+  BOOT_FLOW := pine64-bin
+  DEVICE_PACKAGES := kmod-usb-net-smsc75xx kmod-usb-serial-cp210x -urngd
+endef
+TARGET_DEVICES += rocktech_mpc1903
+
+define Device/sharevdi_h3399pc
+  DEVICE_VENDOR := SHAREVDI
+  DEVICE_MODEL := H3399PC
+  SOC := rk3399
+  UBOOT_DEVICE_NAME := sharevdi-h3399pc-rk3399
+  BOOT_FLOW := pine64-bin
+  DEVICE_PACKAGES := kmod-r8168 -urngd
+endef
+TARGET_DEVICES += sharevdi_h3399pc
+
 define Device/xunlong_orangepi-5
   DEVICE_VENDOR := Xunlong
   DEVICE_MODEL := Orange Pi 5
diff --git a/target/linux/rockchip/patches-6.6/900-arm64-boot-add-dts-files.patch b/target/linux/rockchip/patches-6.6/900-arm64-boot-add-dts-files.patch
index 231bca2b544..441ce2f4e59 100644
--- a/target/linux/rockchip/patches-6.6/900-arm64-boot-add-dts-files.patch
+++ b/target/linux/rockchip/patches-6.6/900-arm64-boot-add-dts-files.patch
@@ -1,10 +1,13 @@
 --- a/arch/arm64/boot/dts/rockchip/Makefile
 +++ b/arch/arm64/boot/dts/rockchip/Makefile
-@@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gr
+@@ -38,6 +38,10 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gr
  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-dumo.dtb
  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-inx.dtb
  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-kd.dtb
 +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-guangmiao-g4c.dtb
++dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-king3399.dtb
++dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-mpc1903.dtb
++dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-h3399pc.dtb
  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-hugsun-x99.dtb
  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge.dtb
  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge-captain.dtb
