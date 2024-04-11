--- a/target/linux/rockchip/image/Makefile
+++ b/target/linux/rockchip/image/Makefile
@@ -20,6 +20,23 @@ define Build/boot-common
 	$(CP) $(IMAGE_KERNEL) $@.boot/kernel.img
 endef
 
+define Build/boot-combined
+	# This creates a new folder copies the dtbs (as rockchip*.dtb)
+	# and the kernel image (as kernel.img)
+	rm -fR $@.boot
+	mkdir -p $@.boot
+
+	i=0; \
+	for dts in $(DEVICE_DTS); do \
+		dts=$$(echo $${dts} | cut -d'/' -f2); \
+		$(CP) $(KDIR)/image-$$(echo $${dts} | cut -d'/' -f2).dtb $@.boot/rockchip$$(perl -e 'printf "%b\n",'$$i).dtb; \
+		let i+=1; \
+	done
+
+	$(LN) rockchip0.dtb $@.boot/rockchip.dtb
+	$(CP) $(IMAGE_KERNEL) $@.boot/kernel.img
+endef
+
 define Build/boot-script
 	# Make an U-boot image and copy it to the boot partition
 	mkimage -A arm -O linux -T script -C none -a 0 -e 0 -d $(if $(1),$(1),mmc).bootscript $@.boot/boot.scr
diff --git a/target/linux/rockchip/image/nlnet-xgp.bootscript b/target/linux/rockchip/image/nlnet-xgp.bootscript
new file mode 100644
index 0000000000000..80df26f6c1520
--- /dev/null
+++ b/target/linux/rockchip/image/nlnet-xgp.bootscript
@@ -0,0 +1,38 @@
+# nlnet-xgp rk3568 combined image, board detected by ADC
+
+env delete hwrev
+env delete coreboard_adc_value
+env delete motherboard_adc_value
+
+# using SARADC CH1 to detect coreboard hwrev
+# using SARADC CH7 to detect motherboard hwrev
+
+adc single saradc@fe720000 1 coreboard_adc_value
+adc single saradc@fe720000 7 motherboard_adc_value
+
+if test -n "$coreboard_adc_value"; then
+    if test "$coreboard_adc_value" -lt 225000; then
+        echo coreboard rev02
+    fi
+fi
+
+if test -n "$motherboard_adc_value"; then
+    if test "$motherboard_adc_value" -lt 225000; then
+        echo motherboard rev03
+        setenv hwrev 1
+    fi
+fi
+
+env delete coreboard_adc_value
+env delete motherboard_adc_value
+
+part uuid mmc ${devnum}:2 uuid
+
+setenv bootargs "console=ttyS2,1500000 earlycon=uart8250,mmio32,0xfe660000 root=PARTUUID=${uuid} rw rootwait"
+
+load mmc ${devnum}:1 ${fdt_addr_r} rockchip${hwrev}.dtb
+load mmc ${devnum}:1 ${kernel_addr_r} kernel.img
+
+env delete hwrev
+
+booti ${kernel_addr_r} - ${fdt_addr_r}
