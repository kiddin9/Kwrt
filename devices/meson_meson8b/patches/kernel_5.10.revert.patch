diff --git a/package/kernel/linux/modules/fs.mk b/package/kernel/linux/modules/fs.mk
index 77d8d6c98bc8b..c3c56864b77e7 100644
--- a/package/kernel/linux/modules/fs.mk
+++ b/package/kernel/linux/modules/fs.mk
@@ -83,21 +83,36 @@ endef
 $(eval $(call KernelPackage,fs-btrfs))
 
 
+define KernelPackage/fs-smbfs-common
+  SUBMENU:=$(FS_MENU)
+  TITLE:=SMBFS common dependencies support
+  HIDDEN:=1
+  KCONFIG:=CONFIG_SMBFS_COMMON
+  FILES:= \
+	$(LINUX_DIR)/fs/smbfs_common/cifs_arc4.ko \
+	$(LINUX_DIR)/fs/smbfs_common/cifs_md4.ko
+endef
+
+define KernelPackage/fs-smbfs-common/description
+ Kernel module dependency for CIFS or SMB_SERVER support
+endef
+
+$(eval $(call KernelPackage,fs-smbfs-common))
+
+
 define KernelPackage/fs-cifs
   SUBMENU:=$(FS_MENU)
   TITLE:=CIFS support
   KCONFIG:= \
-	CONFIG_SMBFS_COMMON \
 	CONFIG_CIFS \
 	CONFIG_CIFS_DFS_UPCALL=n \
 	CONFIG_CIFS_UPCALL=n
   FILES:= \
-	$(LINUX_DIR)/fs/smbfs_common/cifs_arc4.ko \
-	$(LINUX_DIR)/fs/smbfs_common/cifs_md4.ko \
 	$(LINUX_DIR)/fs/cifs/cifs.ko
   AUTOLOAD:=$(call AutoLoad,30,cifs)
   $(call AddDepends/nls)
   DEPENDS+= \
+    +kmod-fs-smbfs-common \
     +kmod-crypto-md5 \
     +kmod-crypto-sha256 \
     +kmod-crypto-sha512 \
diff --git a/package/kernel/linux/modules/crypto.mk b/package/kernel/linux/modules/crypto.mk
index 446801ae23360..a3785d26fd04b 100644
--- a/package/kernel/linux/modules/crypto.mk
+++ b/package/kernel/linux/modules/crypto.mk
@@ -824,9 +824,7 @@ $(eval $(call KernelPackage,crypto-rmd160))
 
 define KernelPackage/crypto-rng
   TITLE:=CryptoAPI random number generation
-  DEPENDS:=+kmod-crypto-hash +kmod-crypto-hmac \
-		+LINUX_5_10:kmod-crypto-sha256 \
-		+LINUX_5_15:kmod-crypto-sha512
+  DEPENDS:=+kmod-crypto-hash +kmod-crypto-hmac +kmod-crypto-sha512
   KCONFIG:= \
 	CONFIG_CRYPTO_DRBG \
 	CONFIG_CRYPTO_DRBG_HMAC=y \
diff --git a/package/kernel/linux/modules/fs.mk b/package/kernel/linux/modules/fs.mk
index 547cc796442bd..77d8d6c98bc8b 100644
--- a/package/kernel/linux/modules/fs.mk
+++ b/package/kernel/linux/modules/fs.mk
@@ -98,20 +98,18 @@ define KernelPackage/fs-cifs
   AUTOLOAD:=$(call AutoLoad,30,cifs)
   $(call AddDepends/nls)
   DEPENDS+= \
-    +LINUX_5_10:kmod-crypto-md4\
     +kmod-crypto-md5 \
     +kmod-crypto-sha256 \
     +kmod-crypto-sha512 \
     +kmod-crypto-cmac \
     +kmod-crypto-hmac \
-    +LINUX_5_10:kmod-crypto-arc4 \
     +kmod-crypto-aead \
     +kmod-crypto-ccm \
     +kmod-crypto-ecb \
     +kmod-crypto-des \
-    +(LINUX_5_15):kmod-asn1-decoder \
-    +(LINUX_5_15):kmod-oid-registry \
-    +(LINUX_5_15):kmod-dnsresolver
+    +kmod-asn1-decoder \
+    +kmod-oid-registry \
+    +kmod-dnsresolver
 endef
 
 define KernelPackage/fs-cifs/description
@@ -367,7 +365,6 @@ $(eval $(call KernelPackage,fs-msdos))
 define KernelPackage/fs-netfs
   SUBMENU:=$(FS_MENU)
   TITLE:=Network Filesystems support
-  DEPENDS:=@LINUX_5_15
   KCONFIG:= CONFIG_NETFS_SUPPORT
   FILES:=$(LINUX_DIR)/fs/netfs/netfs.ko
   AUTOLOAD:=$(call AutoLoad,28,netfs)
@@ -531,7 +528,6 @@ define KernelPackage/fs-ntfs3
   KCONFIG:= CONFIG_NTFS3_FS CONFIG_NTFS3_FS_POSIX_ACL=y
   FILES:=$(LINUX_DIR)/fs/ntfs3/ntfs3.ko
   $(call AddDepends/nls)
-  DEPENDS+=@!LINUX_5_10
   AUTOLOAD:=$(call AutoLoad,80,ntfs3)
 endef
 
diff --git a/package/kernel/linux/modules/input.mk b/package/kernel/linux/modules/input.mk
index 6cc72207f3ebd..92587b1874cf0 100644
--- a/package/kernel/linux/modules/input.mk
+++ b/package/kernel/linux/modules/input.mk
@@ -92,7 +92,7 @@ $(eval $(call KernelPackage,input-gpio-keys))
 define KernelPackage/input-gpio-keys-polled
   SUBMENU:=$(INPUT_MODULES_MENU)
   TITLE:=Polled GPIO key support
-  DEPENDS:=@GPIO_SUPPORT +kmod-input-core +LINUX_5_10:kmod-input-polldev
+  DEPENDS:=@GPIO_SUPPORT +kmod-input-core
   KCONFIG:= \
 	CONFIG_KEYBOARD_GPIO_POLLED \
 	CONFIG_INPUT_KEYBOARD=y
@@ -142,21 +142,6 @@ endef
 $(eval $(call KernelPackage,input-joydev))
 
 
-define KernelPackage/input-polldev
-  SUBMENU:=$(INPUT_MODULES_MENU)
-  TITLE:=Polled Input device support
-  DEPENDS:=+kmod-input-core @LINUX_5_10
-  KCONFIG:=CONFIG_INPUT_POLLDEV
-  FILES:=$(LINUX_DIR)/drivers/input/input-polldev.ko
-endef
-
-define KernelPackage/input-polldev/description
- Kernel module for support of polled input devices
-endef
-
-$(eval $(call KernelPackage,input-polldev))
-
-
 define KernelPackage/input-matrixkmap
   SUBMENU:=$(INPUT_MODULES_MENU)
   TITLE:=Input matrix devices support
diff --git a/package/kernel/linux/modules/leds.mk b/package/kernel/linux/modules/leds.mk
index ce72465ce4d82..fcf9c987e8ece 100644
--- a/package/kernel/linux/modules/leds.mk
+++ b/package/kernel/linux/modules/leds.mk
@@ -118,7 +118,6 @@ $(eval $(call KernelPackage,ledtrig-pattern))
 define KernelPackage/ledtrig-tty
   SUBMENU:=$(LEDS_MENU)
   TITLE:=LED Trigger for TTY devices
-  DEPENDS:=@LINUX_5_15
   KCONFIG:=CONFIG_LEDS_TRIGGER_TTY
   FILES:=$(LED_TRIGGER_DIR)/ledtrig-tty.ko
   AUTOLOAD:=$(call AutoLoad,50,ledtrig-tty)
diff --git a/package/kernel/linux/modules/netdevices.mk b/package/kernel/linux/modules/netdevices.mk
index ade6438b9c9ba..dd458ece4cfd4 100644
--- a/package/kernel/linux/modules/netdevices.mk
+++ b/package/kernel/linux/modules/netdevices.mk
@@ -1448,7 +1448,6 @@ $(eval $(call KernelPackage,sfc-falcon))
 define KernelPackage/wwan
   SUBMENU:=$(NETWORK_DEVICES_MENU)
   TITLE:=WWAN Driver Core
-  DEPENDS:=@LINUX_5_15
   KCONFIG:=CONFIG_WWAN
   FILES:=$(LINUX_DIR)/drivers/net/wwan/wwan.ko
   AUTOLOAD:=$(call AutoProbe,wwan)
@@ -1464,7 +1463,7 @@ $(eval $(call KernelPackage,wwan))
 define KernelPackage/mhi-net
   SUBMENU:=$(NETWORK_DEVICES_MENU)
   TITLE:=MHI Network Device
-  DEPENDS:=@LINUX_5_15 @PCI_SUPPORT +kmod-mhi-bus
+  DEPENDS:=@PCI_SUPPORT +kmod-mhi-bus
   KCONFIG:=CONFIG_MHI_NET
   FILES:=$(LINUX_DIR)/drivers/net/mhi_net.ko
   AUTOLOAD:=$(call AutoProbe,mhi_net)
@@ -1479,7 +1478,7 @@ $(eval $(call KernelPackage,mhi-net))
 define KernelPackage/mhi-wwan-ctrl
   SUBMENU:=$(NETWORK_DEVICES_MENU)
   TITLE:=MHI WWAN Control
-  DEPENDS:=@LINUX_5_15 @PCI_SUPPORT +kmod-mhi-bus +kmod-wwan
+  DEPENDS:=@PCI_SUPPORT +kmod-mhi-bus +kmod-wwan
   KCONFIG:=CONFIG_MHI_WWAN_CTRL
   FILES:=$(LINUX_DIR)/drivers/net/wwan/mhi_wwan_ctrl.ko
   AUTOLOAD:=$(call AutoProbe,mhi_wwan_ctrl)
@@ -1495,7 +1494,7 @@ $(eval $(call KernelPackage,mhi-wwan-ctrl))
 define KernelPackage/mhi-wwan-mbim
   SUBMENU:=$(NETWORK_DEVICES_MENU)
   TITLE:=MHI MBIM
-  DEPENDS:=@LINUX_5_15 @PCI_SUPPORT +kmod-mhi-bus +kmod-wwan
+  DEPENDS:=@PCI_SUPPORT +kmod-mhi-bus +kmod-wwan
   KCONFIG:=CONFIG_MHI_WWAN_MBIM
   FILES:=$(LINUX_DIR)/drivers/net/wwan/mhi_wwan_mbim.ko
   AUTOLOAD:=$(call AutoProbe,mhi_wwan_mbim)
diff --git a/package/kernel/linux/modules/netsupport.mk b/package/kernel/linux/modules/netsupport.mk
index d9d6a98ed245d..4653b8256502e 100644
--- a/package/kernel/linux/modules/netsupport.mk
+++ b/package/kernel/linux/modules/netsupport.mk
@@ -1187,7 +1187,7 @@ define KernelPackage/sctp
   FILES:= $(LINUX_DIR)/net/sctp/sctp.ko
   AUTOLOAD:= $(call AutoLoad,32,sctp)
   DEPENDS:=+kmod-lib-crc32c +kmod-crypto-md5 +kmod-crypto-hmac \
-    +LINUX_5_15:kmod-udptunnel4 +LINUX_5_15:kmod-udptunnel6
+    +kmod-udptunnel4 +kmod-udptunnel6
 endef
 
 define KernelPackage/sctp/description
@@ -1443,7 +1443,6 @@ define KernelPackage/qrtr
   SUBMENU:=$(NETWORK_SUPPORT_MENU)
   TITLE:=Qualcomm IPC Router support
   HIDDEN:=1
-  DEPENDS:=@!LINUX_5_10
   KCONFIG:=CONFIG_QRTR
   FILES:= \
   $(LINUX_DIR)/net/qrtr/qrtr.ko
diff --git a/package/kernel/linux/modules/other.mk b/package/kernel/linux/modules/other.mk
index e8b4ea54feaf7..51e70fbe18af5 100644
--- a/package/kernel/linux/modules/other.mk
+++ b/package/kernel/linux/modules/other.mk
@@ -1251,8 +1251,8 @@ $(eval $(call KernelPackage,keys-trusted))
 define KernelPackage/tpm
   SUBMENU:=$(OTHER_MENU)
   TITLE:=TPM Hardware Support
-  DEPENDS:= +kmod-random-core +(LINUX_5_15):kmod-asn1-decoder \
-	  +(LINUX_5_15):kmod-asn1-encoder +(LINUX_5_15):kmod-oid-registry
+  DEPENDS:= +kmod-random-core +kmod-asn1-decoder \
+	  +kmod-asn1-encoder +kmod-oid-registry
   KCONFIG:= CONFIG_TCG_TPM
   FILES:= $(LINUX_DIR)/drivers/char/tpm/tpm.ko
   AUTOLOAD:=$(call AutoLoad,10,tpm,1)
@@ -1336,7 +1336,6 @@ $(eval $(call KernelPackage,i6300esb-wdt))
 define KernelPackage/mhi-bus
   SUBMENU:=$(OTHER_MENU)
   TITLE:=MHI bus
-  DEPENDS:=@LINUX_5_15
   KCONFIG:=CONFIG_MHI_BUS \
            CONFIG_MHI_BUS_DEBUG=y
   FILES:=$(LINUX_DIR)/drivers/bus/mhi/core/mhi.ko
@@ -1352,7 +1351,7 @@ $(eval $(call KernelPackage,mhi-bus))
 define KernelPackage/mhi-pci-generic
   SUBMENU:=$(OTHER_MENU)
   TITLE:=MHI PCI controller driver
-  DEPENDS:=@LINUX_5_15 @PCI_SUPPORT +kmod-mhi-bus
+  DEPENDS:=@PCI_SUPPORT +kmod-mhi-bus
   KCONFIG:=CONFIG_MHI_BUS_PCI_GENERIC
   FILES:=$(LINUX_DIR)/drivers/bus/mhi/mhi_pci_generic.ko
   AUTOLOAD:=$(call AutoProbe,mhi_pci_generic)
diff --git a/package/kernel/linux/modules/usb.mk b/package/kernel/linux/modules/usb.mk
index 5747ad21663a2..2561f36aa3d6d 100644
--- a/package/kernel/linux/modules/usb.mk
+++ b/package/kernel/linux/modules/usb.mk
@@ -1155,7 +1155,7 @@ $(eval $(call KernelPackage,usb-net-aqc111))
 
 define KernelPackage/usb-net-asix
   TITLE:=Kernel module for USB-to-Ethernet Asix convertors
-  DEPENDS:=+kmod-libphy +LINUX_5_15:kmod-net-selftests +LINUX_5_15:kmod-mdio-devres +kmod-phy-ax88796b
+  DEPENDS:=+kmod-libphy +kmod-net-selftests +kmod-mdio-devres +kmod-phy-ax88796b
   KCONFIG:=CONFIG_USB_NET_AX8817X
   FILES:=$(LINUX_DIR)/drivers/$(USBNET_DIR)/asix.ko
   AUTOLOAD:=$(call AutoProbe,asix)
@@ -1394,7 +1394,7 @@ define KernelPackage/usb-net-rtl8152
   KCONFIG:=CONFIG_USB_RTL8152
   FILES:=$(LINUX_DIR)/drivers/$(USBNET_DIR)/r8152.ko
   AUTOLOAD:=$(call AutoProbe,r8152)
-  $(call AddDepends/usb-net, +LINUX_5_10:kmod-crypto-hash)
+  $(call AddDepends/usb-net)
 endef
 
 define KernelPackage/usb-net-rtl8152/description
diff --git a/package/kernel/linux/modules/video.mk b/package/kernel/linux/modules/video.mk
index a89ceef54b1a3..f1e61f33a5761 100644
--- a/package/kernel/linux/modules/video.mk
+++ b/package/kernel/linux/modules/video.mk
@@ -226,7 +226,7 @@ define KernelPackage/drm
   TITLE:=Direct Rendering Manager (DRM) support
   HIDDEN:=1
   DEPENDS:=+kmod-dma-buf +kmod-i2c-core +PACKAGE_kmod-backlight:kmod-backlight \
-	+(LINUX_5_15):kmod-fb
+	+kmod-fb
   KCONFIG:=CONFIG_DRM
   FILES:= \
 	$(LINUX_DIR)/drivers/gpu/drm/drm.ko \
diff --git a/package/kernel/linux/modules/block.mk b/package/kernel/linux/modules/block.mk
index f6c9df06989ab..bdf84e8ae29b2 100644
--- a/package/kernel/linux/modules/block.mk
+++ b/package/kernel/linux/modules/block.mk
@@ -521,13 +521,13 @@ define KernelPackage/scsi-core
   TITLE:=SCSI device support
   KCONFIG:= \
 	CONFIG_SCSI \
-	CONFIG_SCSI_COMMON@ge5.15 \
+	CONFIG_SCSI_COMMON \
 	CONFIG_BLK_DEV_SD
   FILES:= \
 	$(LINUX_DIR)/drivers/scsi/scsi_mod.ko \
-	$(LINUX_DIR)/drivers/scsi/scsi_common.ko@ge5.15 \
+	$(LINUX_DIR)/drivers/scsi/scsi_common.ko \
 	$(LINUX_DIR)/drivers/scsi/sd_mod.ko
-  AUTOLOAD:=$(call AutoLoad,40,scsi_mod scsi_common@ge5.15 sd_mod,1)
+  AUTOLOAD:=$(call AutoLoad,40,scsi_mod scsi_common sd_mod,1)
 endef
 
 $(eval $(call KernelPackage,scsi-core))
diff --git a/package/kernel/linux/modules/crypto.mk b/package/kernel/linux/modules/crypto.mk
index 98bcb9e874701..446801ae23360 100644
--- a/package/kernel/linux/modules/crypto.mk
+++ b/package/kernel/linux/modules/crypto.mk
@@ -704,7 +704,6 @@ define KernelPackage/crypto-misc
 	CONFIG_CRYPTO_KHAZAD \
 	CONFIG_CRYPTO_SERPENT \
 	CONFIG_CRYPTO_TEA \
-	CONFIG_CRYPTO_TGR192@lt5.12 \
 	CONFIG_CRYPTO_TWOFISH \
 	CONFIG_CRYPTO_TWOFISH_COMMON \
 	CONFIG_CRYPTO_TWOFISH_586 \
@@ -717,7 +716,6 @@ define KernelPackage/crypto-misc
 	$(LINUX_DIR)/crypto/cast6_generic.ko \
 	$(LINUX_DIR)/crypto/khazad.ko \
 	$(LINUX_DIR)/crypto/tea.ko \
-	$(LINUX_DIR)/crypto/tgr192.ko@lt5.12 \
 	$(LINUX_DIR)/crypto/twofish_common.ko \
 	$(LINUX_DIR)/crypto/wp512.ko \
 	$(LINUX_DIR)/crypto/twofish_generic.ko \
@@ -725,7 +723,7 @@ define KernelPackage/crypto-misc
 	$(LINUX_DIR)/crypto/blowfish_generic.ko \
 	$(LINUX_DIR)/crypto/serpent_generic.ko
   AUTOLOAD:=$(call AutoLoad,10,anubis camellia_generic cast_common \
-	cast5_generic cast6_generic khazad tea tgr192@lt5.12 twofish_common \
+	cast5_generic cast6_generic khazad tea twofish_common \
 	wp512 blowfish_common serpent_generic)
   ifndef CONFIG_TARGET_x86
 	AUTOLOAD+= $(call AutoLoad,10,twofish_generic blowfish_generic)
@@ -738,10 +736,9 @@ ifndef CONFIG_TARGET_x86_64
     FILES+= \
 	$(LINUX_DIR)/arch/x86/crypto/twofish-i586.ko \
 	$(LINUX_DIR)/arch/x86/crypto/serpent-sse2-i586.ko \
-	$(LINUX_DIR)/arch/x86/crypto/glue_helper.ko@lt5.12 \
 	$(LINUX_DIR)/crypto/cryptd.ko \
 	$(LINUX_DIR)/crypto/crypto_simd.ko
-    AUTOLOAD+= $(call AutoLoad,10,cryptd glue_helper@lt5.12 \
+    AUTOLOAD+= $(call AutoLoad,10,cryptd \
 	serpent-sse2-i586 twofish-i586 blowfish_generic)
   endef
 endif
diff --git a/package/kernel/linux/modules/fs.mk b/package/kernel/linux/modules/fs.mk
index 19fa9fcfc0720..547cc796442bd 100644
--- a/package/kernel/linux/modules/fs.mk
+++ b/package/kernel/linux/modules/fs.mk
@@ -87,13 +87,13 @@ define KernelPackage/fs-cifs
   SUBMENU:=$(FS_MENU)
   TITLE:=CIFS support
   KCONFIG:= \
-	CONFIG_SMBFS_COMMON@ge5.15 \
+	CONFIG_SMBFS_COMMON \
 	CONFIG_CIFS \
 	CONFIG_CIFS_DFS_UPCALL=n \
 	CONFIG_CIFS_UPCALL=n
   FILES:= \
-	$(LINUX_DIR)/fs/smbfs_common/cifs_arc4.ko@ge5.15 \
-	$(LINUX_DIR)/fs/smbfs_common/cifs_md4.ko@ge5.15 \
+	$(LINUX_DIR)/fs/smbfs_common/cifs_arc4.ko \
+	$(LINUX_DIR)/fs/smbfs_common/cifs_md4.ko \
 	$(LINUX_DIR)/fs/cifs/cifs.ko
   AUTOLOAD:=$(call AutoLoad,30,cifs)
   $(call AddDepends/nls)
diff --git a/package/kernel/linux/modules/iio.mk b/package/kernel/linux/modules/iio.mk
index c0e37f06c7455..f901f87ddd512 100644
--- a/package/kernel/linux/modules/iio.mk
+++ b/package/kernel/linux/modules/iio.mk
@@ -438,7 +438,7 @@ define KernelPackage/iio-sps30
 	CONFIG_SPS30_I2C
   FILES:= \
 	$(LINUX_DIR)/drivers/iio/chemical/sps30.ko \
-	$(LINUX_DIR)/drivers/iio/chemical/sps30_i2c.ko@ge5.14
+	$(LINUX_DIR)/drivers/iio/chemical/sps30_i2c.ko
   AUTOLOAD:=$(call AutoProbe,sps30 sps30_i2c)
   $(call AddDepends/iio)
 endef
diff --git a/package/kernel/linux/modules/input.mk b/package/kernel/linux/modules/input.mk
index 6270cdeb3b09d..6cc72207f3ebd 100644
--- a/package/kernel/linux/modules/input.mk
+++ b/package/kernel/linux/modules/input.mk
@@ -179,10 +179,8 @@ define KernelPackage/input-touchscreen-ads7846
   DEPENDS:=+kmod-hwmon-core +kmod-input-core +kmod-spi-bitbang
   KCONFIG:= \
 	CONFIG_INPUT_TOUCHSCREEN=y \
-	CONFIG_TOUCHSCREEN_PROPERTIES=y@lt5.13 \
 	CONFIG_TOUCHSCREEN_ADS7846
-  FILES:=$(LINUX_DIR)/drivers/input/touchscreen/ads7846.ko \
-	$(LINUX_DIR)/drivers/input/touchscreen/of_touchscreen.ko@lt5.13
+  FILES:=$(LINUX_DIR)/drivers/input/touchscreen/ads7846.ko
   AUTOLOAD:=$(call AutoProbe,ads7846)
 endef
 
@@ -199,10 +197,8 @@ define KernelPackage/input-touchscreen-edt-ft5x06
   DEPENDS:=+kmod-i2c-core +kmod-input-core
   KCONFIG:= \
 	CONFIG_INPUT_TOUCHSCREEN=y \
-	CONFIG_TOUCHSCREEN_PROPERTIES=y@lt5.13 \
 	CONFIG_TOUCHSCREEN_EDT_FT5X06
-  FILES:=$(LINUX_DIR)/drivers/input/touchscreen/edt-ft5x06.ko \
-	$(LINUX_DIR)/drivers/input/touchscreen/of_touchscreen.ko@lt5.13
+  FILES:=$(LINUX_DIR)/drivers/input/touchscreen/edt-ft5x06.ko
   AUTOLOAD:=$(call AutoProbe,edt-ft5x06)
 endef
 
diff --git a/package/kernel/linux/modules/netdevices.mk b/package/kernel/linux/modules/netdevices.mk
index 208518c3bfc02..ade6438b9c9ba 100644
--- a/package/kernel/linux/modules/netdevices.mk
+++ b/package/kernel/linux/modules/netdevices.mk
@@ -1170,7 +1170,7 @@ define KernelPackage/of-mdio
   KCONFIG:=CONFIG_OF_MDIO
   FILES:= \
 	$(LINUX_DIR)/drivers/net/mdio/of_mdio.ko \
-	$(LINUX_DIR)/drivers/net/mdio/fwnode_mdio.ko@ge5.15
+	$(LINUX_DIR)/drivers/net/mdio/fwnode_mdio.ko
   AUTOLOAD:=$(call AutoLoad,41,of_mdio)
 endef
 
diff --git a/package/kernel/linux/modules/netfilter.mk b/package/kernel/linux/modules/netfilter.mk
index 1772545f25e82..99a48a37d479b 100644
--- a/package/kernel/linux/modules/netfilter.mk
+++ b/package/kernel/linux/modules/netfilter.mk
@@ -1141,7 +1141,6 @@ define KernelPackage/nft-bridge
   FILES:=$(foreach mod,$(NFT_BRIDGE-m),$(LINUX_DIR)/net/$(mod).ko)
   AUTOLOAD:=$(call AutoProbe,$(notdir $(NFT_BRIDGE-m)))
   KCONFIG:= \
-	CONFIG_NF_LOG_BRIDGE=n@lt5.13 \
 	$(KCONFIG_NFT_BRIDGE)
 endef
 
diff --git a/package/kernel/linux/modules/spi.mk b/package/kernel/linux/modules/spi.mk
index 5cdfc3b2b36b6..78a1c8a03283b 100644
--- a/package/kernel/linux/modules/spi.mk
+++ b/package/kernel/linux/modules/spi.mk
@@ -15,10 +15,9 @@ define KernelPackage/mmc-spi
           CONFIG_SPI=y \
           CONFIG_SPI_MASTER=y
   FILES:=\
-	$(if $(CONFIG_OF),$(LINUX_DIR)/drivers/mmc/host/of_mmc_spi.ko@lt5.13) \
-	$(LINUX_DIR)/drivers/mmc/host/of_mmc_spi.ko@ge5.13 \
+	$(LINUX_DIR)/drivers/mmc/host/of_mmc_spi.ko \
 	$(LINUX_DIR)/drivers/mmc/host/mmc_spi.ko
-  AUTOLOAD:=$(call AutoProbe,$(if $(CONFIG_OF),of_mmc_spi@lt5.13) of_mmc_spi@ge5.13 mmc_spi)
+  AUTOLOAD:=$(call AutoProbe,of_mmc_spi mmc_spi)
 endef
 
 define KernelPackage/mmc-spi/description
diff --git a/package/kernel/linux/modules/usb.mk b/package/kernel/linux/modules/usb.mk
index 9c2e01357acbf..5747ad21663a2 100644
--- a/package/kernel/linux/modules/usb.mk
+++ b/package/kernel/linux/modules/usb.mk
@@ -1823,9 +1823,8 @@ define KernelPackage/usb-xhci-mtk
   KCONFIG:=CONFIG_USB_XHCI_MTK
   HIDDEN:=1
   FILES:= \
-	 $(LINUX_DIR)/drivers/usb/host/xhci-mtk.ko@lt5.13 \
-	 $(LINUX_DIR)/drivers/usb/host/xhci-mtk-hcd.ko@ge5.13
-  AUTOLOAD:=$(call AutoLoad,54,xhci-mtk@lt5.13 xhci-mtk-hcd@gt5.13,1)
+	 $(LINUX_DIR)/drivers/usb/host/xhci-mtk-hcd.ko
+  AUTOLOAD:=$(call AutoLoad,54,xhci-mtk-hcd,1)
   $(call AddDepends/usb)
 endef
 
diff --git a/package/kernel/linux/modules/video.mk b/package/kernel/linux/modules/video.mk
index 83f48ac8492c5..a89ceef54b1a3 100644
--- a/package/kernel/linux/modules/video.mk
+++ b/package/kernel/linux/modules/video.mk
@@ -376,7 +376,7 @@ define KernelPackage/drm-imx-ldb
 	CONFIG_DRM_PANEL_SITRONIX_ST7789V=n
   FILES:=$(LINUX_DIR)/drivers/gpu/drm/imx/imx-ldb.ko \
 	$(LINUX_DIR)/drivers/gpu/drm/panel/panel-simple.ko \
-	$(LINUX_DIR)/drivers/gpu/drm/drm_dp_aux_bus.ko@gt5.10
+	$(LINUX_DIR)/drivers/gpu/drm/drm_dp_aux_bus.ko
   AUTOLOAD:=$(call AutoLoad,08,imx-ldb)
 endef
 
diff --git a/package/kernel/linux/modules/virt.mk b/package/kernel/linux/modules/virt.mk
index 59a2d79563dcb..85f47aacbf94f 100644
--- a/package/kernel/linux/modules/virt.mk
+++ b/package/kernel/linux/modules/virt.mk
@@ -104,7 +104,7 @@ define KernelPackage/vfio-pci
 	CONFIG_VFIO_PCI \
 	CONFIG_VFIO_PCI_IGD=y
   FILES:= \
-	$(LINUX_DIR)/drivers/vfio/pci/vfio-pci-core.ko@ge5.15 \
+	$(LINUX_DIR)/drivers/vfio/pci/vfio-pci-core.ko \
 	$(LINUX_DIR)/drivers/vfio/pci/vfio-pci.ko
   AUTOLOAD:=$(call AutoProbe,vfio-pci)
 endef