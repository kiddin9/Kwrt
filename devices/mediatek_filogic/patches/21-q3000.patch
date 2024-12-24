--- a/target/linux/mediatek/image/filogic.mk
+++ b/target/linux/mediatek/image/filogic.mk 
@@ -733,6 +733,23 @@
 endef
 TARGET_DEVICES += h3c_magic-nx30-pro
 
+define Device/ikuai_q3000
+  DEVICE_VENDOR := iKuai
+  DEVICE_MODEL := Q3000
+  DEVICE_DTS := mt7981b-ikuai-q3000
+  DEVICE_DTS_DIR := ../dts
+  SUPPORTED_DEVICES := ikuai,q3000
+  UBINIZE_OPTS := -E 5
+  BLOCKSIZE := 128k
+  PAGESIZE := 2048
+  IMAGE_SIZE := 114816k
+  KERNEL_IN_UBI := 1
+  IMAGES += factory.bin
+  IMAGE/factory.bin := append-ubi | check-size $$$$(IMAGE_SIZE)
+  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
+endef
+TARGET_DEVICES += ikuai_q3000
+
 define Device/imou_lc-hx3001
   DEVICE_VENDOR := IMOU
   DEVICE_MODEL := LC-HX3001

--- a/target/linux/mediatek/filogic/base-files/etc/board.d/01_leds
+++ b/target/linux/mediatek/filogic/base-files/etc/board.d/01_leds
@@ -49,6 +49,11 @@ glinet,gl-xe3000)
 	ucidef_set_led_netdev "wlan2g" "WLAN2G" "green:wifi2g" "phy0-ap0"
 	ucidef_set_led_netdev "wlan5g" "WLAN5G" "green:wifi5g" "phy1-ap0"
 	;;
+ikuai,q3000)
+	ucidef_set_led_default "green" "GREEN" "q3000:green" "1"
+	ucidef_set_led_default "blue" "BLUE" "q3000:blue" "0"
+	ucidef_set_led_default "red" "RED" "q3000:red" "0"
+	;;
 mercusys,mr90x-v1|\
 mercusys,mr90x-v1-ubi)
 	ucidef_set_led_netdev "lan-0" "lan-0" "green:lan-0" "lan0" "link tx rx"

--- a/target/linux/mediatek/filogic/base-files/etc/board.d/02_network
+++ b/target/linux/mediatek/filogic/base-files/etc/board.d/02_network
@@ -18,6 +18,7 @@ mediatek_setup_interfaces()
 	cetron,ct3003|\
 	confiabits,mt7981|\
 	cudy,wr3000-v1|\
+	ikuai,q3000|\
 	jcg,q30-pro|\
 	qihoo,360t7|\
 	routerich,ax3000)
@@ -145,6 +146,10 @@ mediatek_setup_macs()
 		lan_mac=$(macaddr_add "$wan_mac" 1)
 		label_mac=$wan_mac
 		;;
+	ikuai,q3000)
+		wan_mac=$(mtd_get_mac_binary $part_name 0x10048)
+		lan_mac=$(macaddr_add $wan_mac 1)
+		;;
 	mercusys,mr90x-v1|\
 	tplink,re6000xd)
 		label_mac=$(get_mac_binary "/tmp/tp_data/default-mac" 0)
