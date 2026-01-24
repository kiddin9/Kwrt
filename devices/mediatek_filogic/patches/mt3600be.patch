From 00745819f899ad6fb8c3e5bd78c566b3ef700889 Mon Sep 17 00:00:00 2001
From: Chen Minqiang <ptpt52@gmail.com>
Date: Sat, 22 Nov 2025 07:37:52 +0800
Subject: [PATCH] mediatek: init add GL.iNet GL-MT3600BE

---
 .../filogic/base-files/etc/board.d/02_network |   3 +
 .../filogic/base-files/etc/init.d/bootcount   |   4 +
 target/linux/mediatek/image/filogic.mk        |  22 ++
 4 files changed, 326 insertions(+)

diff --git a/target/linux/mediatek/filogic/base-files/etc/board.d/02_network b/target/linux/mediatek/filogic/base-files/etc/board.d/02_network
index 8cef4c7847377f..a7580cf55cfe4b 100644
--- a/target/linux/mediatek/filogic/base-files/etc/board.d/02_network
+++ b/target/linux/mediatek/filogic/base-files/etc/board.d/02_network
@@ -161,6 +161,9 @@ mediatek_setup_interfaces()
 	netcraze,nc-1812)
 		ucidef_set_interfaces_lan_wan "lan1 lan2 lan3 lan4 lan5" "wan"
 		;;
+	glinet,gl-mt3600be)
+		ucidef_set_interfaces_lan_wan "eth1" eth0
+		;;
 	mediatek,mt7986a-rfb)
 		ucidef_set_interfaces_lan_wan "lan1 lan2 lan3 lan4 lan6" "eth1 wan"
 		;;
diff --git a/target/linux/mediatek/filogic/base-files/etc/init.d/bootcount b/target/linux/mediatek/filogic/base-files/etc/init.d/bootcount
index 467a5e824f81f9..2a37f4b3cccb84 100755
--- a/target/linux/mediatek/filogic/base-files/etc/init.d/bootcount
+++ b/target/linux/mediatek/filogic/base-files/etc/init.d/bootcount
@@ -5,6 +5,10 @@ START=99
 
 boot() {
 	case $(board_name) in
+	glinet,gl-mt3600be)
+		ethtool --set-eee eth0 eee on
+		ethtool --set-eee eth0 eee off
+		;;
 	xiaomi,mi-router-ax3000t)
 		. /lib/upgrade/common.sh
 		[ "$(rootfs_type)" = "tmpfs" ] && \
diff --git a/target/linux/mediatek/image/filogic.mk b/target/linux/mediatek/image/filogic.mk
index 59efa7597e01b2..2eaa6cf0050b58 100644
--- a/target/linux/mediatek/image/filogic.mk
+++ b/target/linux/mediatek/image/filogic.mk
@@ -2213,6 +2213,21 @@ define Device/mediatek_mt7987a-rfb
 endef
 TARGET_DEVICES += mediatek_mt7987a-rfb
 
+define Device/glinet_gl-mt3600be
+  DEVICE_VENDOR := GL.iNet
+  DEVICE_MODEL := GL-MT3600BE
+  DEVICE_DTS := mt7987a-glinet-gl-mt3600be
+  DEVICE_DTS_DIR := ../dts
+  DEVICE_DTC_FLAGS := --pad 4096
+  DEVICE_DTS_LOADADDR := 0x4ff00000
+  DEVICE_PACKAGES := mt7987-2p5g-phy-firmware kmod-mt7990-firmware kmod-hwmon-pwmfan
+  UBINIZE_OPTS := -E 5
+  BLOCKSIZE := 128k
+  PAGESIZE := 2048
+  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
+endef
+TARGET_DEVICES += glinet_gl-mt3600be
+
 define Device/mediatek_mt7988a-rfb
   DEVICE_VENDOR := MediaTek
   DEVICE_MODEL := MT7988A rfb
