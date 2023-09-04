--- a/target/linux/rockchip/image/armv8.mk
+++ b/target/linux/rockchip/image/armv8.mk
@@ -52,4 +52,31 @@
 TARGET_DEVICES += friendlyarm_nanopi-r2s
 
+define Device/friendlyarm_nanopi-r6c
+  DEVICE_VENDOR := FriendlyARM
+  DEVICE_MODEL := NanoPi R6C
+  SOC := rk3328
+  DEVICE_PACKAGES := -luci-app-gpsysupgrade
+  DEVICE_DTS = rockchip/rk3328-nanopi-r2s
+endef
+TARGET_DEVICES += friendlyarm_nanopi-r6c
+
+define Device/friendlyarm_nanopi-r6s
+  DEVICE_VENDOR := FriendlyARM
+  DEVICE_MODEL := NanoPi R6S
+  SOC := rk3328
+  DEVICE_PACKAGES := -luci-app-gpsysupgrade
+  DEVICE_DTS = rockchip/rk3328-nanopi-r2s
+endef
+TARGET_DEVICES += friendlyarm_nanopi-r6s
+
+define Device/friendlyarm_nanopc-t6
+  DEVICE_VENDOR := FriendlyARM
+  DEVICE_MODEL := NanoPC T6
+  SOC := rk3328
+  DEVICE_PACKAGES := -luci-app-gpsysupgrade
+  DEVICE_DTS = rockchip/rk3328-nanopi-r2s
+endef
+TARGET_DEVICES += friendlyarm_nanopc-t6
+
 define Device/friendlyarm_nanopi-r4s
   DEVICE_VENDOR := FriendlyARM

--- a/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
+++ b/target/linux/rockchip/armv8/base-files/etc/board.d/02_network
@@ -21,9 +21,14 @@ rockchip_setup_interfaces()
 	sharevdi,h3399pc|\
 	sharevdi,guangmiao-g4c|\
 	xunlong,orangepi-r1-plus|\
-	xunlong,orangepi-r1-plus-lts)
+	xunlong,orangepi-r1-plus-lts|\
+	friendlyarm,nanopc-t6|\
+	friendlyarm,nanopi-r6c)
 		ucidef_set_interfaces_lan_wan 'eth1' 'eth0'
 		;;
+	friendlyarm,nanopi-r6s)
+		ucidef_set_interfaces_lan_wan "eth1 eth0" "eth2"
+		;;
 	fastrhino,r66s|\
 	firefly,rk3568-roc-pc|\
 	friendlyarm,nanopi-r5c|\
@@ -45,10 +50,10 @@ rockchip_setup_interfaces()
 	esac
 }
 
-nanopi_r4s_get_mac()
+nanopi_get_mac()
 {
 	local interface=$1
-	local eeprom_path="/sys/bus/i2c/devices/2-0051/eeprom"
+	local eeprom_path="/sys/bus/i2c/devices/$2/eeprom"
 	local address
 
 	if [ -f "$eeprom_path" ]; then
@@ -94,8 +99,12 @@ rockchip_setup_macs()
 		;;
 	friendlyarm,nanopi-r4s|\
 	friendlyarm,nanopi-r4se)
-		wan_mac=$(nanopi_r4s_get_mac wan)
-		lan_mac=$(nanopi_r4s_get_mac lan)
+		wan_mac=$(nanopi_get_mac wan 2-0051)
+		lan_mac=$(nanopi_get_mac lan 2-0051)
+		;;
+	friendlyarm,nanopi-r6s|friendlyarm,nanopi-r6c|friendlyarm,nanopc-t6)
+		wan_mac=$(nanopi_get_mac wan 6-0053)
+		lan_mac=$(nanopi_get_mac lan 6-0053)
 		;;
 	friendlyarm,nanopi-r5c|\
 	friendlyarm,nanopi-r5s|\

--- a/target/linux/rockchip/armv8/base-files/etc/board.d/01_leds
+++ a/target/linux/rockchip/armv8/base-files/etc/board.d/01_leds
@@ -36,6 +36,15 @@ hinlink,opc-h68k|\
 hinlink,opc-h69k)
 	ucidef_set_led_netdev "wan" "WAN" "blue:net" "eth0"
 	;;
+friendlyarm,nanopi-r6s)
+	ucidef_set_led_netdev "wan" "WAN" "green:wan" "eth2"
+	ucidef_set_led_netdev "lan1" "LAN1" "green:lan1" "eth1"
+	ucidef_set_led_netdev "lan2" "LAN2" "green:lan2" "eth0"
+	;;
+friendlyarm,nanopi-r6c)
+	ucidef_set_led_netdev "wan" "WAN" "green:wan" "eth0"
+	ucidef_set_led_netdev "lan1" "LAN1" "green:lan" "eth1"
+	;;
 esac
 
 board_config_flush

--- a/target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
+++ a/target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
@@ -52,5 +52,25 @@ friendlyarm,nanopi-r5s)
 	set_interface_core 2 "eth1"
 	set_interface_core 4 "eth2"
 	;;
+friendlyarm,nanopi-r6s)
+	set_interface_core 2 "eth0"
+	echo 3e > /sys/class/net/eth0/queues/rx-0/rps_cpus
+	set_interface_core 10 "eth1-0"
+	set_interface_core 20 "eth1-16"
+	set_interface_core 20 "eth1-18"
+	echo fe > /sys/class/net/eth1/queues/rx-0/rps_cpus
+	set_interface_core 40 "eth2-0"
+	set_interface_core 80 "eth2-16"
+	set_interface_core 80 "eth2-18"
+	echo fe > /sys/class/net/eth2/queues/rx-0/rps_cpus
+	;;
+friendlyarm,nanopi-r6c)
+	set_interface_core 40 "eth0"
+	echo fe > /sys/class/net/eth0/queues/rx-0/rps_cpus
+	set_interface_core 10 "eth1-0"
+	set_interface_core 20 "eth1-16"
+	set_interface_core 20 "eth1-18"
+	echo fe > /sys/class/net/eth1/queues/rx-0/rps_cpus
+	;;
 esac

--- a/target/linux/rockchip/image/Makefile
+++ b/target/linux/rockchip/image/Makefile
@@ -79,4 +79,15 @@ endif
 
 include $(SUBTARGET).mk
 
+define Image/Build
+	if [[ "$(PROFILE_SANITIZED)" == "friendlyarm_nanopc-t6" ]]; then \
+		export IMG_PREFIX="$(IMG_PREFIX)$(if $(PROFILE_SANITIZED),-$(PROFILE_SANITIZED))"; \
+		export BIN_DIR=$(BIN_DIR); \
+		export TOPDIR=$(TOPDIR); \
+		export MORE=$(MORE); \
+		cd /data/packit/friendlywrt22-rk3588; \
+		. ~/packit/packit_nanopi.sh; \
+	fi
+endef
+
 $(eval $(call BuildImage))
