--- a/target/linux/mediatek/base-files/etc/uci-defaults/99_fwenv-store-ethaddr.sh
+++ b/target/linux/mediatek/base-files/etc/uci-defaults/99_fwenv-store-ethaddr.sh
@@ -12,6 +12,7 @@ unielec,u7623-02)
 bananapi,bpi-r3|\
 bananapi,bpi-r3-mini|\
 bananapi,bpi-r4|\
+bananapi,bpi-r4-lite|\
 bananapi,bpi-r4-poe)
 	[ -z "$(fw_printenv -n ethaddr 2>/dev/null)" ] &&
 		fw_setenv ethaddr "$(cat /sys/class/net/eth0/address)"

--- a/target/linux/mediatek/filogic/base-files/etc/board.d/01_leds
+++ b/target/linux/mediatek/filogic/base-files/etc/board.d/01_leds
@@ -53,6 +53,9 @@ bananapi,bpi-r4-poe)
 	ucidef_set_led_netdev "lan2" "lan2" "mt7530-0:02:green:lan" "lan2" "link tx rx"
 	ucidef_set_led_netdev "lan3" "lan3" "mt7530-0:03:green:lan" "lan3" "link tx rx"
 	;;
+bananapi,bpi-r4-lite)
+	ucidef_set_led_netdev "sfp0" "sfp0" "green:sfp" "sfp0" "link tx rx"
+	;;
 cudy,re3000-v1|\
 wavlink,wl-wn573hx3)
 	ucidef_set_led_netdev "lan" "lan" "green:lan" "eth0" "link tx rx"

--- a/target/linux/mediatek/filogic/base-files/etc/board.d/02_network
+++ b/target/linux/mediatek/filogic/base-files/etc/board.d/02_network
@@ -171,6 +171,9 @@ mediatek_setup_macs()
 	bananapi,bpi-r4)
 		wan_mac=$(macaddr_add $(cat /sys/class/net/eth0/address) 1)
 		;;
+	bananapi,bpi-r4-lite)
+		ucidef_set_interfaces_lan_wan "lan0 lan1 lan2 lan3 sfp0" "eth1"
+		;;
 	h3c,magic-nx30-pro)
 		wan_mac=$(mtd_get_mac_ascii pdt_data_1 ethaddr)
 		lan_mac=$(macaddr_add "$wan_mac" 1)

--- a/target/linux/mediatek/filogic/base-files/lib/upgrade/platform.sh
+++ b/target/linux/mediatek/filogic/base-files/lib/upgrade/platform.sh
@@ -71,6 +71,7 @@ platform_do_upgrade() {
 	bananapi,bpi-r3-mini|\
 	bananapi,bpi-r4|\
 	bananapi,bpi-r4-poe|\
+	bananapi,bpi-r4-lite|\
 	cmcc,a10-ubootmod|\
 	cmcc,rax3000m|\
 	cudy,tr3000-v1-ubootmod|\
@@ -197,6 +198,7 @@ platform_check_image() {
 	bananapi,bpi-r3-mini|\
 	bananapi,bpi-r4|\
 	bananapi,bpi-r4-poe|\
+	bananapi,bpi-r4-lite|\
 	cmcc,rax3000m)
 		[ "$magic" != "d00dfeed" ] && {
 			echo "Invalid image type."
@@ -219,6 +221,7 @@ platform_copy_config() {
 	bananapi,bpi-r3-mini|\
 	bananapi,bpi-r4|\
 	bananapi,bpi-r4-poe|\
+	bananapi,bpi-r4-lite|\
 	cmcc,rax3000m)
 		if [ "$CI_METHOD" = "emmc" ]; then
 			emmc_copy_config

--- a/target/linux/mediatek/image/filogic.mk
+++ b/target/linux/mediatek/image/filogic.mk
@@ -638,6 +638,67 @@ endif
 endef
 TARGET_DEVICES += bananapi_bpi-r4-poe
 
+define Device/bananapi_bpi-r4-lite
+  DEVICE_VENDOR := Bananapi
+  DEVICE_MODEL := BPi-R4 Lite
+  DEVICE_DTS := mt7987a-bananapi-bpi-r4-lite
+  DEVICE_DTS_OVERLAY:= mt7987a-bananapi-bpi-r4-lite-1pcie-2L mt7987a-bananapi-bpi-r4-lite-2pcie-1L \
+		       mt7987a-bananapi-bpi-r4-lite-emmc mt7987a-bananapi-bpi-r4-lite-sd \
+		       mt7987a-bananapi-bpi-r4-lite-nand mt7987a-bananapi-bpi-r4-lite-nor
+  DEVICE_DTS_CONFIG := config-mt7987a-bananapi-bpi-r4-lite
+  DEVICE_DTC_FLAGS := --pad 4096
+  DEVICE_DTS_DIR := ../dts
+  DEVICE_DTS_LOADADDR := 0x4ff00000
+  DEVICE_PACKAGES := mt7987-2p5g-phy-firmware kmod-eeprom-at24 \
+		     kmod-gpio-pca953x kmod-i2c-mux-pca954x kmod-rtc-pcf8563 \
+		     kmod-sfp e2fsprogs mkf2fs
+  BLOCKSIZE := 128k
+  PAGESIZE := 2048
+  KERNEL_IN_UBI := 1
+  UBOOTENV_IN_UBI := 1
+  KERNEL_LOADADDR := 0x40000000
+  KERNEL := kernel-bin | gzip
+  KERNEL_INITRAMFS := kernel-bin | lzma | \
+        fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb with-initrd | pad-to 64k
+  IMAGES := sysupgrade.itb
+  KERNEL_INITRAMFS_SUFFIX := -recovery.itb
+  KERNEL_IN_UBI := 1
+  IMAGES := sysupgrade.itb
+  IMAGE/sysupgrade.itb := append-kernel | fit gzip $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb external-with-rootfs | pad-rootfs | append-metadata
+  ARTIFACTS := \
+	       emmc-preloader.bin emmc-bl31-uboot.fip \
+	       nor-preloader.bin nor-bl31-uboot.fip \
+	       sdcard.img.gz \
+	       snand-preloader.bin snand-bl31-uboot.fip
+  ARTIFACT/emmc-preloader.bin	:= mt7987-bl2 emmc-comb
+  ARTIFACT/emmc-bl31-uboot.fip	:= mt7987-bl31-uboot bananapi_bpi-r4-lite-emmc
+  ARTIFACT/nor-preloader.bin	:= mt7987-bl2 nor-comb
+  ARTIFACT/nor-bl31-uboot.fip	:= mt7987-bl31-uboot bananapi_bpi-r4-lite-nor
+  ARTIFACT/snand-preloader.bin	:= mt7987-bl2 spim-nand2-ubi-comb
+  ARTIFACT/snand-bl31-uboot.fip	:= mt7987-bl31-uboot bananapi_bpi-r4-lite-snand
+  ARTIFACT/sdcard.img.gz	:= mt798x-gpt sdmmc |\
+				   pad-to 17k | mt7987-bl2 sdmmc-comb |\
+				   pad-to 6656k | mt7987-bl31-uboot bananapi_bpi-r4-lite-sdmmc |\
+				$(if $(CONFIG_TARGET_ROOTFS_INITRAMFS),\
+				   pad-to 12M | append-image-stage initramfs-recovery.itb | check-size 44m |\
+				) \
+				   pad-to 44M | mt7987-bl2 spim-nand2-ubi-comb |\
+				   pad-to 45M | mt7987-bl31-uboot bananapi_bpi-r4-lite-snand |\
+				   pad-to 49M | mt7987-bl2 nor-comb |\
+				   pad-to 50M | mt7987-bl31-uboot bananapi_bpi-r4-lite-nor |\
+				   pad-to 51M | mt7987-bl2 emmc-comb |\
+				   pad-to 52M | mt7987-bl31-uboot bananapi_bpi-r4-lite-emmc |\
+				   pad-to 56M | mt798x-gpt emmc |\
+				$(if $(CONFIG_TARGET_ROOTFS_SQUASHFS),\
+				   pad-to 64M | append-image squashfs-sysupgrade.itb | check-size |\
+				) \
+				  gzip
+ifeq ($(DUMP),)
+  IMAGE_SIZE := $$(shell expr 64 + $$(CONFIG_TARGET_ROOTFS_PARTSIZE))m
+endif
+endef
+TARGET_DEVICES += bananapi_bpi-r4-lite
+
 define Device/cetron_ct3003
   DEVICE_VENDOR := Cetron
   DEVICE_MODEL := CT3003

--- a/package/firmware/linux-firmware/mediatek.mk
+++ b/package/firmware/linux-firmware/mediatek.mk
@@ -97,6 +97,16 @@ define Package/mt7986-wo-firmware/install
 endef
 $(eval $(call BuildPackage,mt7986-wo-firmware))
 
+Package/mt7987-2p5g-phy-firmware = $(call Package/firmware-default,MT7987 built-in 2.5G Ethernet PHY firmware,,LICENCE.mediatek)
+define Package/mt7987-2p5g-phy-firmware/install
+	$(INSTALL_DIR) $(1)/lib/firmware/mediatek/mt7987
+	$(INSTALL_DATA) \
+		$(PKG_BUILD_DIR)/mediatek/mt7987/i2p5ge-phy-DSPBitTb.bin \
+		$(PKG_BUILD_DIR)/mediatek/mt7987/i2p5ge-phy-pmb.bin \
+		$(1)/lib/firmware/mediatek/mt7987
+endef
+$(eval $(call BuildPackage,mt7987-2p5g-phy-firmware))
+
 Package/mt7988-2p5g-phy-firmware = $(call Package/firmware-default,MT7988 built-in 2.5G Ethernet PHY firmware,,LICENCE.mediatek)
 define Package/mt7988-2p5g-phy-firmware/install
 	$(INSTALL_DIR) $(1)/lib/firmware/mediatek/mt7988
