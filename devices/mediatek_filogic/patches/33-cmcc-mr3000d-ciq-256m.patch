--- a/package/boot/uboot-tools/uboot-envtools/files/mediatek_filogic
+++ b/package/boot/uboot-tools/uboot-envtools/files/mediatek_filogic
@@ -140,9 +140,12 @@
 zyxel,ex5700-telenor)
 	ubootenv_add_uci_config "/dev/ubootenv" "0x0" "0x4000" "0x4000" "1"
 	;;
+cmcc,mr3000d-ciq-256m)
+	ubootenv_add_uci_config "/dev/mtd1" "0" "0x20000" "0x20000" 1
+	;;
 esac
 
 config_load ubootenv
 config_foreach ubootenv_add_app_config
 
 exit 0

--- a/target/linux/mediatek/filogic/base-files/etc/board.d/02_network
+++ b/target/linux/mediatek/filogic/base-files/etc/board.d/02_network
@@ -9,6 +9,7 @@
 	case $board in
 	abt,asr3000|\
 	buffalo,wsr-6000ax8|\
+	cmcc,mr3000d-ciq-256m|\
 	cmcc,rax3000m*|\
 	cmcc,xr30*|\
 	h3c,magic-nx30-pro|\

--- a/target/linux/mediatek/filogic/base-files/lib/upgrade/platform.sh
+++ b/target/linux/mediatek/filogic/base-files/lib/upgrade/platform.sh
@@ -214,7 +214,19 @@
 		;;
 	esac
 }
+
+tenbay_dualboot_fixup()
+{
+	[ "$(rootfs_type)" = "tmpfs" ] || return 0
 
+	if ! fw_printenv -n boot_from &>/dev/null; then
+		echo "unable to read uboot-env"
+		return 1
+	fi
+
+	fw_setenv boot_from ubi
+}
+
 platform_pre_upgrade() {
 	local board=$(board_name)
 
@@ -229,5 +241,8 @@
 	xiaomi,redmi-router-ax6000)
 		xiaomi_initial_setup
 		;;
+	cmcc,mr3000d-ciq-256m)
+		tenbay_dualboot_fixup
+		;;
 	esac
 }
diff --git a/target/linux/mediatek/image/filogic.mk b/target/linux/mediatek/image/filogic.mk
index 694b5a35b6d89a..d9967c12a965b7 100644
--- a/target/linux/mediatek/image/filogic.mk
+++ b/target/linux/mediatek/image/filogic.mk
@@ -588,6 +588,34 @@ define Device/cmcc_a10-ubootlayout
 endef
 TARGET_DEVICES += cmcc_a10-ubootlayout
 
+define Device/cmcc_mr3000d-ciq-256m
+  DEVICE_VENDOR := CMCC
+  DEVICE_MODEL := MR3000D-CIq (256M)
+  DEVICE_DTS := mt7981b-cmcc-mr3000d-ciq-256m
+  DEVICE_DTS_DIR := ../dts
+  DEVICE_PACKAGES := kmod-mt7915e kmod-mt7981-firmware mt7981-wo-firmware uboot-envtools
+  SUPPORTED_DEVICES := cmcc,mr3000d-ciq-256m mt7981-spim-nand-gsw-wr3000k
+  UBINIZE_OPTS := -E 5
+  BLOCKSIZE := 128k
+  PAGESIZE := 2048
+  IMAGE_SIZE := 65536k
+  KERNEL_IN_UBI := 1
+  IMAGES += factory.bin
+  IMAGE/factory.bin := append-ubi | check-size $$$$(IMAGE_SIZE)
+  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
+  KERNEL = kernel-bin | lzma | \
+	fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb
+  KERNEL_INITRAMFS = kernel-bin | lzma | \
+	fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb with-initrd
+ifneq ($(CONFIG_TARGET_ROOTFS_INITRAMFS),)
+ifeq ($(CONFIG_TARGET_ROOTFS_INITRAMFS_SEPARATE),)
+  ARTIFACTS := initramfs-MR3000D-CIq-factory.bin
+  ARTIFACT/initramfs-MR3000D-CIq-factory.bin := append-image-stage initramfs-kernel.bin | sysupgrade-initramfs-tar | append-metadata | tenbay-factory MR3000D-CIq
+endif
+endif
+endef
+TARGET_DEVICES += cmcc_mr3000d-ciq-256m
+
 define Device/cmcc_rax3000m
   DEVICE_VENDOR := CMCC
   DEVICE_MODEL := RAX3000M
