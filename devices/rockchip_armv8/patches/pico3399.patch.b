From f847e36bfe9d24f6bd86dc52ebf17f0025118cd6 Mon Sep 17 00:00:00 2001
From: icevel <icevel@126.com>
Date: Wed, 1 Feb 2023 17:20:59 +0800
Subject: [PATCH] add support

---
 package/boot/uboot-rockchip/Makefile          |  12 +
 ...99-Add-support-for-rockchip-pico3399.patch | 749 ++++++++++++++++++
 .../armv8/base-files/etc/board.d/02_network   |   1 +
 .../boot/dts/rockchip/rk3399-pico3399.dts     | 668 ++++++++++++++++
 target/linux/rockchip/image/armv8.mk          |  10 +
 ...99-add-support-for-rockchip-pico3399.patch |  11 +
 7 files changed, 1462 insertions(+)
 create mode 100644 package/boot/uboot-rockchip/patches/308-rockchip-rk3399-Add-support-for-rockchip-pico3399.patch
 create mode 100644 target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/rk3399-pico3399.dts
 create mode 100644 target/linux/rockchip/patches-5.15/213-rockchip-rk3399-add-support-for-rockchip-pico3399.patch

diff --git a/package/boot/uboot-rockchip/Makefile b/package/boot/uboot-rockchip/Makefile
index 69ce25dae..283f4821b 100644
--- a/package/boot/uboot-rockchip/Makefile
+++ b/package/boot/uboot-rockchip/Makefile
@@ -72,6 +72,17 @@ endef
 
 # RK3399 boards
 
+define U-Boot/rockchip-pico3399-rk3399
+  BUILD_SUBTARGET:=armv8
+  NAME:=rockchip pico3399
+  BUILD_DEVICES:= \
+    rockchip_pico3399
+  DEPENDS:=+PACKAGE_u-boot-rockchip-pico3399-rk3399:arm-trusted-firmware-rk3399
+  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip-vendor
+  ATF:=rk3399_bl31_v1.35.elf
+  USE_RKBIN:=1
+endef
+
 define U-Boot/guangmiao-g4c-rk3399
   BUILD_SUBTARGET:=armv8
   NAME:=GuangMiao G4C
@@ -308,6 +319,7 @@ UBOOT_TARGETS := \
   r66s-rk3568 \
   station-p2-rk3568 \
   panther-x2-rk3566 \
+  rockchip-pico3399-rk3399 \
   sharevdi-h3399pc-rk3399 \
   guangmiao-g4c-rk3399 \
   nanopi-r4s-rk3399 \
diff --git a/target/linux/rockchip/armv8/base-files/etc/board.d/02_network b/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
index 8bdefcbb6..5c0aa413a 100755
--- a/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
+++ b/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
@@ -39,6 +39,11 @@ rockchip_setup_interfaces()
 	friendlyarm,nanopi-r5s)
 		ucidef_set_interfaces_lan_wan "eth1 eth2" "eth0"
 		;;
+	ockchip,pico3399)
+		ucidef_set_interfaces_lan_wan 'eth0' 'eth1'
+		ucidef_add_switch "switch0" \
+			"0@eth0" "1:lan:1" "2:lan:2" "3:lan:3" "4:lan:4"
+		;;
 	*)
 		ucidef_set_interface_lan 'eth0'
 		;;
@@ -88,6 +93,7 @@ rockchip_setup_macs()
 	hinlink,opc-h68k|\
 	hinlink,opc-h69k|\
 	rocktech,mpc1903|\
+	rockchip,pico3399|\
 	sharevdi,h3399pc)
 		wan_mac=$(macaddr_generate_from_mmc_cid mmcblk0)
 		lan_mac=$(macaddr_add "$wan_mac" +1)
diff --git a/target/linux/rockchip/image/armv8.mk b/target/linux/rockchip/image/armv8.mk
index f15f8f26b..19d1eba72 100644
--- a/target/linux/rockchip/image/armv8.mk
+++ b/target/linux/rockchip/image/armv8.mk
@@ -192,6 +192,16 @@ define Device/rocktech_mpc1903
 endef
 TARGET_DEVICES += rocktech_mpc1903
 
+define Device/rockchip_pico3399
+  DEVICE_VENDOR := rockchip
+  DEVICE_MODEL := pico3399
+  SOC := rk3399
+  UBOOT_DEVICE_NAME := rockchip-pico3399-rk3399
+  IMAGE/sysupgrade.img.gz := boot-common | boot-script | pine64-bin | gzip | append-metadata
+  DEVICE_PACKAGES := kmod-r8168 kmod-r8125 kmod-nvme -urngd
+endef
+TARGET_DEVICES += rockchip_pico3399
+
 define Device/sharevdi_guangmiao-g4c
   DEVICE_VENDOR := SHAREVDI
   DEVICE_MODEL := GuangMiao G4C
diff --git a/target/linux/rockchip/patches-5.15/213-rockchip-rk3399-add-support-for-rockchip-pico3399.patch b/target/linux/rockchip/patches-5.15/213-rockchip-rk3399-add-support-for-rockchip-pico3399.patch
new file mode 100644
index 000000000..ddfa7f575
--- /dev/null
+++ b/target/linux/rockchip/patches-5.15/213-rockchip-rk3399-add-support-for-rockchip-pico3399.patch
@@ -0,0 +1,8 @@
+--- a/arch/arm64/boot/dts/rockchip/Makefile
++++ b/arch/arm64/boot/dts/rockchip/Makefile
+@@ -58,6 +58,7 @@
+ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
+ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
+ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
++dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pico3399.dtb
+ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-king3399.dtb
+ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-mpc1903.dtb
+ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-h3399pc.dtb
