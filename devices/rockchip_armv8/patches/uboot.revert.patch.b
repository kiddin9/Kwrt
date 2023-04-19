From bb084c1d09e7b81ba4eda974ab0d7abcd6e3a114 Mon Sep 17 00:00:00 2001
From: AmadeusGhost <42570690+AmadeusGhost@users.noreply.github.com>
Date: Mon, 10 Apr 2023 23:15:08 +0800
Subject: [PATCH] uboot-rockchip: bump to v2023.04

For the python problem, just make clean.
Skip the gpio patch due to it may broken boot.
---
 package/boot/uboot-rockchip/Makefile          |   88 +-
 ...hip-rk3568-add-boot-device-detection.patch |   43 -
 ...k3568-enable-automatic-power-savings.patch |   52 -
 ...le-rockchip-HACK-build-rk3568-images.patch |   47 -
 .../004-arm-dts-sync-rk3568-with-linux.patch  | 3520 -----------------
 ...ckchip-rk356x-HACK-fix-sdmmc-support.patch |   50 -
 ...rockchip-rk356x-add-quartz64-a-board.patch |  214 -
 ...p-rk_gpio-support-v2-gpio-controller.patch |  755 ----
 ...8-rockchip-allow-sdmmc-at-full-speed.patch |   22 -
 ...ip-defconfig-add-gpio-v2-to-quartz64.patch |   25 -
 ...6x-enable-usb2-support-on-quartz64-a.patch |   97 -
 ...-rk356x-attempt-to-fix-ram-detection.patch |  173 -
 ...ync-rk3566-device-tree-with-mainline.patch | 1060 -----
 ...rockchip-rk356x-add-bpi-r2-pro-board.patch |  795 ----
 .../014-uboot-add-Radxa-ROCK-3A-board.patch   |  690 ----
 .../015-uboot-add-NanoPi-R5S-board.patch      |  132 +-
 .../016-rk356x-ddr-fix-dbw-detect-bug.patch   |   42 -
 ...7-gpio-rockchip-fix-building-for-spl.patch |   44 -
 ...lk-rockchip-rk3568-fix-reset-handler.patch |   28 -
 ...8-driver-Makefile-support-adc-in-SPL.patch |   35 +
 ...-rockchip-handle-bootrom-mode-in-spl.patch |    6 +-
 ...CONFIG_USB_OHCI_NEW-et-al-to-Kconfig.patch |  282 --
 ...104-mkimage-add-public-key-for-image.patch |  166 -
 .../105-Only-build-dtc-if-needed.patch        |  125 -
 .../patches/106-no-kwbimage.patch             |    2 +-
 .../patches/110-force-pylibfdt-build.patch    |   30 +
 .../patches/111-fix-mkimage-host-build.patch  |   24 +
 ...-clk-scmi-Add-Kconfig-option-for-SPL.patch |   72 +
 ...trl-rockchip-Fix-IO-mux-selection-on.patch |  126 +
 ...rock64pro-disable-CONFIG_USE_PREBOOT.patch |    6 +-
 ...s-rockchip-Add-GuangMiao-G4C-support.patch |    2 +-
 ...328-Add-support-for-Orangepi-R1-Plus.patch |   22 +-
 ...Add-support-for-Orangepi-R1-Plus-LTS.patch |   24 +-
 ...Add-support-for-FriendlyARM-NanoPi-R.patch |   34 +-
 ...Add-support-for-FriendlyARM-NanoPi-R.patch |    2 +-
 ...399-Add-support-for-Rongpin-king3399.patch |    2 +-
 ...399-Add-support-for-Rocktech-MPC1903.patch |    2 +-
 ...399-Add-support-for-sharevdi-h3399pc.patch |    2 +-
 ...68-Add-support-for-ezpro_mrkaio-m68s.patch |   56 +-
 ...568-Add-support-for-hinlink-opc-h68k.patch |   56 +-
 ...k3568-Add-support-for-fastrhino-r66s.patch |   54 +-
 ...ip-rk3568-Add-support-for-Station-P2.patch |   43 +-
 ...ip-rk3568-Add-support-for-photonicat.patch |   56 +-
 ...hip-rk3568-Add-support-for-radxa_e25.patch |   62 +-
 44 files changed, 589 insertions(+), 8579 deletions(-)
 delete mode 100644 package/boot/uboot-rockchip/patches/001-rockchip-rk3568-add-boot-device-detection.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/002-rockchip-rk3568-enable-automatic-power-savings.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/003-Makefile-rockchip-HACK-build-rk3568-images.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/004-arm-dts-sync-rk3568-with-linux.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/005-rockchip-rk356x-HACK-fix-sdmmc-support.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/006-rockchip-rk356x-add-quartz64-a-board.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/007-gpio-rockchip-rk_gpio-support-v2-gpio-controller.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/008-rockchip-allow-sdmmc-at-full-speed.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/009-rockchip-defconfig-add-gpio-v2-to-quartz64.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/010-rockchip-rk356x-enable-usb2-support-on-quartz64-a.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/011-rockchip-rk356x-attempt-to-fix-ram-detection.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/012-resync-rk3566-device-tree-with-mainline.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/013-rockchip-rk356x-add-bpi-r2-pro-board.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/014-uboot-add-Radxa-ROCK-3A-board.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/016-rk356x-ddr-fix-dbw-detect-bug.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/017-gpio-rockchip-fix-building-for-spl.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/018-clk-rockchip-rk3568-fix-reset-handler.patch
 create mode 100644 package/boot/uboot-rockchip/patches/018-driver-Makefile-support-adc-in-SPL.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/100-Convert-CONFIG_USB_OHCI_NEW-et-al-to-Kconfig.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/104-mkimage-add-public-key-for-image.patch
 delete mode 100644 package/boot/uboot-rockchip/patches/105-Only-build-dtc-if-needed.patch
 create mode 100644 package/boot/uboot-rockchip/patches/110-force-pylibfdt-build.patch
 create mode 100644 package/boot/uboot-rockchip/patches/111-fix-mkimage-host-build.patch
 create mode 100644 package/boot/uboot-rockchip/patches/120-clk-scmi-Add-Kconfig-option-for-SPL.patch
 create mode 100644 package/boot/uboot-rockchip/patches/121-pinctrl-rockchip-Fix-IO-mux-selection-on.patch

diff --git a/package/boot/uboot-rockchip/Makefile b/package/boot/uboot-rockchip/Makefile
index 3826317dcf0c..810a24543bf1 100644
--- a/package/boot/uboot-rockchip/Makefile
+++ b/package/boot/uboot-rockchip/Makefile
@@ -5,10 +5,10 @@
 include $(TOPDIR)/rules.mk
 include $(INCLUDE_DIR)/kernel.mk
 
-PKG_VERSION:=2022.07
+PKG_VERSION:=2023.04
 PKG_RELEASE:=$(AUTORELEASE)
 
-PKG_HASH:=92b08eb49c24da14c1adbf70a71ae8f37cc53eeb4230e859ad8b6733d13dcf5e
+PKG_HASH:=e31cac91545ff41b71cec5d8c22afd695645cd6e2a442ccdacacd60534069341
 
 PKG_MAINTAINER:=Tobias Maedel <openwrt@tbspace.de>
 
@@ -77,7 +77,7 @@ define U-Boot/guangmiao-g4c-rk3399
   NAME:=GuangMiao G4C
   BUILD_DEVICES:= \
     sharevdi_guangmiao-g4c
-  DEPENDS:=+PACKAGE_u-boot-guangmiao-g4c-rk3399:arm-trusted-firmware-rockchip
+  DEPENDS:=+PACKAGE_u-boot-guangmiao-g4c-rk3399:trusted-firmware-a-rk3399
   PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
   ATF:=rk3399_bl31.elf
 endef
@@ -109,7 +109,7 @@ define U-Boot/rock-pi-4-rk3399
   NAME:=Rock Pi 4
   BUILD_DEVICES:= \
     radxa_rock-pi-4
-  DEPENDS:=+PACKAGE_u-boot-rock-pi-4-rk3399:arm-trusted-firmware-rockchip
+  DEPENDS:=+PACKAGE_u-boot-rock-pi-4-rk3399:trusted-firmware-a-rk3399
   PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
   ATF:=rk3399_bl31.elf
 endef
@@ -119,7 +119,7 @@ define U-Boot/rockpro64-rk3399
   NAME:=RockPro64
   BUILD_DEVICES:= \
     pine64_rockpro64
-  DEPENDS:=+PACKAGE_u-boot-rockpro64-rk3399:arm-trusted-firmware-rockchip
+  DEPENDS:=+PACKAGE_u-boot-rockpro64-rk3399:trusted-firmware-a-rk3399
   PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
   ATF:=rk3399_bl31.elf
 endef
@@ -165,9 +165,9 @@ define U-Boot/mrkaio-m68s-rk3568
   BUILD_DEVICES:= \
     ezpro_mrkaio-m68s \
     ezpro_mrkaio-m68s-plus
-  DEPENDS:=+PACKAGE_u-boot-mrkaio-m68s-rk3568:arm-trusted-firmware-rk3568
-  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip-vendor
-  ATF:=rk3568_bl31_v1.34.elf
+  DEPENDS:=+PACKAGE_u-boot-mrkaio-m68s-rk3568:trusted-firmware-a-rk3568
+  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
+  ATF:=rk3568_bl31.elf
   DDR:=rk3568_ddr_1560MHz_v1.13.bin
 endef
 
@@ -177,9 +177,9 @@ define U-Boot/nanopi-r5s-rk3568
   BUILD_DEVICES:= \
     friendlyarm_nanopi-r5c \
     friendlyarm_nanopi-r5s
-  DEPENDS:=+PACKAGE_u-boot-nanopi-r5s-rk3568:arm-trusted-firmware-rk3568
-  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip-vendor
-  ATF:=rk3568_bl31_v1.34.elf
+  DEPENDS:=+PACKAGE_u-boot-nanopi-r5s-rk3568:trusted-firmware-a-rk3568
+  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
+  ATF:=rk3568_bl31.elf
   DDR:=rk3568_ddr_1560MHz_v1.13.bin
 endef
 
@@ -190,9 +190,9 @@ define U-Boot/opc-h68k-rk3568
     hinlink_opc-h66k \
     hinlink_opc-h68k \
     hinlink_opc-h69k
-  DEPENDS:=+PACKAGE_u-boot-opc-h68k-rk3568:arm-trusted-firmware-rk3568
-  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip-vendor
-  ATF:=rk3568_bl31_v1.34.elf
+  DEPENDS:=+PACKAGE_u-boot-opc-h68k-rk3568:trusted-firmware-a-rk3568
+  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
+  ATF:=rk3568_bl31.elf
   DDR:=rk3568_ddr_1560MHz_v1.13.bin
 endef
 
@@ -201,9 +201,9 @@ define U-Boot/photonicat-rk3568
   NAME:=Ariaboard Photonicat
   BUILD_DEVICES:= \
     ariaboard_photonicat
-  DEPENDS:=+PACKAGE_u-boot-photonicat-rk3568:arm-trusted-firmware-rk3568
-  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip-vendor
-  ATF:=rk3568_bl31_v1.34.elf
+  DEPENDS:=+PACKAGE_u-boot-photonicat-rk3568:trusted-firmware-a-rk3568
+  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
+  ATF:=rk3568_bl31.elf
   DDR:=rk3568_ddr_1560MHz_v1.13.bin
 endef
 
@@ -212,9 +212,9 @@ define U-Boot/radxa-e25-rk3568
   NAME:=Radxa E25
   BUILD_DEVICES:= \
     radxa_e25
-  DEPENDS:=+PACKAGE_u-boot-radxa-e25-rk3568:arm-trusted-firmware-rk3568
-  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip-vendor
-  ATF:=rk3568_bl31_v1.34.elf
+  DEPENDS:=+PACKAGE_u-boot-radxa-e25-rk3568:trusted-firmware-a-rk3568
+  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
+  ATF:=rk3568_bl31.elf
   DDR:=rk3568_ddr_1560MHz_v1.13.bin
 endef
 
@@ -223,9 +223,9 @@ define U-Boot/rock-3a-rk3568
   NAME:=ROCK3 Model A
   BUILD_DEVICES:= \
     radxa_rock-3a
-  DEPENDS:=+PACKAGE_u-boot-rock-3a-rk3568:arm-trusted-firmware-rk3568
-  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip-vendor
-  ATF:=rk3568_bl31_v1.34.elf
+  DEPENDS:=+PACKAGE_u-boot-rock-3a-rk3568:trusted-firmware-a-rk3568
+  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
+  ATF:=rk3568_bl31.elf
   DDR:=rk3568_ddr_1560MHz_v1.13.bin
 endef
 
@@ -235,9 +235,9 @@ define U-Boot/r66s-rk3568
   BUILD_DEVICES:= \
     fastrhino_r66s \
     fastrhino_r68s
-  DEPENDS:=+PACKAGE_u-boot-r66s-rk3568:arm-trusted-firmware-rk3568
-  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip-vendor
-  ATF:=rk3568_bl31_v1.34.elf
+  DEPENDS:=+PACKAGE_u-boot-r66s-rk3568:trusted-firmware-a-rk3568
+  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
+  ATF:=rk3568_bl31.elf
   DDR:=rk3568_ddr_1560MHz_v1.13.bin
 endef
 
@@ -246,9 +246,9 @@ define U-Boot/station-p2-rk3568
   NAME:=StationP2
   BUILD_DEVICES:= \
        firefly_station-p2
-  DEPENDS:=+PACKAGE_u-boot-station-p2-rk3568:arm-trusted-firmware-rk3568
-  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip-vendor
-  ATF:=rk3568_bl31_v1.34.elf
+  DEPENDS:=+PACKAGE_u-boot-station-p2-rk3568:trusted-firmware-a-rk3568
+  PKG_BUILD_DEPENDS:=arm-trusted-firmware-rockchip
+  ATF:=rk3568_bl31.elf
   DDR:=rk3568_ddr_1560MHz_v1.13.bin
 endef
 
@@ -279,15 +279,39 @@ UBOOT_CONFIGURE_VARS += USE_PRIVATE_LIBGCC=yes
 UBOOT_MAKE_FLAGS += \
   BL31=$(STAGING_DIR_IMAGE)/$(ATF)
 
+ifeq ($(CONFIG_PACKAGE_trusted-firmware-a-rk3568),y)
+UBOOT_MAKE_FLAGS += \
+  ROCKCHIP_TPL=$(PKG_BUILD_DIR)/$(DDR)
+endif
+
+RKBIN_URL:=https://raw.githubusercontent.com/rockchip-linux/rkbin/b0c100f1a260d807df450019774993c761beb79d
+
+define Download/rk3566-ddr
+  FILE:=rk3566_ddr_1056MHz_v1.13.bin
+  URL:=$(RKBIN_URL)/bin/rk35/
+  HASH:=6f165b37640eb876b5f41297bcce6451eb8a86fa56649633d4aca76047136a36
+endef
+$(eval $(call Download,rk3566-ddr))
+
+define Download/rk3568-ddr
+  FILE:=rk3568_ddr_1560MHz_v1.13.bin
+  URL:=$(RKBIN_URL)/bin/rk35/
+  HASH:=53d5e893916e647ccb8c5a2a51f749e9e11bf7329e61a2f94d8c089a333d7812
+endef
+$(eval $(call Download,rk3568-ddr))
+
+define Build/Prepare
+	$(call Build/Prepare/Default)
+	$(CP) $(DL_DIR)/rk3566_ddr_1056MHz_v1.13.bin $(PKG_BUILD_DIR)/
+	$(CP) $(DL_DIR)/rk3568_ddr_1560MHz_v1.13.bin $(PKG_BUILD_DIR)/
+endef
+
 define Build/Configure
 	$(call Build/Configure/U-Boot)
 
 	$(SED) 's/CONFIG_TOOLS_LIBCRYPTO=y/# CONFIG_TOOLS_LIBCRYPTO is not set/' $(PKG_BUILD_DIR)/.config
 	$(SED) 's#CONFIG_MKIMAGE_DTC_PATH=.*#CONFIG_MKIMAGE_DTC_PATH="$(PKG_BUILD_DIR)/scripts/dtc/dtc"#g' $(PKG_BUILD_DIR)/.config
 	echo 'CONFIG_IDENT_STRING=" OpenWrt"' >> $(PKG_BUILD_DIR)/.config
-ifneq ($(DDR),)
-	$(CP) $(STAGING_DIR_IMAGE)/$(DDR) $(PKG_BUILD_DIR)/ram_init.bin
-endif
 endef
 
 define Build/InstallDev
diff --git a/package/boot/uboot-rockchip/patches/001-rockchip-rk3568-add-boot-device-detection.patch b/package/boot/uboot-rockchip/patches/001-rockchip-rk3568-add-boot-device-detection.patch
deleted file mode 100644
index b3dd30996f55..000000000000
--- a/package/boot/uboot-rockchip/patches/001-rockchip-rk3568-add-boot-device-detection.patch
+++ /dev/null
@@ -1,43 +0,0 @@
-From 9b92a43a4f5acf4cba14fd9d473b3120688532dc Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Sun, 19 Dec 2021 08:10:24 -0500
-Subject: [PATCH 01/11] rockchip: rk3568: add boot device detection
-
-Enable spl to detect which device it was booted from.
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/mach-rockchip/rk3568/rk3568.c | 8 ++++++++
- 1 file changed, 8 insertions(+)
-
---- a/arch/arm/mach-rockchip/rk3568/rk3568.c
-+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
-@@ -7,6 +7,7 @@
- #include <dm.h>
- #include <asm/armv8/mmu.h>
- #include <asm/io.h>
-+#include <asm/arch-rockchip/bootrom.h>
- #include <asm/arch-rockchip/grf_rk3568.h>
- #include <asm/arch-rockchip/hardware.h>
- #include <dt-bindings/clock/rk3568-cru.h>
-@@ -23,6 +24,7 @@
- #define SGRF_SOC_CON4			0x10
- #define EMMC_HPROT_SECURE_CTRL		0x03
- #define SDMMC0_HPROT_SECURE_CTRL	0x01
-+
- /* PMU_GRF_GPIO0D_IOMUX_L */
- enum {
- 	GPIO0D1_SHIFT		= 4,
-@@ -43,6 +45,12 @@ enum {
- 	UART2_IO_SEL_M0		= 0,
- };
- 
-+const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
-+	[BROM_BOOTSOURCE_EMMC] = "/sdhci@fe310000",
-+	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe300000/flash@0",
-+	[BROM_BOOTSOURCE_SD] = "/mmc@fe2b0000",
-+};
-+
- static struct mm_region rk3568_mem_map[] = {
- 	{
- 		.virt = 0x0UL,
diff --git a/package/boot/uboot-rockchip/patches/002-rockchip-rk3568-enable-automatic-power-savings.patch b/package/boot/uboot-rockchip/patches/002-rockchip-rk3568-enable-automatic-power-savings.patch
deleted file mode 100644
index f38d9f4df934..000000000000
--- a/package/boot/uboot-rockchip/patches/002-rockchip-rk3568-enable-automatic-power-savings.patch
+++ /dev/null
@@ -1,52 +0,0 @@
-From 09d877cf076cbb67c79054e12bbb7c63a91faa71 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Sun, 19 Dec 2021 08:11:56 -0500
-Subject: [PATCH 02/11] rockchip: rk3568: enable automatic power savings
-
-Enable automatic clock gating, solves the 7c temperature difference on
-SoQuartz.
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/mach-rockchip/rk3568/rk3568.c | 23 +++++++++++++++++++++++
- 1 file changed, 23 insertions(+)
-
---- a/arch/arm/mach-rockchip/rk3568/rk3568.c
-+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
-@@ -25,6 +25,15 @@
- #define EMMC_HPROT_SECURE_CTRL		0x03
- #define SDMMC0_HPROT_SECURE_CTRL	0x01
- 
-+#define PMU_BASE_ADDR		0xfdd90000
-+#define PMU_NOC_AUTO_CON0	(0x70)
-+#define PMU_NOC_AUTO_CON1	(0x74)
-+#define EDP_PHY_GRF_BASE	0xfdcb0000
-+#define EDP_PHY_GRF_CON0	(EDP_PHY_GRF_BASE + 0x00)
-+#define EDP_PHY_GRF_CON10	(EDP_PHY_GRF_BASE + 0x28)
-+#define CPU_GRF_BASE		0xfdc30000
-+#define GRF_CORE_PVTPLL_CON0	(0x10)
-+
- /* PMU_GRF_GPIO0D_IOMUX_L */
- enum {
- 	GPIO0D1_SHIFT		= 4,
-@@ -99,6 +108,20 @@ void board_debug_uart_init(void)
- int arch_cpu_init(void)
- {
- #ifdef CONFIG_SPL_BUILD
-+	/*
-+	 * When perform idle operation, corresponding clock can
-+	 * be opened or gated automatically.
-+	 */
-+	writel(0xffffffff, PMU_BASE_ADDR + PMU_NOC_AUTO_CON0);
-+	writel(0x000f000f, PMU_BASE_ADDR + PMU_NOC_AUTO_CON1);
-+
-+	/* Disable eDP phy by default */
-+	writel(0x00070007, EDP_PHY_GRF_CON10);
-+	writel(0x0ff10ff1, EDP_PHY_GRF_CON0);
-+
-+	/* Set core pvtpll ring length */
-+	writel(0x00ff002b, CPU_GRF_BASE + GRF_CORE_PVTPLL_CON0);
-+
- 	/* Set the emmc sdmmc0 to secure */
- 	rk_clrreg(SGRF_BASE + SGRF_SOC_CON4, (EMMC_HPROT_SECURE_CTRL << 11
- 		| SDMMC0_HPROT_SECURE_CTRL << 4));
diff --git a/package/boot/uboot-rockchip/patches/003-Makefile-rockchip-HACK-build-rk3568-images.patch b/package/boot/uboot-rockchip/patches/003-Makefile-rockchip-HACK-build-rk3568-images.patch
deleted file mode 100644
index 5a8173016314..000000000000
--- a/package/boot/uboot-rockchip/patches/003-Makefile-rockchip-HACK-build-rk3568-images.patch
+++ /dev/null
@@ -1,47 +0,0 @@
-From ddbcec939789d1f7264134b3628ffb649ec88168 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Sun, 19 Dec 2021 08:20:33 -0500
-Subject: [PATCH 03/11] Makefile: rockchip: HACK: build rk3568 images
-
-This is a hack to build rk3568 images.
-It seems makefile can't cope with the format mkimage expects for
-multiple file entries, so hack around the situation.
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- Makefile | 10 ++++++++++
- 1 file changed, 10 insertions(+)
-
---- a/Makefile
-+++ b/Makefile
-@@ -1047,6 +1047,9 @@ quiet_cmd_mkimage = MKIMAGE $@
- cmd_mkimage = $(objtree)/tools/mkimage $(MKIMAGEFLAGS_$(@F)) -d $< $@ \
- 	>$(MKIMAGEOUTPUT) $(if $(KBUILD_VERBOSE:0=), && cat $(MKIMAGEOUTPUT))
- 
-+cmd_mkimage_combined = $(objtree)/tools/mkimage $(MKIMAGEFLAGS_$(@F)) -d $(COMBINED_FILE):$< $@ \
-+	>$(MKIMAGEOUTPUT) $(if $(KBUILD_VERBOSE:0=), && cat $(MKIMAGEOUTPUT))
-+
- quiet_cmd_mkfitimage = MKIMAGE $@
- cmd_mkfitimage = $(objtree)/tools/mkimage $(MKIMAGEFLAGS_$(@F)) \
- 	-f $(U_BOOT_ITS) -p $(CONFIG_FIT_EXTERNAL_OFFSET) $@ \
-@@ -1491,6 +1494,7 @@ u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_
- ifeq ($(CONFIG_ARCH_ROCKCHIP),y)
- 
- # TPL + SPL
-+ifneq ($(CONFIG_SYS_SOC),$(filter $(CONFIG_SYS_SOC),"rk3568" "rk3566"))
- ifeq ($(CONFIG_SPL)$(CONFIG_TPL),yy)
- MKIMAGEFLAGS_u-boot-tpl-rockchip.bin = -n $(CONFIG_SYS_SOC) -T rksd
- tpl/u-boot-tpl-rockchip.bin: tpl/u-boot-tpl.bin FORCE
-@@ -1502,6 +1506,12 @@ MKIMAGEFLAGS_idbloader.img = -n $(CONFIG
- idbloader.img: spl/u-boot-spl.bin FORCE
- 	$(call if_changed,mkimage)
- endif
-+else
-+MKIMAGEFLAGS_idbloader.img = -n $(CONFIG_SYS_SOC) -T rksd
-+COMBINED_FILE = ram_init.bin
-+idbloader.img: spl/u-boot-spl.bin FORCE
-+	$(call if_changed,mkimage_combined)
-+endif
- 
- ifeq ($(CONFIG_ARM64),y)
- OBJCOPYFLAGS_u-boot-rockchip.bin = -I binary -O binary \
diff --git a/package/boot/uboot-rockchip/patches/004-arm-dts-sync-rk3568-with-linux.patch b/package/boot/uboot-rockchip/patches/004-arm-dts-sync-rk3568-with-linux.patch
deleted file mode 100644
index 422f1c4d378f..000000000000
--- a/package/boot/uboot-rockchip/patches/004-arm-dts-sync-rk3568-with-linux.patch
+++ /dev/null
@@ -1,3520 +0,0 @@
-From 25624318957d560ce58be672fe2fa8537716afc7 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Sun, 19 Dec 2021 15:14:47 -0500
-Subject: [PATCH 04/11] arm: dts: sync rk3568 with linux
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/dts/Makefile                      |    3 +-
- arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi |   24 +
- arch/arm/dts/rk3566-quartz64-a.dts         |  860 +++++++++++
- arch/arm/dts/rk3566.dtsi                   |   32 +
- arch/arm/dts/rk3568-evb.dts                |    5 +
- arch/arm/dts/rk3568-pinctrl.dtsi           |    9 +
- arch/arm/dts/rk3568.dtsi                   |  860 ++---------
- arch/arm/dts/rk356x.dtsi                   | 1630 ++++++++++++++++++++
- arch/arm/mach-rockchip/rk3568/rk3568.c     |    2 +-
- 9 files changed, 2672 insertions(+), 753 deletions(-)
- create mode 100644 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
- create mode 100644 arch/arm/dts/rk3566-quartz64-a.dts
- create mode 100644 arch/arm/dts/rk3566.dtsi
- create mode 100644 arch/arm/dts/rk356x.dtsi
-
---- a/arch/arm/dts/Makefile
-+++ b/arch/arm/dts/Makefile
-@@ -164,7 +164,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3399) += \
- 	rk3399pro-rock-pi-n10.dtb
- 
- dtb-$(CONFIG_ROCKCHIP_RK3568) += \
--	rk3568-evb.dtb
-+	rk3568-evb.dtb \
-+	rk3566-quartz64-a.dtb
- 
- dtb-$(CONFIG_ROCKCHIP_RV1108) += \
- 	rv1108-elgin-r1.dtb \
---- /dev/null
-+++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
-@@ -0,0 +1,24 @@
-+// SPDX-License-Identifier: GPL-2.0+
-+/*
-+ * (C) Copyright 2021 Rockchip Electronics Co., Ltd
-+ */
-+
-+#include "rk3568-u-boot.dtsi"
-+
-+/ {
-+	chosen {
-+		stdout-path = &uart2;
-+		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;
-+	};
-+};
-+
-+&sdmmc0 {
-+	u-boot,dm-spl;
-+	status = "okay";
-+};
-+
-+&uart2 {
-+	clock-frequency = <24000000>;
-+	u-boot,dm-spl;
-+	status = "okay";
-+};
---- /dev/null
-+++ b/arch/arm/dts/rk3566-quartz64-a.dts
-@@ -0,0 +1,860 @@
-+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-+
-+/dts-v1/;
-+
-+#include <dt-bindings/gpio/gpio.h>
-+#include <dt-bindings/pinctrl/rockchip.h>
-+#include "rk3566.dtsi"
-+
-+/ {
-+	model = "Pine64 RK3566 Quartz64-A Board";
-+	compatible = "pine64,quartz64-a", "rockchip,rk3566";
-+
-+	aliases {
-+		ethernet0 = &gmac1;
-+		mmc0 = &sdmmc0;
-+		mmc1 = &sdhci;
-+	};
-+
-+	chosen: chosen {
-+		stdout-path = "serial2:1500000n8";
-+	};
-+
-+	battery_cell: battery-cell {
-+		compatible = "simple-battery";
-+		charge-full-design-microamp-hours = <2500000>;
-+		charge-term-current-microamp = <300000>;
-+		constant-charge-current-max-microamp = <2000000>;
-+		constant-charge-voltage-max-microvolt = <4200000>;
-+		factory-internal-resistance-micro-ohms = <180000>;
-+		voltage-max-design-microvolt = <4106000>;
-+		voltage-min-design-microvolt = <3625000>;
-+
-+		ocv-capacity-celsius = <20>;
-+		ocv-capacity-table-0 =	<4106000 100>, <4071000 95>, <4018000 90>, <3975000 85>,
-+					<3946000 80>, <3908000 75>, <3877000 70>, <3853000 65>,
-+					<3834000 60>, <3816000 55>, <3802000 50>, <3788000 45>,
-+					<3774000 40>, <3760000 35>, <3748000 30>, <3735000 25>,
-+					<3718000 20>, <3697000 15>, <3685000 10>, <3625000 0>;
-+	};
-+
-+	gmac1_clkin: external-gmac1-clock {
-+		compatible = "fixed-clock";
-+		clock-frequency = <125000000>;
-+		clock-output-names = "gmac1_clkin";
-+		#clock-cells = <0>;
-+	};
-+
-+	fan: gpio_fan {
-+		compatible = "gpio-fan";
-+		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
-+		gpio-fan,speed-map = <0    0
-+				      4500 1>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&fan_en_h>;
-+		#cooling-cells = <2>;
-+	};
-+
-+	leds {
-+		compatible = "gpio-leds";
-+
-+		led-work {
-+			label = "work-led";
-+			default-state = "off";
-+			gpios = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
-+			pinctrl-names = "default";
-+			pinctrl-0 = <&work_led_enable_h>;
-+			retain-state-suspended;
-+		};
-+
-+		led-diy {
-+			label = "diy-led";
-+			default-state = "on";
-+			gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
-+			linux,default-trigger = "heartbeat";
-+			pinctrl-names = "default";
-+			pinctrl-0 = <&diy_led_enable_h>;
-+			retain-state-suspended;
-+		};
-+	};
-+
-+	rk817-sound {
-+		compatible = "simple-audio-card";
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&hp_det_h>;
-+		simple-audio-card,format = "i2s";
-+		simple-audio-card,hp-det-gpio = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
-+		simple-audio-card,name = "Analog RK817";
-+		simple-audio-card,mclk-fs = <256>;
-+		simple-audio-card,widgets =
-+			"Microphone", "Mic Jack",
-+			"Headphone", "Headphones",
-+			"Speaker", "Speaker";
-+		simple-audio-card,routing =
-+			"MICL", "Mic Jack",
-+			"Headphones", "HPOL",
-+			"Headphones", "HPOR",
-+			"Speaker", "SPKO";
-+
-+		simple-audio-card,cpu {
-+			sound-dai = <&i2s1_8ch>;
-+		};
-+
-+		simple-audio-card,codec {
-+			sound-dai = <&rk817>;
-+		};
-+	};
-+
-+	spdif_dit: spdif-dit {
-+		compatible = "linux,spdif-dit";
-+		#sound-dai-cells = <0>;
-+	};
-+
-+	spdif_sound: spdif-sound {
-+		compatible = "simple-audio-card";
-+		simple-audio-card,name = "SPDIF";
-+
-+		simple-audio-card,cpu {
-+			sound-dai = <&spdif>;
-+		};
-+
-+		simple-audio-card,codec {
-+			sound-dai = <&spdif_dit>;
-+		};
-+	};
-+
-+	sdio_pwrseq: sdio-pwrseq {
-+		status = "okay";
-+		compatible = "mmc-pwrseq-simple";
-+		clocks = <&rk817 1>;
-+		clock-names = "ext_clock";
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&wifi_enable_h>;
-+		reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
-+		post-power-on-delay-ms = <100>;
-+		power-off-delay-us = <5000000>;
-+	};
-+
-+	spdif_sound: spdif-sound {
-+		compatible = "simple-audio-card";
-+		simple-audio-card,name = "SPDIF";
-+
-+		simple-audio-card,cpu {
-+			sound-dai = <&spdif>;
-+		};
-+
-+		simple-audio-card,codec {
-+			sound-dai = <&spdif_dit>;
-+		};
-+	};
-+
-+	spdif_dit: spdif-dit {
-+		compatible = "linux,spdif-dit";
-+		#sound-dai-cells = <0>;
-+	};
-+
-+	vcc12v_dcin: vcc12v_dcin {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc12v_dcin";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <12000000>;
-+		regulator-max-microvolt = <12000000>;
-+	};
-+
-+	/* vbus feeds the rk817 usb input.
-+	 * With no battery attached, also feeds vcc_bat+
-+	 * via ON/OFF_BAT jumper
-+	 */
-+	vbus: vbus {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vbus";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&vcc12v_dcin>;
-+	};
-+
-+	vcc5v0_usb: vcc5v0_usb {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc5v0_usb";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&vcc12v_dcin>;
-+	};
-+
-+	/* all four ports are controlled by one gpio
-+	 * the host ports are sourced from vcc5v0_usb
-+	 * the otg port is sourced from vcc5v0_midu
-+	 */
-+	vcc5v0_usb20_host: vcc5v0_usb20_host {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc5v0_usb20_host";
-+		enable-active-high;
-+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&vcc5v0_usb20_host_en_h>;
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&vcc5v0_usb>;
-+	};
-+
-+	vcc5v0_usb20_otg: vcc5v0_usb20_otg {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc5v0_usb20_otg";
-+		enable-active-high;
-+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&dcdc_boost>;
-+	};
-+
-+	vcc3v3_pcie_p: vcc3v3_pcie_p {
-+		compatible = "regulator-fixed";
-+		enable-active-high;
-+		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&pcie_enable_h>;
-+		regulator-name = "vcc3v3_pcie_p";
-+		regulator-min-microvolt = <3300000>;
-+		regulator-max-microvolt = <3300000>;
-+		vin-supply = <&vcc_3v3>;
-+	};
-+
-+	vcc3v3_sd: vcc3v3_sd {
-+		compatible = "regulator-fixed";
-+		enable-active-low;
-+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&vcc_sd_h>;
-+		regulator-boot-on;
-+		regulator-name = "vcc3v3_sd";
-+		regulator-min-microvolt = <3300000>;
-+		regulator-max-microvolt = <3300000>;
-+		vin-supply = <&vcc_3v3>;
-+	};
-+
-+	/* sourced from vbus and vcc_bat+ via rk817 sw5 */
-+	vcc_sys: vcc_sys {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc_sys";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <4400000>;
-+		regulator-max-microvolt = <4400000>;
-+		vin-supply = <&vbus>;
-+	};
-+
-+	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
-+	vcc_wl: vcc_wl {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc_wl";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <3300000>;
-+		regulator-max-microvolt = <3300000>;
-+		vin-supply = <&vcc_sys>;
-+	};
-+};
-+
-+&combphy1_usq {
-+	status = "okay";
-+	rockchip,enable-ssc;
-+};
-+
-+&combphy2_psq {
-+	status = "okay";
-+};
-+
-+&cpu0 {
-+	cpu-supply = <&vdd_cpu>;
-+};
-+
-+&cpu1 {
-+	cpu-supply = <&vdd_cpu>;
-+};
-+
-+&cpu2 {
-+	cpu-supply = <&vdd_cpu>;
-+};
-+
-+&cpu3 {
-+	cpu-supply = <&vdd_cpu>;
-+};
-+
-+&cpu_thermal {
-+	trips {
-+		cpu_hot: cpu_hot {
-+			temperature = <55000>;
-+			hysteresis = <2000>;
-+			type = "active";
-+		};
-+	};
-+
-+	cooling-maps {
-+		map1 {
-+			trip = <&cpu_hot>;
-+			cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-+		};
-+	};
-+};
-+
-+&gmac1 {
-+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>;
-+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>, <&gmac1_clkin>;
-+	clock_in_out = "input";
-+	phy-supply = <&vcc_3v3>;
-+	phy-mode = "rgmii";
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&gmac1m0_miim
-+		     &gmac1m0_tx_bus2
-+		     &gmac1m0_rx_bus2
-+		     &gmac1m0_rgmii_clk
-+		     &gmac1m0_clkinout
-+		     &gmac1m0_rgmii_bus>;
-+	snps,reset-gpio = <&gpio0 RK_PC3 GPIO_ACTIVE_LOW>;
-+	snps,reset-active-low;
-+	/* Reset time is 20ms, 100ms for rtl8211f */
-+	snps,reset-delays-us = <0 20000 100000>;
-+	tx_delay = <0x30>;
-+	rx_delay = <0x10>;
-+	phy-handle = <&rgmii_phy1>;
-+	status = "okay";
-+};
-+
-+&hdmi {
-+	status = "okay";
-+	avdd-0v9-supply = <&vdda_0v9>;
-+	avdd-1v8-supply = <&vcc_1v8>;
-+};
-+
-+&hdmi_in_vp0 {
-+	status = "okay";
-+};
-+
-+&gpu {
-+	mali-supply = <&vdd_gpu>;
-+	status = "okay";
-+};
-+
-+&i2c0 {
-+	status = "okay";
-+
-+	vdd_cpu: regulator@1c {
-+		compatible = "tcs,tcs4525";
-+		reg = <0x1c>;
-+		fcs,suspend-voltage-selector = <1>;
-+		regulator-name = "vdd_cpu";
-+		regulator-min-microvolt = <800000>;
-+		regulator-max-microvolt = <1150000>;
-+		regulator-ramp-delay = <2300>;
-+		regulator-always-on;
-+		regulator-boot-on;
-+		vin-supply = <&vcc_sys>;
-+
-+		regulator-state-mem {
-+			regulator-off-in-suspend;
-+		};
-+	};
-+
-+	rk817: pmic@20 {
-+		compatible = "rockchip,rk817";
-+		reg = <0x20>;
-+		interrupt-parent = <&gpio0>;
-+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
-+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
-+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
-+		clock-names = "mclk";
-+		clocks = <&cru I2S1_MCLKOUT_TX>;
-+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
-+		#clock-cells = <1>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
-+		rockchip,system-power-controller;
-+		#sound-dai-cells = <0>;
-+		wakeup-source;
-+
-+		vcc1-supply = <&vcc_sys>;
-+		vcc2-supply = <&vcc_sys>;
-+		vcc3-supply = <&vcc_sys>;
-+		vcc4-supply = <&vcc_sys>;
-+		vcc5-supply = <&vcc_sys>;
-+		vcc6-supply = <&vcc_sys>;
-+		vcc7-supply = <&vcc_sys>;
-+		vcc8-supply = <&vcc_sys>;
-+		vcc9-supply = <&dcdc_boost>;
-+
-+		regulators {
-+			vdd_logic: DCDC_REG1 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <500000>;
-+				regulator-max-microvolt = <1350000>;
-+				regulator-init-microvolt = <900000>;
-+				regulator-ramp-delay = <6001>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-name = "vdd_logic";
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <900000>;
-+				};
-+			};
-+
-+			vdd_gpu: DCDC_REG2 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <500000>;
-+				regulator-max-microvolt = <1350000>;
-+				regulator-init-microvolt = <900000>;
-+				regulator-ramp-delay = <6001>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-name = "vdd_gpu";
-+					regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc_ddr: DCDC_REG3 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1100000>;
-+				regulator-max-microvolt = <1100000>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-name = "vcc_ddr";
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+				};
-+			};
-+
-+			vcc_3v3: DCDC_REG4 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <3300000>;
-+				regulator-max-microvolt = <3300000>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-name = "vcc_3v3";
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcca1v8_pmu: LDO_REG1 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+				regulator-name = "vcca1v8_pmu";
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <1800000>;
-+				};
-+			};
-+
-+			vdda_0v9: LDO_REG2 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <900000>;
-+				regulator-max-microvolt = <900000>;
-+				regulator-name = "vdda_0v9";
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vdda0v9_pmu: LDO_REG3 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <900000>;
-+				regulator-max-microvolt = <900000>;
-+				regulator-name = "vdda0v9_pmu";
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <900000>;
-+				};
-+			};
-+
-+			vccio_acodec: LDO_REG4 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <3300000>;
-+				regulator-max-microvolt = <3300000>;
-+				regulator-name = "vccio_acodec";
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vccio_sd: LDO_REG5 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <3300000>;
-+				regulator-name = "vccio_sd";
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc3v3_pmu: LDO_REG6 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <3300000>;
-+				regulator-max-microvolt = <3300000>;
-+				regulator-name = "vcc3v3_pmu";
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <3300000>;
-+				};
-+			};
-+
-+			vcc_1v8: LDO_REG7 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+				regulator-name = "vcc_1v8";
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc1v8_dvp: LDO_REG8 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+				regulator-name = "vcc1v8_dvp";
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc2v8_dvp: LDO_REG9 {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <2800000>;
-+				regulator-max-microvolt = <2800000>;
-+				regulator-name = "vcc2v8_dvp";
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			dcdc_boost: BOOST {
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <5000000>;
-+				regulator-max-microvolt = <5000000>;
-+				regulator-name = "boost";
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			otg_switch: OTG_SWITCH {
-+				regulator-name = "otg_switch";
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+		};
-+
-+		rk817_battery: battery {
-+			monitored-battery = <&battery_cell>;
-+			rockchip,resistor-sense-micro-ohms = <10000>;
-+			rockchip,sleep-enter-current-microamp = <300000>;
-+			rockchip,sleep-filter-current-microamp = <100000>;
-+		};
-+	};
-+};
-+
-+&i2s1_8ch {
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&i2s1m0_sclktx
-+		     &i2s1m0_lrcktx
-+		     &i2s1m0_sdi0
-+		     &i2s1m0_sdo0>;
-+	rockchip,trcm-sync-tx-only;
-+	status = "okay";
-+};
-+
-+&mdio1 {
-+	rgmii_phy1: ethernet-phy@0 {
-+		compatible = "ethernet-phy-ieee802.3-c22";
-+		reg = <0>;
-+	};
-+};
-+
-+&pcie2x1 {
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&pcie_reset_h>;
-+	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
-+	status = "okay";
-+	vpcie3v3-supply = <&vcc3v3_pcie_p>;
-+};
-+
-+&pinctrl {
-+	bt {
-+		bt_enable_h: bt-enable-h {
-+			rockchip,pins = <2 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+
-+		bt_host_wake_l: bt-host-wake-l {
-+			rockchip,pins = <2 RK_PC0 RK_FUNC_GPIO &pcfg_pull_down>;
-+		};
-+
-+		bt_wake_l: bt-wake-l {
-+			rockchip,pins = <2 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	fan {
-+		fan_en_h: fan-en-h {
-+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	leds {
-+		work_led_enable_h: work-led-enable-h {
-+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+
-+		diy_led_enable_h: diy-led-enable-h {
-+			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	pcie {
-+		pcie_enable_h: pcie-enable-h {
-+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+
-+		pcie_reset_h: pcie-reset-h {
-+			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	pmic {
-+		pmic_int_l: pmic-int-l {
-+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
-+		};
-+
-+		hp_det_h: hp-det-h {
-+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	sdio-pwrseq {
-+		wifi_enable_h: wifi-enable-h {
-+			rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	usb2 {
-+		vcc5v0_usb20_host_en_h: vcc5v0-usb20-host-en_h {
-+			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	vcc_sd {
-+		vcc_sd_h: vcc-sd-h {
-+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+};
-+
-+&pmu_io_domains {
-+	status = "okay";
-+	pmuio1-supply = <&vcc3v3_pmu>;
-+	pmuio2-supply = <&vcc3v3_pmu>;
-+	vccio1-supply = <&vccio_acodec>;
-+	vccio2-supply = <&vcc_1v8>;
-+	vccio3-supply = <&vccio_sd>;
-+	vccio4-supply = <&vcc_1v8>;
-+	vccio5-supply = <&vcc_3v3>;
-+	vccio6-supply = <&vcc1v8_dvp>;
-+	vccio7-supply = <&vcc_3v3>;
-+};
-+
-+/* sata1 is muxed with the usb3 port */
-+&sata1 {
-+	status = "okay";
-+};
-+
-+/* sata2 is muxed with the pcie2 slot*/
-+&sata2 {
-+	status = "disabled";
-+};
-+
-+&sdhci {
-+	bus-width = <8>;
-+	mmc-hs200-1_8v;
-+	non-removable;
-+	vmmc-supply = <&vcc_3v3>;
-+	vqmmc-supply = <&vcc_1v8>;
-+	status = "okay";
-+};
-+
-+&sdmmc0 {
-+	bus-width = <4>;
-+	cap-sd-highspeed;
-+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
-+	disable-wp;
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
-+	sd-uhs-sdr104;
-+	vmmc-supply = <&vcc3v3_sd>;
-+	vqmmc-supply = <&vccio_sd>;
-+	status = "okay";
-+};
-+
-+&spdif {
-+	status = "okay";
-+};
-+
-+&sdmmc1 {
-+	bus-width = <4>;
-+	cap-sd-highspeed;
-+	cap-sdio-irq;
-+	disable-wp;
-+	keep-power-in-suspend;
-+	mmc-pwrseq = <&sdio_pwrseq>;
-+	non-removable;
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
-+	sd-uhs-sdr104;
-+	vmmc-supply = <&vcc_wl>;
-+	vqmmc-supply = <&vcc_1v8>;
-+	status = "okay";
-+};
-+
-+&sfc {
-+	#address-cells = <1>;
-+	#size-cells = <0>;
-+	status = "disabled";
-+
-+	flash@0 {
-+		compatible = "jedec,spi-nor";
-+		reg = <0>;
-+		spi-max-frequency = <108000000>;
-+		spi-rx-bus-width = <4>;
-+		spi-tx-bus-width = <1>;
-+	};
-+};
-+
-+&tsadc {
-+	/* tshut mode 0:CRU 1:GPIO */
-+	rockchip,hw-tshut-mode = <1>;
-+	/* tshut polarity 0:LOW 1:HIGH */
-+	rockchip,hw-tshut-polarity = <0>;
-+	status = "okay";
-+};
-+
-+&uart0 {
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&uart0_xfer>;
-+	status = "okay";
-+};
-+
-+&uart1 {
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn>;
-+	status = "okay";
-+	uart-has-rtscts;
-+
-+	bluetooth {
-+		compatible = "brcm,bcm43438-bt";
-+		clocks = <&rk817 1>;
-+		clock-names = "lpo";
-+		device-wake-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
-+		host-wake-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
-+		shutdown-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
-+		vbat-supply = <&vcc_sys>;
-+		vddio-supply = <&vcca1v8_pmu>;
-+	};
-+};
-+
-+&uart2 {
-+	status = "okay";
-+};
-+
-+&u2phy0_host {
-+	phy-supply = <&vcc5v0_usb20_host>;
-+	status = "okay";
-+};
-+
-+&u2phy0_otg {
-+	phy-supply = <&vcc5v0_usb20_otg>;
-+	status = "okay";
-+};
-+
-+&u2phy1_host {
-+	phy-supply = <&vcc5v0_usb20_host>;
-+	status = "okay";
-+};
-+
-+&u2phy1_otg {
-+	phy-supply = <&vcc5v0_usb20_host>;
-+	status = "okay";
-+};
-+
-+&usb2phy0 {
-+	status = "okay";
-+};
-+
-+&usb2phy1 {
-+	status = "okay";
-+};
-+
-+&usbdrd_dwc3 {
-+	status = "okay";
-+};
-+
-+&usbdrd30 {
-+	status = "okay";
-+};
-+
-+/* usb3 controller is muxed with sata1 */
-+&usbhost_dwc3 {
-+	status = "disabled";
-+};
-+
-+/* usb3 controller is muxed with sata1 */
-+&usbhost30 {
-+	status = "disabled";
-+};
-+
-+&usb_host0_ehci {
-+	status = "okay";
-+};
-+
-+&usb_host0_ohci {
-+	status = "okay";
-+};
-+
-+&usb_host1_ehci {
-+	status = "okay";
-+};
-+
-+&usb_host1_ohci {
-+	status = "okay";
-+};
-+
-+&vop {
-+	status = "okay";
-+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
-+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
-+};
-+
-+&vop_mmu {
-+	status = "okay";
-+};
-+
-+&vp0_out_hdmi {
-+	status = "okay";
-+};
---- /dev/null
-+++ b/arch/arm/dts/rk3566.dtsi
-@@ -0,0 +1,32 @@
-+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-+
-+#include "rk356x.dtsi"
-+
-+/ {
-+	compatible = "rockchip,rk3566";
-+};
-+
-+&pipegrf {
-+	compatible = "rockchip,rk3566-pipegrf", "syscon";
-+};
-+
-+&power {
-+	power-domain@RK3568_PD_PIPE {
-+		reg = <RK3568_PD_PIPE>;
-+		clocks = <&cru PCLK_PIPE>;
-+		pm_qos = <&qos_pcie2x1>,
-+			 <&qos_sata1>,
-+			 <&qos_sata2>,
-+			 <&qos_usb3_0>,
-+			 <&qos_usb3_1>;
-+		#power-domain-cells = <0>;
-+	};
-+};
-+
-+&usbdrd_dwc3 {
-+	phys = <&u2phy0_otg>;
-+	phy-names = "usb2-phy";
-+	extcon = <&usb2phy0>;
-+	maximum-speed = "high-speed";
-+	snps,dis_u2_susphy_quirk;
-+};
---- a/arch/arm/dts/rk3568-evb.dts
-+++ b/arch/arm/dts/rk3568-evb.dts
-@@ -74,6 +74,11 @@
- 	status = "okay";
- };
- 
-+&sdmmc0 {
-+	status = "okay";
-+	max-frequency = <52000000>;
-+};
-+
- &uart2 {
- 	status = "okay";
- };
---- a/arch/arm/dts/rk3568-pinctrl.dtsi
-+++ b/arch/arm/dts/rk3568-pinctrl.dtsi
-@@ -3108,4 +3108,13 @@
- 				<4 RK_PA0 3 &pcfg_pull_none_drv_level_2>;
- 		};
- 	};
-+
-+	tsadc {
-+		/omit-if-no-ref/
-+		tsadc_pin: tsadc-pin {
-+			rockchip,pins =
-+				/* tsadc_pin */
-+				<0 RK_PA1 0 &pcfg_pull_none>;
-+		};
-+	};
- };
---- a/arch/arm/dts/rk3568.dtsi
-+++ b/arch/arm/dts/rk3568.dtsi
-@@ -3,777 +3,135 @@
-  * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
-  */
- 
--#include <dt-bindings/clock/rk3568-cru.h>
--#include <dt-bindings/interrupt-controller/arm-gic.h>
--#include <dt-bindings/interrupt-controller/irq.h>
--#include <dt-bindings/phy/phy.h>
--#include <dt-bindings/pinctrl/rockchip.h>
--#include <dt-bindings/soc/rockchip,boot-mode.h>
--#include <dt-bindings/thermal/thermal.h>
-+#include "rk356x.dtsi"
- 
- / {
- 	compatible = "rockchip,rk3568";
- 
--	interrupt-parent = <&gic>;
--	#address-cells = <2>;
--	#size-cells = <2>;
--
--	aliases {
--		gpio0 = &gpio0;
--		gpio1 = &gpio1;
--		gpio2 = &gpio2;
--		gpio3 = &gpio3;
--		gpio4 = &gpio4;
--		i2c0 = &i2c0;
--		i2c1 = &i2c1;
--		i2c2 = &i2c2;
--		i2c3 = &i2c3;
--		i2c4 = &i2c4;
--		i2c5 = &i2c5;
--		serial0 = &uart0;
--		serial1 = &uart1;
--		serial2 = &uart2;
--		serial3 = &uart3;
--		serial4 = &uart4;
--		serial5 = &uart5;
--		serial6 = &uart6;
--		serial7 = &uart7;
--		serial8 = &uart8;
--		serial9 = &uart9;
--	};
--
--	cpus {
--		#address-cells = <2>;
--		#size-cells = <0>;
--
--		cpu0: cpu@0 {
--			device_type = "cpu";
--			compatible = "arm,cortex-a55";
--			reg = <0x0 0x0>;
--			clocks = <&scmi_clk 0>;
--			enable-method = "psci";
--			operating-points-v2 = <&cpu0_opp_table>;
--		};
--
--		cpu1: cpu@100 {
--			device_type = "cpu";
--			compatible = "arm,cortex-a55";
--			reg = <0x0 0x100>;
--			enable-method = "psci";
--			operating-points-v2 = <&cpu0_opp_table>;
--		};
--
--		cpu2: cpu@200 {
--			device_type = "cpu";
--			compatible = "arm,cortex-a55";
--			reg = <0x0 0x200>;
--			enable-method = "psci";
--			operating-points-v2 = <&cpu0_opp_table>;
--		};
--
--		cpu3: cpu@300 {
--			device_type = "cpu";
--			compatible = "arm,cortex-a55";
--			reg = <0x0 0x300>;
--			enable-method = "psci";
--			operating-points-v2 = <&cpu0_opp_table>;
--		};
-+	sata0: sata@fc000000 {
-+		compatible = "snps,dwc-ahci";
-+		reg = <0 0xfc000000 0 0x1000>;
-+		clocks = <&cru ACLK_SATA0>, <&cru CLK_SATA0_PMALIVE>,
-+			 <&cru CLK_SATA0_RXOOB>;
-+		clock-names = "sata", "pmalive", "rxoob";
-+		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-names = "hostc";
-+		phys = <&combphy0_us PHY_TYPE_SATA>;
-+		phy-names = "sata-phy";
-+		ports-implemented = <0x1>;
-+		power-domains = <&power RK3568_PD_PIPE>;
-+		status = "disabled";
- 	};
- 
--	cpu0_opp_table: cpu0-opp-table {
--		compatible = "operating-points-v2";
--		opp-shared;
--
--		opp-408000000 {
--			opp-hz = /bits/ 64 <408000000>;
--			opp-microvolt = <900000 900000 1150000>;
--			clock-latency-ns = <40000>;
--		};
--
--		opp-600000000 {
--			opp-hz = /bits/ 64 <600000000>;
--			opp-microvolt = <900000 900000 1150000>;
--		};
--
--		opp-816000000 {
--			opp-hz = /bits/ 64 <816000000>;
--			opp-microvolt = <900000 900000 1150000>;
--			opp-suspend;
--		};
--
--		opp-1104000000 {
--			opp-hz = /bits/ 64 <1104000000>;
--			opp-microvolt = <900000 900000 1150000>;
--		};
--
--		opp-1416000000 {
--			opp-hz = /bits/ 64 <1416000000>;
--			opp-microvolt = <900000 900000 1150000>;
--		};
--
--		opp-1608000000 {
--			opp-hz = /bits/ 64 <1608000000>;
--			opp-microvolt = <975000 975000 1150000>;
--		};
-+	qos_pcie3x1: qos@fe190080 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe190080 0x0 0x20>;
-+	};
-+
-+	qos_pcie3x2: qos@fe190100 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe190100 0x0 0x20>;
-+	};
-+
-+	qos_sata0: qos@fe190200 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe190200 0x0 0x20>;
-+	};
-+
-+	gmac0: ethernet@fe2a0000 {
-+		compatible = "rockchip,rk3568-gmac", "snps,dwmac-4.20a";
-+		reg = <0x0 0xfe2a0000 0x0 0x10000>;
-+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-names = "macirq", "eth_wake_irq";
-+		clocks = <&cru SCLK_GMAC0>, <&cru SCLK_GMAC0_RX_TX>,
-+			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_MAC0_REFOUT>,
-+			 <&cru ACLK_GMAC0>, <&cru PCLK_GMAC0>,
-+			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>,
-+			 <&cru PCLK_XPCS>;
-+		clock-names = "stmmaceth", "mac_clk_rx",
-+			      "mac_clk_tx", "clk_mac_refout",
-+			      "aclk_mac", "pclk_mac",
-+			      "clk_mac_speed", "ptp_ref",
-+			      "pclk_xpcs";
-+		resets = <&cru SRST_A_GMAC0>;
-+		reset-names = "stmmaceth";
-+		rockchip,grf = <&grf>;
-+		snps,axi-config = <&gmac0_stmmac_axi_setup>;
-+		snps,mixed-burst;
-+		snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
-+		snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
-+		snps,tso;
-+		status = "disabled";
- 
--		opp-1800000000 {
--			opp-hz = /bits/ 64 <1800000000>;
--			opp-microvolt = <1050000 1050000 1150000>;
-+		mdio0: mdio {
-+			compatible = "snps,dwmac-mdio";
-+			#address-cells = <0x1>;
-+			#size-cells = <0x0>;
- 		};
- 
--		opp-1992000000 {
--			opp-hz = /bits/ 64 <1992000000>;
--			opp-microvolt = <1150000 1150000 1150000>;
-+		gmac0_stmmac_axi_setup: stmmac-axi-config {
-+			snps,blen = <0 0 0 0 16 8 4>;
-+			snps,rd_osr_lmt = <8>;
-+			snps,wr_osr_lmt = <4>;
- 		};
--	};
- 
--	firmware {
--		scmi: scmi {
--			compatible = "arm,scmi-smc";
--			arm,smc-id = <0x82000010>;
--			shmem = <&scmi_shmem>;
--			#address-cells = <1>;
--			#size-cells = <0>;
--
--			scmi_clk: protocol@14 {
--				reg = <0x14>;
--				#clock-cells = <1>;
--			};
-+		gmac0_mtl_rx_setup: rx-queues-config {
-+			snps,rx-queues-to-use = <1>;
-+			queue0 {};
- 		};
- 
--	};
--
--	pmu {
--		compatible = "arm,cortex-a55-pmu";
--		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
--			     <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
--			     <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
--			     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
--		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
--	};
--
--	psci {
--		compatible = "arm,psci-1.0";
--		method = "smc";
--	};
--
--	timer {
--		compatible = "arm,armv8-timer";
--		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
--			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
--			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
--			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
--		arm,no-tick-in-suspend;
--	};
--
--	xin24m: xin24m {
--		compatible = "fixed-clock";
--		clock-frequency = <24000000>;
--		clock-output-names = "xin24m";
--		#clock-cells = <0>;
--	};
--
--	xin32k: xin32k {
--		compatible = "fixed-clock";
--		clock-frequency = <32768>;
--		clock-output-names = "xin32k";
--		pinctrl-0 = <&clk32k_out0>;
--		pinctrl-names = "default";
--		#clock-cells = <0>;
--	};
--
--	sram@10f000 {
--		compatible = "mmio-sram";
--		reg = <0x0 0x0010f000 0x0 0x100>;
--
--		#address-cells = <1>;
--		#size-cells = <1>;
--		ranges = <0 0x0 0x0010f000 0x100>;
--
--		scmi_shmem: sram@0 {
--			compatible = "arm,scmi-shmem";
--			reg = <0x0 0x100>;
-+		gmac0_mtl_tx_setup: tx-queues-config {
-+			snps,tx-queues-to-use = <1>;
-+			queue0 {};
- 		};
- 	};
- 
--	gic: interrupt-controller@fd400000 {
--		compatible = "arm,gic-v3";
--		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
--		      <0x0 0xfd460000 0 0x80000>; /* GICR */
--		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
--		interrupt-controller;
--		#interrupt-cells = <3>;
--		mbi-alias = <0x0 0xfd100000>;
--		mbi-ranges = <296 24>;
--		msi-controller;
--	};
--
--	pmugrf: syscon@fdc20000 {
--		compatible = "rockchip,rk3568-pmugrf", "syscon", "simple-mfd";
--		reg = <0x0 0xfdc20000 0x0 0x10000>;
--	};
--
--	grf: syscon@fdc60000 {
--		compatible = "rockchip,rk3568-grf", "syscon", "simple-mfd";
--		reg = <0x0 0xfdc60000 0x0 0x10000>;
--	};
--
--	pmucru: clock-controller@fdd00000 {
--		compatible = "rockchip,rk3568-pmucru";
--		reg = <0x0 0xfdd00000 0x0 0x1000>;
--		#clock-cells = <1>;
--		#reset-cells = <1>;
--	};
--
--	cru: clock-controller@fdd20000 {
--		compatible = "rockchip,rk3568-cru";
--		reg = <0x0 0xfdd20000 0x0 0x1000>;
--		#clock-cells = <1>;
--		#reset-cells = <1>;
--	};
--
--	i2c0: i2c@fdd40000 {
--		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
--		reg = <0x0 0xfdd40000 0x0 0x1000>;
--		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&pmucru CLK_I2C0>, <&pmucru PCLK_I2C0>;
--		clock-names = "i2c", "pclk";
--		pinctrl-0 = <&i2c0_xfer>;
--		pinctrl-names = "default";
--		#address-cells = <1>;
--		#size-cells = <0>;
--		status = "disabled";
--	};
--
--	uart0: serial@fdd50000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfdd50000 0x0 0x100>;
--		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&pmucru SCLK_UART0>, <&pmucru PCLK_UART0>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 0>, <&dmac0 1>;
--		pinctrl-0 = <&uart0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	pwm0: pwm@fdd70000 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfdd70000 0x0 0x10>;
--		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm0m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm1: pwm@fdd70010 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfdd70010 0x0 0x10>;
--		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm1m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm2: pwm@fdd70020 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfdd70020 0x0 0x10>;
--		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm2m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm3: pwm@fdd70030 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfdd70030 0x0 0x10>;
--		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm3_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	sdmmc2: mmc@fe000000 {
--		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
--		reg = <0x0 0xfe000000 0x0 0x4000>;
--		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru HCLK_SDMMC2>, <&cru CLK_SDMMC2>,
--			 <&cru SCLK_SDMMC2_DRV>, <&cru SCLK_SDMMC2_SAMPLE>;
--		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
--		fifo-depth = <0x100>;
--		max-frequency = <150000000>;
--		resets = <&cru SRST_SDMMC2>;
--		reset-names = "reset";
--		status = "disabled";
--	};
--
--	sdmmc0: mmc@fe2b0000 {
--		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
--		reg = <0x0 0xfe2b0000 0x0 0x4000>;
--		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru HCLK_SDMMC0>, <&cru CLK_SDMMC0>,
--			 <&cru SCLK_SDMMC0_DRV>, <&cru SCLK_SDMMC0_SAMPLE>;
--		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
--		fifo-depth = <0x100>;
--		max-frequency = <150000000>;
--		resets = <&cru SRST_SDMMC0>;
--		reset-names = "reset";
--		status = "disabled";
--	};
--
--	sdmmc1: mmc@fe2c0000 {
--		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
--		reg = <0x0 0xfe2c0000 0x0 0x4000>;
--		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru HCLK_SDMMC1>, <&cru CLK_SDMMC1>,
--			 <&cru SCLK_SDMMC1_DRV>, <&cru SCLK_SDMMC1_SAMPLE>;
--		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
--		fifo-depth = <0x100>;
--		max-frequency = <150000000>;
--		resets = <&cru SRST_SDMMC1>;
--		reset-names = "reset";
--		status = "disabled";
--	};
--
--	sdhci: mmc@fe310000 {
--		compatible = "rockchip,rk3568-dwcmshc";
--		reg = <0x0 0xfe310000 0x0 0x10000>;
--		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
--		assigned-clocks = <&cru BCLK_EMMC>, <&cru TCLK_EMMC>;
--		assigned-clock-rates = <200000000>, <24000000>;
--		clocks = <&cru CCLK_EMMC>, <&cru HCLK_EMMC>,
--			 <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
--			 <&cru TCLK_EMMC>;
--		clock-names = "core", "bus", "axi", "block", "timer";
--		status = "disabled";
--	};
--
--	dmac0: dmac@fe530000 {
--		compatible = "arm,pl330", "arm,primecell";
--		reg = <0x0 0xfe530000 0x0 0x4000>;
--		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
--			     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
--		arm,pl330-periph-burst;
--		clocks = <&cru ACLK_BUS>;
--		clock-names = "apb_pclk";
--		#dma-cells = <1>;
--	};
--
--	dmac1: dmac@fe550000 {
--		compatible = "arm,pl330", "arm,primecell";
--		reg = <0x0 0xfe550000 0x0 0x4000>;
--		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
--			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
--		arm,pl330-periph-burst;
--		clocks = <&cru ACLK_BUS>;
--		clock-names = "apb_pclk";
--		#dma-cells = <1>;
--	};
--
--	i2c1: i2c@fe5a0000 {
--		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
--		reg = <0x0 0xfe5a0000 0x0 0x1000>;
--		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru CLK_I2C1>, <&cru PCLK_I2C1>;
--		clock-names = "i2c", "pclk";
--		pinctrl-0 = <&i2c1_xfer>;
--		pinctrl-names = "default";
--		#address-cells = <1>;
--		#size-cells = <0>;
--		status = "disabled";
--	};
--
--	i2c2: i2c@fe5b0000 {
--		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
--		reg = <0x0 0xfe5b0000 0x0 0x1000>;
--		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru CLK_I2C2>, <&cru PCLK_I2C2>;
--		clock-names = "i2c", "pclk";
--		pinctrl-0 = <&i2c2m0_xfer>;
--		pinctrl-names = "default";
--		#address-cells = <1>;
--		#size-cells = <0>;
--		status = "disabled";
--	};
--
--	i2c3: i2c@fe5c0000 {
--		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
--		reg = <0x0 0xfe5c0000 0x0 0x1000>;
--		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru CLK_I2C3>, <&cru PCLK_I2C3>;
--		clock-names = "i2c", "pclk";
--		pinctrl-0 = <&i2c3m0_xfer>;
--		pinctrl-names = "default";
--		#address-cells = <1>;
--		#size-cells = <0>;
--		status = "disabled";
--	};
--
--	i2c4: i2c@fe5d0000 {
--		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
--		reg = <0x0 0xfe5d0000 0x0 0x1000>;
--		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru CLK_I2C4>, <&cru PCLK_I2C4>;
--		clock-names = "i2c", "pclk";
--		pinctrl-0 = <&i2c4m0_xfer>;
--		pinctrl-names = "default";
--		#address-cells = <1>;
--		#size-cells = <0>;
--		status = "disabled";
--	};
--
--	i2c5: i2c@fe5e0000 {
--		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
--		reg = <0x0 0xfe5e0000 0x0 0x1000>;
--		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru CLK_I2C5>, <&cru PCLK_I2C5>;
--		clock-names = "i2c", "pclk";
--		pinctrl-0 = <&i2c5m0_xfer>;
--		pinctrl-names = "default";
--		#address-cells = <1>;
--		#size-cells = <0>;
--		status = "disabled";
--	};
--
--	wdt: watchdog@fe600000 {
--		compatible = "rockchip,rk3568-wdt", "snps,dw-wdt";
--		reg = <0x0 0xfe600000 0x0 0x100>;
--		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru TCLK_WDT_NS>, <&cru PCLK_WDT_NS>;
--		clock-names = "tclk", "pclk";
--	};
--
--	uart1: serial@fe650000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfe650000 0x0 0x100>;
--		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 2>, <&dmac0 3>;
--		pinctrl-0 = <&uart1m0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	uart2: serial@fe660000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfe660000 0x0 0x100>;
--		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 4>, <&dmac0 5>;
--		pinctrl-0 = <&uart2m0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	uart3: serial@fe670000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfe670000 0x0 0x100>;
--		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 6>, <&dmac0 7>;
--		pinctrl-0 = <&uart3m0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	uart4: serial@fe680000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfe680000 0x0 0x100>;
--		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 8>, <&dmac0 9>;
--		pinctrl-0 = <&uart4m0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	uart5: serial@fe690000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfe690000 0x0 0x100>;
--		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru SCLK_UART5>, <&cru PCLK_UART5>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 10>, <&dmac0 11>;
--		pinctrl-0 = <&uart5m0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	uart6: serial@fe6a0000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfe6a0000 0x0 0x100>;
--		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru SCLK_UART6>, <&cru PCLK_UART6>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 12>, <&dmac0 13>;
--		pinctrl-0 = <&uart6m0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	uart7: serial@fe6b0000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfe6b0000 0x0 0x100>;
--		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru SCLK_UART7>, <&cru PCLK_UART7>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 14>, <&dmac0 15>;
--		pinctrl-0 = <&uart7m0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	uart8: serial@fe6c0000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfe6c0000 0x0 0x100>;
--		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru SCLK_UART8>, <&cru PCLK_UART8>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 16>, <&dmac0 17>;
--		pinctrl-0 = <&uart8m0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	uart9: serial@fe6d0000 {
--		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
--		reg = <0x0 0xfe6d0000 0x0 0x100>;
--		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
--		clocks = <&cru SCLK_UART9>, <&cru PCLK_UART9>;
--		clock-names = "baudclk", "apb_pclk";
--		dmas = <&dmac0 18>, <&dmac0 19>;
--		pinctrl-0 = <&uart9m0_xfer>;
--		pinctrl-names = "default";
--		reg-io-width = <4>;
--		reg-shift = <2>;
--		status = "disabled";
--	};
--
--	pwm4: pwm@fe6e0000 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe6e0000 0x0 0x10>;
--		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm4_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm5: pwm@fe6e0010 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe6e0010 0x0 0x10>;
--		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm5_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm6: pwm@fe6e0020 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe6e0020 0x0 0x10>;
--		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm6_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm7: pwm@fe6e0030 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe6e0030 0x0 0x10>;
--		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm7_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm8: pwm@fe6f0000 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe6f0000 0x0 0x10>;
--		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm8m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm9: pwm@fe6f0010 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe6f0010 0x0 0x10>;
--		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm9m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm10: pwm@fe6f0020 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe6f0020 0x0 0x10>;
--		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm10m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm11: pwm@fe6f0030 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe6f0030 0x0 0x10>;
--		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm11m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm12: pwm@fe700000 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe700000 0x0 0x10>;
--		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm12m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm13: pwm@fe700010 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe700010 0x0 0x10>;
--		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm13m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
--	};
--
--	pwm14: pwm@fe700020 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe700020 0x0 0x10>;
--		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm14m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
-+	combphy0_us: phy@fe820000 {
-+		compatible = "rockchip,rk3568-naneng-combphy";
-+		reg = <0x0 0xfe820000 0x0 0x100>;
-+		#phy-cells = <1>;
-+		assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
-+		assigned-clock-rates = <100000000>;
-+		clocks = <&pmucru CLK_PCIEPHY0_REF>, <&cru PCLK_PIPEPHY0>,
-+			 <&cru PCLK_PIPE>;
-+		clock-names = "ref", "apb", "pipe";
-+		resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;
-+		reset-names = "combphy-apb", "combphy";
-+		rockchip,pipe-grf = <&pipegrf>;
-+		rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
- 		status = "disabled";
- 	};
-+};
- 
--	pwm15: pwm@fe700030 {
--		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
--		reg = <0x0 0xfe700030 0x0 0x10>;
--		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
--		clock-names = "pwm", "pclk";
--		pinctrl-0 = <&pwm15m0_pins>;
--		pinctrl-names = "active";
--		#pwm-cells = <3>;
--		status = "disabled";
-+&cpu0_opp_table {
-+	opp-1992000000 {
-+		opp-hz = /bits/ 64 <1992000000>;
-+		opp-microvolt = <1150000 1150000 1150000>;
- 	};
-+};
- 
--	pinctrl: pinctrl {
--		compatible = "rockchip,rk3568-pinctrl";
--		rockchip,grf = <&grf>;
--		rockchip,pmu = <&pmugrf>;
--		#address-cells = <2>;
--		#size-cells = <2>;
--		ranges;
--
--		gpio0: gpio@fdd60000 {
--			compatible = "rockchip,gpio-bank";
--			reg = <0x0 0xfdd60000 0x0 0x100>;
--			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
--			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
--			gpio-controller;
--			#gpio-cells = <2>;
--			interrupt-controller;
--			#interrupt-cells = <2>;
--		};
--
--		gpio1: gpio@fe740000 {
--			compatible = "rockchip,gpio-bank";
--			reg = <0x0 0xfe740000 0x0 0x100>;
--			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
--			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
--			gpio-controller;
--			#gpio-cells = <2>;
--			interrupt-controller;
--			#interrupt-cells = <2>;
--		};
--
--		gpio2: gpio@fe750000 {
--			compatible = "rockchip,gpio-bank";
--			reg = <0x0 0xfe750000 0x0 0x100>;
--			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
--			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
--			gpio-controller;
--			#gpio-cells = <2>;
--			interrupt-controller;
--			#interrupt-cells = <2>;
--		};
--
--		gpio3: gpio@fe760000 {
--			compatible = "rockchip,gpio-bank";
--			reg = <0x0 0xfe760000 0x0 0x100>;
--			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
--			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
--			gpio-controller;
--			#gpio-cells = <2>;
--			interrupt-controller;
--			#interrupt-cells = <2>;
--		};
-+&pipegrf {
-+	compatible = "rockchip,rk3568-pipegrf", "syscon";
-+};
- 
--		gpio4: gpio@fe770000 {
--			compatible = "rockchip,gpio-bank";
--			reg = <0x0 0xfe770000 0x0 0x100>;
--			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
--			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
--			gpio-controller;
--			#gpio-cells = <2>;
--			interrupt-controller;
--			#interrupt-cells = <2>;
--		};
-+&power {
-+	power-domain@RK3568_PD_PIPE {
-+		reg = <RK3568_PD_PIPE>;
-+		clocks = <&cru PCLK_PIPE>;
-+		pm_qos = <&qos_pcie2x1>,
-+			 <&qos_pcie3x1>,
-+			 <&qos_pcie3x2>,
-+			 <&qos_sata0>,
-+			 <&qos_sata1>,
-+			 <&qos_sata2>,
-+			 <&qos_usb3_0>,
-+			 <&qos_usb3_1>;
-+		#power-domain-cells = <0>;
- 	};
- };
- 
--#include "rk3568-pinctrl.dtsi"
-+&usbdrd_dwc3 {
-+	phys = <&u2phy0_otg>, <&combphy0_us PHY_TYPE_USB3>;
-+	phy-names = "usb2-phy", "usb3-phy";
-+};
---- /dev/null
-+++ b/arch/arm/dts/rk356x.dtsi
-@@ -0,0 +1,1630 @@
-+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-+/*
-+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
-+ */
-+
-+#include <dt-bindings/clock/rk3568-cru.h>
-+#include <dt-bindings/interrupt-controller/arm-gic.h>
-+#include <dt-bindings/interrupt-controller/irq.h>
-+#include <dt-bindings/phy/phy.h>
-+#include <dt-bindings/pinctrl/rockchip.h>
-+#include <dt-bindings/power/rk3568-power.h>
-+#include <dt-bindings/soc/rockchip,boot-mode.h>
-+#include <dt-bindings/thermal/thermal.h>
-+
-+/ {
-+	interrupt-parent = <&gic>;
-+	#address-cells = <2>;
-+	#size-cells = <2>;
-+
-+	aliases {
-+		gpio0 = &gpio0;
-+		gpio1 = &gpio1;
-+		gpio2 = &gpio2;
-+		gpio3 = &gpio3;
-+		gpio4 = &gpio4;
-+		i2c0 = &i2c0;
-+		i2c1 = &i2c1;
-+		i2c2 = &i2c2;
-+		i2c3 = &i2c3;
-+		i2c4 = &i2c4;
-+		i2c5 = &i2c5;
-+		serial0 = &uart0;
-+		serial1 = &uart1;
-+		serial2 = &uart2;
-+		serial3 = &uart3;
-+		serial4 = &uart4;
-+		serial5 = &uart5;
-+		serial6 = &uart6;
-+		serial7 = &uart7;
-+		serial8 = &uart8;
-+		serial9 = &uart9;
-+	};
-+
-+	cpus {
-+		#address-cells = <2>;
-+		#size-cells = <0>;
-+
-+		cpu0: cpu@0 {
-+			device_type = "cpu";
-+			compatible = "arm,cortex-a55";
-+			reg = <0x0 0x0>;
-+			clocks = <&scmi_clk 0>;
-+			#cooling-cells = <2>;
-+			enable-method = "psci";
-+			operating-points-v2 = <&cpu0_opp_table>;
-+		};
-+
-+		cpu1: cpu@100 {
-+			device_type = "cpu";
-+			compatible = "arm,cortex-a55";
-+			reg = <0x0 0x100>;
-+			#cooling-cells = <2>;
-+			enable-method = "psci";
-+			operating-points-v2 = <&cpu0_opp_table>;
-+		};
-+
-+		cpu2: cpu@200 {
-+			device_type = "cpu";
-+			compatible = "arm,cortex-a55";
-+			reg = <0x0 0x200>;
-+			#cooling-cells = <2>;
-+			enable-method = "psci";
-+			operating-points-v2 = <&cpu0_opp_table>;
-+		};
-+
-+		cpu3: cpu@300 {
-+			device_type = "cpu";
-+			compatible = "arm,cortex-a55";
-+			reg = <0x0 0x300>;
-+			#cooling-cells = <2>;
-+			enable-method = "psci";
-+			operating-points-v2 = <&cpu0_opp_table>;
-+		};
-+	};
-+
-+	cpu0_opp_table: opp-table-0 {
-+		compatible = "operating-points-v2";
-+		opp-shared;
-+
-+		opp-408000000 {
-+			opp-hz = /bits/ 64 <408000000>;
-+			opp-microvolt = <900000 900000 1150000>;
-+			clock-latency-ns = <40000>;
-+		};
-+
-+		opp-600000000 {
-+			opp-hz = /bits/ 64 <600000000>;
-+			opp-microvolt = <900000 900000 1150000>;
-+		};
-+
-+		opp-816000000 {
-+			opp-hz = /bits/ 64 <816000000>;
-+			opp-microvolt = <900000 900000 1150000>;
-+			opp-suspend;
-+		};
-+
-+		opp-1104000000 {
-+			opp-hz = /bits/ 64 <1104000000>;
-+			opp-microvolt = <900000 900000 1150000>;
-+		};
-+
-+		opp-1416000000 {
-+			opp-hz = /bits/ 64 <1416000000>;
-+			opp-microvolt = <900000 900000 1150000>;
-+		};
-+
-+		opp-1608000000 {
-+			opp-hz = /bits/ 64 <1608000000>;
-+			opp-microvolt = <975000 975000 1150000>;
-+		};
-+
-+		opp-1800000000 {
-+			opp-hz = /bits/ 64 <1800000000>;
-+			opp-microvolt = <1050000 1050000 1150000>;
-+		};
-+	};
-+
-+	gpu_opp_table: gpu-opp-table {
-+		compatible = "operating-points-v2";
-+
-+		opp-200000000 {
-+			opp-hz = /bits/ 64 <200000000>;
-+			opp-microvolt = <825000>;
-+		};
-+
-+		opp-300000000 {
-+			opp-hz = /bits/ 64 <300000000>;
-+			opp-microvolt = <825000>;
-+		};
-+
-+		opp-400000000 {
-+			opp-hz = /bits/ 64 <400000000>;
-+			opp-microvolt = <825000>;
-+		};
-+
-+		opp-600000000 {
-+			opp-hz = /bits/ 64 <600000000>;
-+			opp-microvolt = <825000>;
-+		};
-+
-+		opp-700000000 {
-+			opp-hz = /bits/ 64 <700000000>;
-+			opp-microvolt = <900000>;
-+		};
-+
-+		opp-800000000 {
-+			opp-hz = /bits/ 64 <800000000>;
-+			opp-microvolt = <1000000>;
-+		};
-+	};
-+
-+	firmware {
-+		scmi: scmi {
-+			compatible = "arm,scmi-smc";
-+			arm,smc-id = <0x82000010>;
-+			shmem = <&scmi_shmem>;
-+			#address-cells = <1>;
-+			#size-cells = <0>;
-+
-+			scmi_clk: protocol@14 {
-+				reg = <0x14>;
-+				#clock-cells = <1>;
-+			};
-+		};
-+	};
-+
-+	pmu {
-+		compatible = "arm,cortex-a55-pmu";
-+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
-+	};
-+
-+	psci {
-+		compatible = "arm,psci-1.0";
-+		method = "smc";
-+	};
-+
-+	timer {
-+		compatible = "arm,armv8-timer";
-+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
-+		arm,no-tick-in-suspend;
-+	};
-+
-+	xin24m: xin24m {
-+		compatible = "fixed-clock";
-+		clock-frequency = <24000000>;
-+		clock-output-names = "xin24m";
-+		#clock-cells = <0>;
-+	};
-+
-+	xin32k: xin32k {
-+		compatible = "fixed-clock";
-+		clock-frequency = <32768>;
-+		clock-output-names = "xin32k";
-+		pinctrl-0 = <&clk32k_out0>;
-+		pinctrl-names = "default";
-+		#clock-cells = <0>;
-+	};
-+
-+	sram@10f000 {
-+		compatible = "mmio-sram";
-+		reg = <0x0 0x0010f000 0x0 0x100>;
-+		#address-cells = <1>;
-+		#size-cells = <1>;
-+		ranges = <0 0x0 0x0010f000 0x100>;
-+
-+		scmi_shmem: sram@0 {
-+			compatible = "arm,scmi-shmem";
-+			reg = <0x0 0x100>;
-+		};
-+	};
-+
-+	sata1: sata@fc400000 {
-+		compatible = "snps,dwc-ahci";
-+		reg = <0 0xfc400000 0 0x1000>;
-+		clocks = <&cru ACLK_SATA1>, <&cru CLK_SATA1_PMALIVE>,
-+			 <&cru CLK_SATA1_RXOOB>;
-+		clock-names = "sata", "pmalive", "rxoob";
-+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-names = "hostc";
-+		phys = <&combphy1_usq PHY_TYPE_SATA>;
-+		phy-names = "sata-phy";
-+		ports-implemented = <0x1>;
-+		power-domains = <&power RK3568_PD_PIPE>;
-+		status = "disabled";
-+	};
-+
-+	sata2: sata@fc800000 {
-+		compatible = "snps,dwc-ahci";
-+		reg = <0 0xfc800000 0 0x1000>;
-+		clocks = <&cru ACLK_SATA2>, <&cru CLK_SATA2_PMALIVE>,
-+			 <&cru CLK_SATA2_RXOOB>;
-+		clock-names = "sata", "pmalive", "rxoob";
-+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-names = "hostc";
-+		phys = <&combphy2_psq PHY_TYPE_SATA>;
-+		phy-names = "sata-phy";
-+		ports-implemented = <0x1>;
-+		power-domains = <&power RK3568_PD_PIPE>;
-+		status = "disabled";
-+	};
-+
-+	usbdrd30: usbdrd {
-+		compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
-+		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
-+			 <&cru ACLK_USB3OTG0>, <&cru PCLK_PIPE>;
-+		clock-names = "ref_clk", "suspend_clk",
-+			      "bus_clk", "pipe_clk";
-+		#address-cells = <2>;
-+		#size-cells = <2>;
-+		ranges;
-+		status = "disabled";
-+
-+		usbdrd_dwc3: dwc3@fcc00000 {
-+			compatible = "snps,dwc3";
-+			reg = <0x0 0xfcc00000 0x0 0x400000>;
-+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-+			dr_mode = "host";
-+			phys = <&u2phy0_otg>, <&combphy0_us PHY_TYPE_USB3>;
-+			phy-names = "usb2-phy", "usb3-phy";
-+			phy_type = "utmi_wide";
-+			power-domains = <&power RK3568_PD_PIPE>;
-+			resets = <&cru SRST_USB3OTG0>;
-+			reset-names = "usb3-otg";
-+			snps,dis_enblslpm_quirk;
-+			snps,dis-u2-freeclk-exists-quirk;
-+			snps,dis-del-phy-power-chg-quirk;
-+			snps,dis-tx-ipgap-linecheck-quirk;
-+			snps,xhci-trb-ent-quirk;
-+			status = "disabled";
-+		};
-+	};
-+
-+	usbhost30: usbhost {
-+		compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
-+		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
-+			 <&cru ACLK_USB3OTG1>, <&cru PCLK_PIPE>;
-+		clock-names = "ref_clk", "suspend_clk",
-+			      "bus_clk", "pipe_clk";
-+		#address-cells = <2>;
-+		#size-cells = <2>;
-+		assigned-clocks = <&cru CLK_PCIEPHY1_REF>;
-+		assigned-clock-rates = <25000000>;
-+		ranges;
-+		status = "disabled";
-+
-+		usbhost_dwc3: dwc3@fd000000 {
-+			compatible = "snps,dwc3";
-+			reg = <0x0 0xfd000000 0x0 0x400000>;
-+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
-+			dr_mode = "host";
-+			phys = <&u2phy0_host>, <&combphy1_usq PHY_TYPE_USB3>;
-+			phy-names = "usb2-phy", "usb3-phy";
-+			phy_type = "utmi_wide";
-+			power-domains = <&power RK3568_PD_PIPE>;
-+			resets = <&cru SRST_USB3OTG1>;
-+			reset-names = "usb3-host";
-+			snps,dis_enblslpm_quirk;
-+			snps,dis-u2-freeclk-exists-quirk;
-+			snps,dis_u2_susphy_quirk;
-+			snps,dis-del-phy-power-chg-quirk;
-+			snps,dis-tx-ipgap-linecheck-quirk;
-+			status = "disabled";
-+		};
-+	};
-+
-+	gic: interrupt-controller@fd400000 {
-+		compatible = "arm,gic-v3";
-+		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
-+		      <0x0 0xfd460000 0 0x80000>; /* GICR */
-+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-controller;
-+		#interrupt-cells = <3>;
-+		mbi-alias = <0x0 0xfd410000>;
-+		mbi-ranges = <296 24>;
-+		msi-controller;
-+	};
-+
-+	usb_host0_ehci: usb@fd800000 {
-+		compatible = "generic-ehci";
-+		reg = <0x0 0xfd800000 0x0 0x40000>;
-+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
-+			 <&cru PCLK_USB>;
-+		phys = <&u2phy1_otg>;
-+		phy-names = "usb2-phy";
-+		status = "disabled";
-+	};
-+
-+	usb_host0_ohci: usb@fd840000 {
-+		compatible = "generic-ohci";
-+		reg = <0x0 0xfd840000 0x0 0x40000>;
-+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
-+			 <&cru PCLK_USB>;
-+		phys = <&u2phy1_otg>;
-+		phy-names = "usb2-phy";
-+		status = "disabled";
-+	};
-+
-+	usb_host1_ehci: usb@fd880000 {
-+		compatible = "generic-ehci";
-+		reg = <0x0 0xfd880000 0x0 0x40000>;
-+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
-+			 <&cru PCLK_USB>;
-+		phys = <&u2phy1_host>;
-+		phy-names = "usb2-phy";
-+		status = "disabled";
-+	};
-+
-+	usb_host1_ohci: usb@fd8c0000 {
-+		compatible = "generic-ohci";
-+		reg = <0x0 0xfd8c0000 0x0 0x40000>;
-+		interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
-+			 <&cru PCLK_USB>;
-+		phys = <&u2phy1_host>;
-+		phy-names = "usb2-phy";
-+		status = "disabled";
-+	};
-+
-+	pmugrf: syscon@fdc20000 {
-+		compatible = "rockchip,rk3568-pmugrf", "syscon", "simple-mfd";
-+		reg = <0x0 0xfdc20000 0x0 0x10000>;
-+
-+		pmu_io_domains: io-domains {
-+			compatible = "rockchip,rk3568-pmu-io-voltage-domain";
-+			status = "disabled";
-+		};
-+	};
-+
-+	pipegrf: syscon@fdc50000 {
-+		reg = <0x0 0xfdc50000 0x0 0x1000>;
-+	};
-+
-+	grf: syscon@fdc60000 {
-+		compatible = "rockchip,rk3568-grf", "syscon", "simple-mfd";
-+		reg = <0x0 0xfdc60000 0x0 0x10000>;
-+	};
-+
-+	pipe_phy_grf0: syscon@fdc70000 {
-+		compatible = "rockchip,pipe-phy-grf", "syscon";
-+		reg = <0x0 0xfdc70000 0x0 0x1000>;
-+	};
-+
-+	pipe_phy_grf1: syscon@fdc80000 {
-+		compatible = "rockchip,pipe-phy-grf", "syscon";
-+		reg = <0x0 0xfdc80000 0x0 0x1000>;
-+	};
-+
-+	pipe_phy_grf2: syscon@fdc90000 {
-+		compatible = "rockchip,pipe-phy-grf", "syscon";
-+		reg = <0x0 0xfdc90000 0x0 0x1000>;
-+	};
-+
-+	usb2phy0_grf: syscon@fdca0000 {
-+		compatible = "rockchip,rk3568-usb2phy-grf", "syscon";
-+		reg = <0x0 0xfdca0000 0x0 0x8000>;
-+	};
-+
-+	usb2phy1_grf: syscon@fdca8000 {
-+		compatible = "rockchip,rk3568-usb2phy-grf", "syscon";
-+		reg = <0x0 0xfdca8000 0x0 0x8000>;
-+	};
-+
-+	pmucru: clock-controller@fdd00000 {
-+		compatible = "rockchip,rk3568-pmucru";
-+		reg = <0x0 0xfdd00000 0x0 0x1000>;
-+		#clock-cells = <1>;
-+		#reset-cells = <1>;
-+	};
-+
-+	cru: clock-controller@fdd20000 {
-+		compatible = "rockchip,rk3568-cru";
-+		reg = <0x0 0xfdd20000 0x0 0x1000>;
-+		#clock-cells = <1>;
-+		#reset-cells = <1>;
-+		assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>;
-+		assigned-clock-rates = <1200000000>, <200000000>;
-+		rockchip,grf = <&grf>;
-+	};
-+
-+	i2c0: i2c@fdd40000 {
-+		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
-+		reg = <0x0 0xfdd40000 0x0 0x1000>;
-+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&pmucru CLK_I2C0>, <&pmucru PCLK_I2C0>;
-+		clock-names = "i2c", "pclk";
-+		pinctrl-0 = <&i2c0_xfer>;
-+		pinctrl-names = "default";
-+		#address-cells = <1>;
-+		#size-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	uart0: serial@fdd50000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfdd50000 0x0 0x100>;
-+		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&pmucru SCLK_UART0>, <&pmucru PCLK_UART0>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 0>, <&dmac0 1>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	pwm0: pwm@fdd70000 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfdd70000 0x0 0x10>;
-+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm0m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm1: pwm@fdd70010 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfdd70010 0x0 0x10>;
-+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm1m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm2: pwm@fdd70020 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfdd70020 0x0 0x10>;
-+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm2m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm3: pwm@fdd70030 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfdd70030 0x0 0x10>;
-+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm3_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pmu: power-management@fdd90000 {
-+		compatible = "rockchip,rk3568-pmu", "syscon", "simple-mfd";
-+		reg = <0x0 0xfdd90000 0x0 0x1000>;
-+
-+		power: power-controller {
-+			compatible = "rockchip,rk3568-power-controller";
-+			#power-domain-cells = <1>;
-+			#address-cells = <1>;
-+			#size-cells = <0>;
-+
-+			/* These power domains are grouped by VD_GPU */
-+			power-domain@RK3568_PD_GPU {
-+				reg = <RK3568_PD_GPU>;
-+				clocks = <&cru ACLK_GPU_PRE>,
-+					 <&cru PCLK_GPU_PRE>;
-+				pm_qos = <&qos_gpu>;
-+				#power-domain-cells = <0>;
-+			};
-+
-+			/* These power domains are grouped by VD_LOGIC */
-+			power-domain@RK3568_PD_VI {
-+				reg = <RK3568_PD_VI>;
-+				clocks = <&cru HCLK_VI>,
-+					 <&cru PCLK_VI>;
-+				pm_qos = <&qos_isp>,
-+					 <&qos_vicap0>,
-+					 <&qos_vicap1>;
-+				#power-domain-cells = <0>;
-+			};
-+
-+			power-domain@RK3568_PD_VO {
-+				reg = <RK3568_PD_VO>;
-+				clocks = <&cru HCLK_VO>,
-+					 <&cru PCLK_VO>,
-+					 <&cru ACLK_VOP_PRE>;
-+				pm_qos = <&qos_hdcp>,
-+					 <&qos_vop_m0>,
-+					 <&qos_vop_m1>;
-+				#power-domain-cells = <0>;
-+			};
-+
-+			power-domain@RK3568_PD_RGA {
-+				reg = <RK3568_PD_RGA>;
-+				clocks = <&cru HCLK_RGA_PRE>,
-+					 <&cru PCLK_RGA_PRE>;
-+				pm_qos = <&qos_ebc>,
-+					 <&qos_iep>,
-+					 <&qos_jpeg_dec>,
-+					 <&qos_jpeg_enc>,
-+					 <&qos_rga_rd>,
-+					 <&qos_rga_wr>;
-+				#power-domain-cells = <0>;
-+			};
-+
-+			power-domain@RK3568_PD_VPU {
-+				reg = <RK3568_PD_VPU>;
-+				clocks = <&cru HCLK_VPU_PRE>;
-+				pm_qos = <&qos_vpu>;
-+				#power-domain-cells = <0>;
-+			};
-+
-+			power-domain@RK3568_PD_RKVDEC {
-+				clocks = <&cru HCLK_RKVDEC_PRE>;
-+				reg = <RK3568_PD_RKVDEC>;
-+				pm_qos = <&qos_rkvdec>;
-+				#power-domain-cells = <0>;
-+			};
-+
-+			power-domain@RK3568_PD_RKVENC {
-+				reg = <RK3568_PD_RKVENC>;
-+				clocks = <&cru HCLK_RKVENC_PRE>;
-+				pm_qos = <&qos_rkvenc_rd_m0>,
-+					 <&qos_rkvenc_rd_m1>,
-+					 <&qos_rkvenc_wr_m0>;
-+				#power-domain-cells = <0>;
-+			};
-+		};
-+	};
-+
-+	gpu: gpu@fde60000 {
-+		compatible = "rockchip,rk3568-mali", "arm,mali-bifrost";
-+		reg = <0x0 0xfde60000 0x0 0x4000>;
-+
-+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-names = "job", "mmu", "gpu";
-+		clocks = <&scmi_clk 1>, <&cru CLK_GPU>;
-+		clock-names = "core", "bus";
-+		operating-points-v2 = <&gpu_opp_table>;
-+		#cooling-cells = <2>;
-+		power-domains = <&power RK3568_PD_GPU>;
-+		status = "disabled";
-+	};
-+
-+	sdmmc2: mmc@fe000000 {
-+		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
-+		reg = <0x0 0xfe000000 0x0 0x4000>;
-+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru HCLK_SDMMC2>, <&cru CLK_SDMMC2>,
-+			 <&cru SCLK_SDMMC2_DRV>, <&cru SCLK_SDMMC2_SAMPLE>;
-+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-+		fifo-depth = <0x100>;
-+		max-frequency = <150000000>;
-+		resets = <&cru SRST_SDMMC2>;
-+		reset-names = "reset";
-+		status = "disabled";
-+	};
-+
-+	gmac1: ethernet@fe010000 {
-+		compatible = "rockchip,rk3568-gmac", "snps,dwmac-4.20a";
-+		reg = <0x0 0xfe010000 0x0 0x10000>;
-+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-names = "macirq", "eth_wake_irq";
-+		clocks = <&cru SCLK_GMAC1>, <&cru SCLK_GMAC1_RX_TX>,
-+			 <&cru SCLK_GMAC1_RX_TX>, <&cru CLK_MAC1_REFOUT>,
-+			 <&cru ACLK_GMAC1>, <&cru PCLK_GMAC1>,
-+			 <&cru SCLK_GMAC1_RX_TX>, <&cru CLK_GMAC1_PTP_REF>;
-+		clock-names = "stmmaceth", "mac_clk_rx",
-+			      "mac_clk_tx", "clk_mac_refout",
-+			      "aclk_mac", "pclk_mac",
-+			      "clk_mac_speed", "ptp_ref";
-+		resets = <&cru SRST_A_GMAC1>;
-+		reset-names = "stmmaceth";
-+		rockchip,grf = <&grf>;
-+		snps,axi-config = <&gmac1_stmmac_axi_setup>;
-+		snps,mixed-burst;
-+		snps,mtl-rx-config = <&gmac1_mtl_rx_setup>;
-+		snps,mtl-tx-config = <&gmac1_mtl_tx_setup>;
-+		snps,tso;
-+		status = "disabled";
-+
-+		mdio1: mdio {
-+			compatible = "snps,dwmac-mdio";
-+			#address-cells = <0x1>;
-+			#size-cells = <0x0>;
-+		};
-+
-+		gmac1_stmmac_axi_setup: stmmac-axi-config {
-+			snps,blen = <0 0 0 0 16 8 4>;
-+			snps,rd_osr_lmt = <8>;
-+			snps,wr_osr_lmt = <4>;
-+		};
-+
-+		gmac1_mtl_rx_setup: rx-queues-config {
-+			snps,rx-queues-to-use = <1>;
-+			queue0 {};
-+		};
-+
-+		gmac1_mtl_tx_setup: tx-queues-config {
-+			snps,tx-queues-to-use = <1>;
-+			queue0 {};
-+		};
-+	};
-+
-+	display_subsystem: display-subsystem {
-+		compatible = "rockchip,display-subsystem";
-+		ports = <&vop_out>;
-+	};
-+
-+	vop: vop@fe040000 {
-+		compatible = "rockchip,rk3568-vop";
-+		reg = <0x0 0xfe040000 0x0 0x3000>, <0x0 0xfe044000 0x0 0x1000>;
-+		reg-names = "regs", "gamma_lut";
-+		rockchip,grf = <&grf>;
-+		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>, <&cru DCLK_VOP0>, <&cru DCLK_VOP1>, <&cru DCLK_VOP2>;
-+		clock-names = "aclk_vop", "hclk_vop", "dclk_vp0", "dclk_vp1", "dclk_vp2";
-+		iommus = <&vop_mmu>;
-+		power-domains = <&power RK3568_PD_VO>;
-+		status = "disabled";
-+
-+		vop_out: ports {
-+			#address-cells = <1>;
-+			#size-cells = <0>;
-+
-+			vp0: port@0 {
-+				#address-cells = <1>;
-+				#size-cells = <0>;
-+				reg = <0>;
-+
-+				vp0_out_hdmi: endpoint@0 {
-+					reg = <0>;
-+					remote-endpoint = <&hdmi_in_vp0>;
-+					status = "disabled";
-+				};
-+			};
-+
-+			vp1: port@1 {
-+				#address-cells = <1>;
-+				#size-cells = <0>;
-+				reg = <1>;
-+
-+				vp1_out_hdmi: endpoint@0 {
-+					reg = <0>;
-+					remote-endpoint = <&hdmi_in_vp1>;
-+					status = "disabled";
-+				};
-+			};
-+
-+			vp2: port@2 {
-+				#address-cells = <1>;
-+				#size-cells = <0>;
-+				reg = <2>;
-+
-+				vp2_out_hdmi: endpoint@0 {
-+					reg = <0>;
-+					remote-endpoint = <&hdmi_in_vp2>;
-+					status = "disabled";
-+				};
-+			};
-+		};
-+	};
-+
-+	vop_mmu: iommu@fe043e00 {
-+		compatible = "rockchip,rk3568-iommu";
-+		reg = <0x0 0xfe043e00 0x0 0x100>, <0x0 0xfe043f00 0x0 0x100>;
-+		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-names = "vop_mmu";
-+		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
-+		clock-names = "aclk", "iface";
-+		#iommu-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	hdmi: hdmi@fe0a0000 {
-+		compatible = "rockchip,rk3568-dw-hdmi";
-+		reg = <0x0 0xfe0a0000 0x0 0x20000>;
-+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru PCLK_HDMI_HOST>,
-+			 <&cru CLK_HDMI_SFR>,
-+			 <&cru CLK_HDMI_CEC>,
-+			 <&cru HCLK_VOP>;
-+		clock-names = "iahb", "isfr", "cec", "hclk";
-+		power-domains = <&power RK3568_PD_VO>;
-+		reg-io-width = <4>;
-+		rockchip,grf = <&grf>;
-+		#sound-dai-cells = <0>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&hdmitx_scl &hdmitx_sda &hdmitxm0_cec>;
-+		status = "disabled";
-+
-+		ports {
-+			#address-cells = <1>;
-+			#size-cells = <0>;
-+
-+			hdmi_in: port@0 {
-+				reg = <0>;
-+				#address-cells = <1>;
-+				#size-cells = <0>;
-+
-+				hdmi_in_vp0: endpoint@0 {
-+					reg = <0>;
-+					remote-endpoint = <&vp0_out_hdmi>;
-+					status = "disabled";
-+				};
-+
-+				hdmi_in_vp1: endpoint@1 {
-+					reg = <1>;
-+					remote-endpoint = <&vp1_out_hdmi>;
-+					status = "disabled";
-+				};
-+
-+				hdmi_in_vp2: endpoint@2 {
-+					reg = <2>;
-+					remote-endpoint = <&vp2_out_hdmi>;
-+					status = "disabled";
-+				};
-+			};
-+		};
-+	};
-+
-+	qos_gpu: qos@fe128000 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe128000 0x0 0x20>;
-+	};
-+
-+	qos_rkvenc_rd_m0: qos@fe138080 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe138080 0x0 0x20>;
-+	};
-+
-+	qos_rkvenc_rd_m1: qos@fe138100 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe138100 0x0 0x20>;
-+	};
-+
-+	qos_rkvenc_wr_m0: qos@fe138180 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe138180 0x0 0x20>;
-+	};
-+
-+	qos_isp: qos@fe148000 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe148000 0x0 0x20>;
-+	};
-+
-+	qos_vicap0: qos@fe148080 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe148080 0x0 0x20>;
-+	};
-+
-+	qos_vicap1: qos@fe148100 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe148100 0x0 0x20>;
-+	};
-+
-+	qos_vpu: qos@fe150000 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe150000 0x0 0x20>;
-+	};
-+
-+	qos_ebc: qos@fe158000 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe158000 0x0 0x20>;
-+	};
-+
-+	qos_iep: qos@fe158100 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe158100 0x0 0x20>;
-+	};
-+
-+	qos_jpeg_dec: qos@fe158180 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe158180 0x0 0x20>;
-+	};
-+
-+	qos_jpeg_enc: qos@fe158200 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe158200 0x0 0x20>;
-+	};
-+
-+	qos_rga_rd: qos@fe158280 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe158280 0x0 0x20>;
-+	};
-+
-+	qos_rga_wr: qos@fe158300 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe158300 0x0 0x20>;
-+	};
-+
-+	qos_npu: qos@fe180000 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe180000 0x0 0x20>;
-+	};
-+
-+	qos_pcie2x1: qos@fe190000 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe190000 0x0 0x20>;
-+	};
-+
-+	qos_sata1: qos@fe190280 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe190280 0x0 0x20>;
-+	};
-+
-+	qos_sata2: qos@fe190300 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe190300 0x0 0x20>;
-+	};
-+
-+	qos_usb3_0: qos@fe190380 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe190380 0x0 0x20>;
-+	};
-+
-+	qos_usb3_1: qos@fe190400 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe190400 0x0 0x20>;
-+	};
-+
-+	qos_rkvdec: qos@fe198000 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe198000 0x0 0x20>;
-+	};
-+
-+	qos_hdcp: qos@fe1a8000 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe1a8000 0x0 0x20>;
-+	};
-+
-+	qos_vop_m0: qos@fe1a8080 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe1a8080 0x0 0x20>;
-+	};
-+
-+	qos_vop_m1: qos@fe1a8100 {
-+		compatible = "rockchip,rk3568-qos", "syscon";
-+		reg = <0x0 0xfe1a8100 0x0 0x20>;
-+	};
-+
-+	pcie2x1: pcie@fe260000 {
-+		compatible = "rockchip,rk3568-pcie";
-+		#address-cells = <3>;
-+		#size-cells = <2>;
-+		bus-range = <0x0 0xf>;
-+		assigned-clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
-+			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
-+			 <&cru CLK_PCIE20_AUX_NDFT>;
-+		clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
-+			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
-+			 <&cru CLK_PCIE20_AUX_NDFT>;
-+		clock-names = "aclk_mst", "aclk_slv",
-+			      "aclk_dbi", "pclk", "aux";
-+		device_type = "pci";
-+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-+		interrupt-names = "sys", "pmc", "msi", "legacy", "err";
-+		#interrupt-cells = <1>;
-+		interrupt-map-mask = <0 0 0 7>;
-+		interrupt-map = <0 0 0 1 &pcie_intc 0>,
-+				<0 0 0 2 &pcie_intc 1>,
-+				<0 0 0 3 &pcie_intc 2>,
-+				<0 0 0 4 &pcie_intc 3>;
-+		linux,pci-domain = <0>;
-+		num-ib-windows = <6>;
-+		num-ob-windows = <2>;
-+		max-link-speed = <2>;
-+		msi-map = <0x0 &gic 0x0 0x1000>;
-+		num-lanes = <1>;
-+		phys = <&combphy2_psq PHY_TYPE_PCIE>;
-+		phy-names = "pcie-phy";
-+		power-domains = <&power RK3568_PD_PIPE>;
-+		reg = <0x3 0xc0000000 0x0 0x400000>,
-+		      <0x0 0xfe260000 0x0 0x10000>,
-+		      <0x3 0x3f800000 0x0 0x800000>;
-+		ranges = <0x1000000 0x0 0x7f700000 0x3 0x3f700000 0x0 0x00100000
-+			  0x2000000 0x0 0x40000000 0x3 0x00000000 0x0 0x3f700000>;
-+		reg-names = "dbi", "apb", "config";
-+		resets = <&cru SRST_PCIE20_POWERUP>;
-+		reset-names = "pipe";
-+		status = "disabled";
-+
-+		pcie_intc: legacy-interrupt-controller {
-+			#address-cells = <0>;
-+			#interrupt-cells = <1>;
-+			interrupt-controller;
-+			interrupt-parent = <&gic>;
-+			interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
-+		};
-+
-+	};
-+
-+	sdmmc0: mmc@fe2b0000 {
-+		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
-+		reg = <0x0 0xfe2b0000 0x0 0x4000>;
-+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru HCLK_SDMMC0>, <&cru CLK_SDMMC0>,
-+			 <&cru SCLK_SDMMC0_DRV>, <&cru SCLK_SDMMC0_SAMPLE>;
-+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-+		fifo-depth = <0x100>;
-+		max-frequency = <150000000>;
-+		resets = <&cru SRST_SDMMC0>;
-+		reset-names = "reset";
-+		status = "disabled";
-+	};
-+
-+	sdmmc1: mmc@fe2c0000 {
-+		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
-+		reg = <0x0 0xfe2c0000 0x0 0x4000>;
-+		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru HCLK_SDMMC1>, <&cru CLK_SDMMC1>,
-+			 <&cru SCLK_SDMMC1_DRV>, <&cru SCLK_SDMMC1_SAMPLE>;
-+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-+		fifo-depth = <0x100>;
-+		max-frequency = <150000000>;
-+		resets = <&cru SRST_SDMMC1>;
-+		reset-names = "reset";
-+		status = "disabled";
-+	};
-+
-+	sfc: spi@fe300000 {
-+		compatible = "rockchip,sfc";
-+		reg = <0x0 0xfe300000 0x0 0x4000>;
-+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
-+		clock-names = "clk_sfc", "hclk_sfc";
-+		pinctrl-0 = <&fspi_pins>;
-+		pinctrl-names = "default";
-+		status = "disabled";
-+	};
-+
-+	sdhci: mmc@fe310000 {
-+		compatible = "rockchip,rk3568-dwcmshc";
-+		reg = <0x0 0xfe310000 0x0 0x10000>;
-+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-+		assigned-clocks = <&cru BCLK_EMMC>, <&cru TCLK_EMMC>;
-+		assigned-clock-rates = <200000000>, <24000000>;
-+		clocks = <&cru CCLK_EMMC>, <&cru HCLK_EMMC>,
-+			 <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
-+			 <&cru TCLK_EMMC>;
-+		clock-names = "core", "bus", "axi", "block", "timer";
-+		status = "disabled";
-+	};
-+
-+	spdif: spdif@fe460000 {
-+		compatible = "rockchip,rk3568-spdif";
-+		reg = <0x0 0xfe460000 0x0 0x1000>;
-+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-+		clock-names = "mclk", "hclk";
-+		clocks = <&cru MCLK_SPDIF_8CH>, <&cru HCLK_SPDIF_8CH>;
-+		dmas = <&dmac1 1>;
-+		dma-names = "tx";
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&spdifm0_tx>;
-+		#sound-dai-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	i2s1_8ch: i2s@fe410000 {
-+		compatible = "rockchip,rk3568-i2s-tdm";
-+		reg = <0x0 0xfe410000 0x0 0x1000>;
-+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-+		assigned-clocks = <&cru CLK_I2S1_8CH_TX_SRC>, <&cru CLK_I2S1_8CH_RX_SRC>;
-+		assigned-clock-rates = <1188000000>, <1188000000>;
-+		clocks = <&cru MCLK_I2S1_8CH_TX>, <&cru MCLK_I2S1_8CH_RX>,
-+			 <&cru HCLK_I2S1_8CH>;
-+		clock-names = "mclk_tx", "mclk_rx", "hclk";
-+		dmas = <&dmac1 3>, <&dmac1 2>;
-+		dma-names = "rx", "tx";
-+		resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
-+		reset-names = "tx-m", "rx-m";
-+		rockchip,grf = <&grf>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&i2s1m0_sclktx &i2s1m0_sclkrx
-+			     &i2s1m0_lrcktx &i2s1m0_lrckrx
-+			     &i2s1m0_sdi0   &i2s1m0_sdi1
-+			     &i2s1m0_sdi2   &i2s1m0_sdi3
-+			     &i2s1m0_sdo0   &i2s1m0_sdo1
-+			     &i2s1m0_sdo2   &i2s1m0_sdo3>;
-+		#sound-dai-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	dmac0: dmac@fe530000 {
-+		compatible = "arm,pl330", "arm,primecell";
-+		reg = <0x0 0xfe530000 0x0 0x4000>;
-+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-+		arm,pl330-periph-burst;
-+		clocks = <&cru ACLK_BUS>;
-+		clock-names = "apb_pclk";
-+		#dma-cells = <1>;
-+	};
-+
-+	dmac1: dmac@fe550000 {
-+		compatible = "arm,pl330", "arm,primecell";
-+		reg = <0x0 0xfe550000 0x0 0x4000>;
-+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
-+			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-+		arm,pl330-periph-burst;
-+		clocks = <&cru ACLK_BUS>;
-+		clock-names = "apb_pclk";
-+		#dma-cells = <1>;
-+	};
-+
-+	i2c1: i2c@fe5a0000 {
-+		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
-+		reg = <0x0 0xfe5a0000 0x0 0x1000>;
-+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru CLK_I2C1>, <&cru PCLK_I2C1>;
-+		clock-names = "i2c", "pclk";
-+		pinctrl-0 = <&i2c1_xfer>;
-+		pinctrl-names = "default";
-+		#address-cells = <1>;
-+		#size-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	i2c2: i2c@fe5b0000 {
-+		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
-+		reg = <0x0 0xfe5b0000 0x0 0x1000>;
-+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru CLK_I2C2>, <&cru PCLK_I2C2>;
-+		clock-names = "i2c", "pclk";
-+		pinctrl-0 = <&i2c2m0_xfer>;
-+		pinctrl-names = "default";
-+		#address-cells = <1>;
-+		#size-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	i2c3: i2c@fe5c0000 {
-+		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
-+		reg = <0x0 0xfe5c0000 0x0 0x1000>;
-+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru CLK_I2C3>, <&cru PCLK_I2C3>;
-+		clock-names = "i2c", "pclk";
-+		pinctrl-0 = <&i2c3m0_xfer>;
-+		pinctrl-names = "default";
-+		#address-cells = <1>;
-+		#size-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	i2c4: i2c@fe5d0000 {
-+		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
-+		reg = <0x0 0xfe5d0000 0x0 0x1000>;
-+		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru CLK_I2C4>, <&cru PCLK_I2C4>;
-+		clock-names = "i2c", "pclk";
-+		pinctrl-0 = <&i2c4m0_xfer>;
-+		pinctrl-names = "default";
-+		#address-cells = <1>;
-+		#size-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	i2c5: i2c@fe5e0000 {
-+		compatible = "rockchip,rk3568-i2c", "rockchip,rk3399-i2c";
-+		reg = <0x0 0xfe5e0000 0x0 0x1000>;
-+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru CLK_I2C5>, <&cru PCLK_I2C5>;
-+		clock-names = "i2c", "pclk";
-+		pinctrl-0 = <&i2c5m0_xfer>;
-+		pinctrl-names = "default";
-+		#address-cells = <1>;
-+		#size-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	wdt: watchdog@fe600000 {
-+		compatible = "rockchip,rk3568-wdt", "snps,dw-wdt";
-+		reg = <0x0 0xfe600000 0x0 0x100>;
-+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru TCLK_WDT_NS>, <&cru PCLK_WDT_NS>;
-+		clock-names = "tclk", "pclk";
-+	};
-+
-+	uart1: serial@fe650000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfe650000 0x0 0x100>;
-+		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 2>, <&dmac0 3>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart1m0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	uart2: serial@fe660000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfe660000 0x0 0x100>;
-+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 4>, <&dmac0 5>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart2m0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	uart3: serial@fe670000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfe670000 0x0 0x100>;
-+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 6>, <&dmac0 7>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart3m0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	uart4: serial@fe680000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfe680000 0x0 0x100>;
-+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 8>, <&dmac0 9>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart4m0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	uart5: serial@fe690000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfe690000 0x0 0x100>;
-+		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_UART5>, <&cru PCLK_UART5>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 10>, <&dmac0 11>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart5m0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	uart6: serial@fe6a0000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfe6a0000 0x0 0x100>;
-+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_UART6>, <&cru PCLK_UART6>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 12>, <&dmac0 13>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart6m0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	uart7: serial@fe6b0000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfe6b0000 0x0 0x100>;
-+		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_UART7>, <&cru PCLK_UART7>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 14>, <&dmac0 15>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart7m0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	uart8: serial@fe6c0000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfe6c0000 0x0 0x100>;
-+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_UART8>, <&cru PCLK_UART8>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 16>, <&dmac0 17>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart8m0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	uart9: serial@fe6d0000 {
-+		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
-+		reg = <0x0 0xfe6d0000 0x0 0x100>;
-+		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru SCLK_UART9>, <&cru PCLK_UART9>;
-+		clock-names = "baudclk", "apb_pclk";
-+		dmas = <&dmac0 18>, <&dmac0 19>;
-+		dma-names = "tx", "rx";
-+		pinctrl-0 = <&uart9m0_xfer>;
-+		pinctrl-names = "default";
-+		reg-io-width = <4>;
-+		reg-shift = <2>;
-+		status = "disabled";
-+	};
-+
-+	thermal_zones: thermal-zones {
-+		cpu_thermal: cpu-thermal {
-+			polling-delay-passive = <100>;
-+			polling-delay = <1000>;
-+
-+			thermal-sensors = <&tsadc 0>;
-+
-+			trips {
-+				cpu_alert0: cpu_alert0 {
-+					temperature = <70000>;
-+					hysteresis = <2000>;
-+					type = "passive";
-+				};
-+				cpu_alert1: cpu_alert1 {
-+					temperature = <75000>;
-+					hysteresis = <2000>;
-+					type = "passive";
-+				};
-+				cpu_crit: cpu_crit {
-+					temperature = <95000>;
-+					hysteresis = <2000>;
-+					type = "critical";
-+				};
-+			};
-+
-+			cooling-maps {
-+				map0 {
-+					trip = <&cpu_alert0>;
-+					cooling-device =
-+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-+				};
-+			};
-+		};
-+
-+		gpu_thermal: gpu-thermal {
-+			polling-delay-passive = <20>; /* milliseconds */
-+			polling-delay = <1000>; /* milliseconds */
-+
-+			thermal-sensors = <&tsadc 1>;
-+		};
-+	};
-+
-+	tsadc: tsadc@fe710000 {
-+		compatible = "rockchip,rk3568-tsadc";
-+		reg = <0x0 0xfe710000 0x0 0x100>;
-+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-+		assigned-clocks = <&cru CLK_TSADC_TSEN>, <&cru CLK_TSADC>;
-+		assigned-clock-rates = <17000000>, <700000>;
-+		clocks = <&cru CLK_TSADC>, <&cru PCLK_TSADC>;
-+		clock-names = "tsadc", "apb_pclk";
-+		resets = <&cru SRST_P_TSADC>, <&cru SRST_TSADC>,
-+			 <&cru SRST_TSADCPHY>;
-+		rockchip,grf = <&grf>;
-+		rockchip,hw-tshut-temp = <95000>;
-+		pinctrl-names = "init", "default", "sleep";
-+		pinctrl-0 = <&tsadc_pin>;
-+		pinctrl-1 = <&tsadc_shutorg>;
-+		pinctrl-2 = <&tsadc_pin>;
-+		#thermal-sensor-cells = <1>;
-+		status = "disabled";
-+	};
-+
-+	saradc: saradc@fe720000 {
-+		compatible = "rockchip,rk3568-saradc", "rockchip,rk3399-saradc";
-+		reg = <0x0 0xfe720000 0x0 0x100>;
-+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
-+		clock-names = "saradc", "apb_pclk";
-+		resets = <&cru SRST_P_SARADC>;
-+		reset-names = "saradc-apb";
-+		#io-channel-cells = <1>;
-+		status = "disabled";
-+	};
-+
-+	pwm4: pwm@fe6e0000 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe6e0000 0x0 0x10>;
-+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm4_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm5: pwm@fe6e0010 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe6e0010 0x0 0x10>;
-+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm5_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm6: pwm@fe6e0020 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe6e0020 0x0 0x10>;
-+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm6_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm7: pwm@fe6e0030 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe6e0030 0x0 0x10>;
-+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm7_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm8: pwm@fe6f0000 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe6f0000 0x0 0x10>;
-+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm8m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm9: pwm@fe6f0010 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe6f0010 0x0 0x10>;
-+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm9m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm10: pwm@fe6f0020 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe6f0020 0x0 0x10>;
-+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm10m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm11: pwm@fe6f0030 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe6f0030 0x0 0x10>;
-+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm11m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm12: pwm@fe700000 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe700000 0x0 0x10>;
-+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm12m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm13: pwm@fe700010 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe700010 0x0 0x10>;
-+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm13m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm14: pwm@fe700020 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe700020 0x0 0x10>;
-+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm14m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	pwm15: pwm@fe700030 {
-+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
-+		reg = <0x0 0xfe700030 0x0 0x10>;
-+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
-+		clock-names = "pwm", "pclk";
-+		pinctrl-0 = <&pwm15m0_pins>;
-+		pinctrl-names = "active";
-+		#pwm-cells = <3>;
-+		status = "disabled";
-+	};
-+
-+	combphy1_usq: phy@fe830000 {
-+		compatible = "rockchip,rk3568-naneng-combphy";
-+		reg = <0x0 0xfe830000 0x0 0x100>;
-+		#phy-cells = <1>;
-+		assigned-clocks = <&pmucru CLK_PCIEPHY1_REF>;
-+		assigned-clock-rates = <100000000>;
-+		clocks = <&pmucru CLK_PCIEPHY1_REF>, <&cru PCLK_PIPEPHY1>,
-+			 <&cru PCLK_PIPE>;
-+		clock-names = "ref", "apb", "pipe";
-+		resets = <&cru SRST_P_PIPEPHY1>, <&cru SRST_PIPEPHY1>;
-+		reset-names = "combphy-apb", "combphy";
-+		rockchip,pipe-grf = <&pipegrf>;
-+		rockchip,pipe-phy-grf = <&pipe_phy_grf1>;
-+		status = "disabled";
-+	};
-+
-+	combphy2_psq: phy@fe840000 {
-+		compatible = "rockchip,rk3568-naneng-combphy";
-+		reg = <0x0 0xfe840000 0x0 0x100>;
-+		#phy-cells = <1>;
-+		assigned-clocks = <&pmucru CLK_PCIEPHY2_REF>;
-+		assigned-clock-rates = <100000000>;
-+		clocks = <&pmucru CLK_PCIEPHY2_REF>, <&cru PCLK_PIPEPHY2>,
-+			 <&cru PCLK_PIPE>;
-+		clock-names = "ref", "apb", "pipe";
-+		resets = <&cru SRST_P_PIPEPHY2>, <&cru SRST_PIPEPHY2>;
-+		reset-names = "combphy-apb", "combphy";
-+		rockchip,pipe-grf = <&pipegrf>;
-+		rockchip,pipe-phy-grf = <&pipe_phy_grf2>;
-+		status = "disabled";
-+	};
-+
-+	usb2phy0: usb2-phy@fe8a0000 {
-+		compatible = "rockchip,rk3568-usb2phy";
-+		reg = <0x0 0xfe8a0000 0x0 0x10000>;
-+		clocks = <&pmucru CLK_USBPHY0_REF>;
-+		clock-names = "phyclk";
-+		#clock-cells = <0>;
-+		clock-output-names = "usb480m_phy";
-+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
-+		rockchip,usbgrf = <&usb2phy0_grf>;
-+		status = "disabled";
-+
-+		u2phy0_host: host-port {
-+			#phy-cells = <0>;
-+			status = "disabled";
-+		};
-+
-+		u2phy0_otg: otg-port {
-+			#phy-cells = <0>;
-+			status = "disabled";
-+		};
-+	};
-+
-+	usb2phy1: usb2-phy@fe8b0000 {
-+		compatible = "rockchip,rk3568-usb2phy";
-+		reg = <0x0 0xfe8b0000 0x0 0x10000>;
-+		clocks = <&pmucru CLK_USBPHY1_REF>;
-+		clock-names = "phyclk";
-+		#clock-cells = <0>;
-+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-+		rockchip,usbgrf = <&usb2phy1_grf>;
-+		status = "disabled";
-+
-+		u2phy1_host: host-port {
-+			#phy-cells = <0>;
-+			status = "disabled";
-+		};
-+
-+		u2phy1_otg: otg-port {
-+			#phy-cells = <0>;
-+			status = "disabled";
-+		};
-+	};
-+
-+	pinctrl: pinctrl {
-+		compatible = "rockchip,rk3568-pinctrl";
-+		rockchip,grf = <&grf>;
-+		rockchip,pmu = <&pmugrf>;
-+		#address-cells = <2>;
-+		#size-cells = <2>;
-+		ranges;
-+
-+		gpio0: gpio@fdd60000 {
-+			compatible = "rockchip,gpio-bank";
-+			reg = <0x0 0xfdd60000 0x0 0x100>;
-+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-+			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
-+			gpio-controller;
-+			#gpio-cells = <2>;
-+			interrupt-controller;
-+			#interrupt-cells = <2>;
-+		};
-+
-+		gpio1: gpio@fe740000 {
-+			compatible = "rockchip,gpio-bank";
-+			reg = <0x0 0xfe740000 0x0 0x100>;
-+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-+			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
-+			gpio-controller;
-+			#gpio-cells = <2>;
-+			interrupt-controller;
-+			#interrupt-cells = <2>;
-+		};
-+
-+		gpio2: gpio@fe750000 {
-+			compatible = "rockchip,gpio-bank";
-+			reg = <0x0 0xfe750000 0x0 0x100>;
-+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-+			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
-+			gpio-controller;
-+			#gpio-cells = <2>;
-+			interrupt-controller;
-+			#interrupt-cells = <2>;
-+		};
-+
-+		gpio3: gpio@fe760000 {
-+			compatible = "rockchip,gpio-bank";
-+			reg = <0x0 0xfe760000 0x0 0x100>;
-+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-+			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
-+			gpio-controller;
-+			#gpio-cells = <2>;
-+			interrupt-controller;
-+			#interrupt-cells = <2>;
-+		};
-+
-+		gpio4: gpio@fe770000 {
-+			compatible = "rockchip,gpio-bank";
-+			reg = <0x0 0xfe770000 0x0 0x100>;
-+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-+			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
-+			gpio-controller;
-+			#gpio-cells = <2>;
-+			interrupt-controller;
-+			#interrupt-cells = <2>;
-+		};
-+	};
-+};
-+
-+#include "rk3568-pinctrl.dtsi"
---- a/arch/arm/mach-rockchip/rk3568/rk3568.c
-+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
-@@ -55,7 +55,7 @@ enum {
- };
- 
- const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
--	[BROM_BOOTSOURCE_EMMC] = "/sdhci@fe310000",
-+	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe310000",
- 	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe300000/flash@0",
- 	[BROM_BOOTSOURCE_SD] = "/mmc@fe2b0000",
- };
diff --git a/package/boot/uboot-rockchip/patches/005-rockchip-rk356x-HACK-fix-sdmmc-support.patch b/package/boot/uboot-rockchip/patches/005-rockchip-rk356x-HACK-fix-sdmmc-support.patch
deleted file mode 100644
index 10e4dd1198bc..000000000000
--- a/package/boot/uboot-rockchip/patches/005-rockchip-rk356x-HACK-fix-sdmmc-support.patch
+++ /dev/null
@@ -1,50 +0,0 @@
-From 01e8a38985a90043abddc5c5bcd049c74bb29a53 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Sun, 19 Dec 2021 18:52:18 -0500
-Subject: [PATCH 05/11] rockchip: rk356x: HACK: fix sdmmc support
-
-HACK: lock mmc0 to initial frequency and disable dw-mmc control of power
-line.
-
-The sdmmc on quartz64-a is powered by the sdmmc0 power line, which is
-active low.
-Even though it is set as a gpio, it still seems to be triggered by the
-dw-mmc driver toggling the power line.
-Downstream fixes this by setting this to "0" instead of "1" using
-kconfigs.
-
-Also, for some reason the controller will only operate at initial
-frequencies.
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi | 4 +++-
- drivers/mmc/dw_mmc.c                       | 3 ++-
- 2 files changed, 5 insertions(+), 2 deletions(-)
-
---- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
-+++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
-@@ -13,8 +13,10 @@
- };
- 
- &sdmmc0 {
-+	max-frequency = <400000>;
-+	bus-width = <4>;
- 	u-boot,dm-spl;
--	status = "okay";
-+	u-boot,spl-fifo-mode;
- };
- 
- &uart2 {
---- a/drivers/mmc/dw_mmc.c
-+++ b/drivers/mmc/dw_mmc.c
-@@ -529,7 +529,8 @@ static int dwmci_init(struct mmc *mmc)
- 	if (host->board_init)
- 		host->board_init(host);
- 
--	dwmci_writel(host, DWMCI_PWREN, 1);
-+//	dwmci_writel(host, DWMCI_PWREN, 1);
-+	dwmci_writel(host, DWMCI_PWREN, 0);
- 
- 	if (!dwmci_wait_reset(host, DWMCI_RESET_ALL)) {
- 		debug("%s[%d] Fail-reset!!\n", __func__, __LINE__);
diff --git a/package/boot/uboot-rockchip/patches/006-rockchip-rk356x-add-quartz64-a-board.patch b/package/boot/uboot-rockchip/patches/006-rockchip-rk356x-add-quartz64-a-board.patch
deleted file mode 100644
index 0a5d784b15bb..000000000000
--- a/package/boot/uboot-rockchip/patches/006-rockchip-rk356x-add-quartz64-a-board.patch
+++ /dev/null
@@ -1,214 +0,0 @@
-From 9f623c0e96fc7c3b5c9b7a81f0a3017c47033ec7 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Sun, 19 Dec 2021 18:57:36 -0500
-Subject: [PATCH 06/11] rockchip: rk356x: add quartz64-a board
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/mach-rockchip/rk3568/Kconfig         | 12 ++-
- board/pine64/quartz64-a-rk3566/Kconfig        | 15 ++++
- board/pine64/quartz64-a-rk3566/Makefile       |  4 +
- .../quartz64-a-rk3566/quartz64-a-rk3566.c     |  1 +
- configs/quartz64-a-rk3566_defconfig           | 77 +++++++++++++++++++
- include/configs/quartz64-a-rk3566.h           | 14 ++++
- include/dt-bindings/power/rk3568-power.h      | 32 ++++++++
- 7 files changed, 154 insertions(+), 1 deletion(-)
- create mode 100644 board/pine64/quartz64-a-rk3566/Kconfig
- create mode 100644 board/pine64/quartz64-a-rk3566/Makefile
- create mode 100644 board/pine64/quartz64-a-rk3566/quartz64-a-rk3566.c
- create mode 100644 configs/quartz64-a-rk3566_defconfig
- create mode 100644 include/configs/quartz64-a-rk3566.h
- create mode 100644 include/dt-bindings/power/rk3568-power.h
-
---- a/arch/arm/mach-rockchip/rk3568/Kconfig
-+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
-@@ -1,11 +1,20 @@
- if ROCKCHIP_RK3568
- 
-+choice
-+	prompt "RK3568/RK3566 board select"
-+
- config TARGET_EVB_RK3568
- 	bool "RK3568 evaluation board"
--	select BOARD_LATE_INIT
- 	help
- 	  RK3568 EVB is a evaluation board for Rockchp RK3568.
- 
-+config TARGET_QUARTZ64_A_RK3566
-+	bool "Quartz64 Model A RK3566 development board"
-+	help
-+	  Quartz64 Model A RK3566 is a development board from Pine64.
-+
-+endchoice
-+
- config ROCKCHIP_BOOT_MODE_REG
- 	default 0xfdc20200
- 
-@@ -19,5 +28,6 @@ config SYS_MALLOC_F_LEN
- 	default 0x2000
- 
- source "board/rockchip/evb_rk3568/Kconfig"
-+source "board/pine64/quartz64-a-rk3566/Kconfig"
- 
- endif
---- /dev/null
-+++ b/board/pine64/quartz64-a-rk3566/Kconfig
-@@ -0,0 +1,15 @@
-+if TARGET_QUARTZ64_A_RK3566
-+
-+config SYS_BOARD
-+	default "quartz64-a-rk3566"
-+
-+config SYS_VENDOR
-+	default "pine64"
-+
-+config SYS_CONFIG_NAME
-+	default "quartz64-a-rk3566"
-+
-+config BOARD_SPECIFIC_OPTIONS # dummy
-+	def_bool y
-+
-+endif
---- /dev/null
-+++ b/board/pine64/quartz64-a-rk3566/Makefile
-@@ -0,0 +1,4 @@
-+# SPDX-License-Identifier:     GPL-2.0+
-+#
-+
-+obj-y	+= quartz64-a-rk3566.o
---- /dev/null
-+++ b/board/pine64/quartz64-a-rk3566/quartz64-a-rk3566.c
-@@ -0,0 +1 @@
-+// SPDX-License-Identifier: GPL-2.0+
---- /dev/null
-+++ b/configs/quartz64-a-rk3566_defconfig
-@@ -0,0 +1,77 @@
-+CONFIG_ARM=y
-+CONFIG_SKIP_LOWLEVEL_INIT=y
-+CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
-+CONFIG_SPL_LIBCOMMON_SUPPORT=y
-+CONFIG_SPL_LIBGENERIC_SUPPORT=y
-+CONFIG_NR_DRAM_BANKS=2
-+CONFIG_DEFAULT_DEVICE_TREE="rk3566-quartz64-a"
-+CONFIG_ROCKCHIP_RK3568=y
-+CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
-+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
-+CONFIG_SPL_MMC=y
-+CONFIG_SPL_SERIAL=y
-+CONFIG_SPL_STACK_R_ADDR=0x600000
-+CONFIG_TARGET_QUARTZ64_A_RK3566=y
-+CONFIG_DEBUG_UART_BASE=0xFE660000
-+CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
-+CONFIG_SYS_LOAD_ADDR=0xc00800
-+CONFIG_API=y
-+CONFIG_FIT=y
-+CONFIG_FIT_VERBOSE=y
-+CONFIG_SPL_LOAD_FIT=y
-+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-quartz64-a.dtb"
-+# CONFIG_DISPLAY_CPUINFO is not set
-+CONFIG_DISPLAY_BOARDINFO_LATE=y
-+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-+CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
-+CONFIG_SPL_ATF=y
-+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
-+CONFIG_CMD_BIND=y
-+CONFIG_CMD_CLK=y
-+CONFIG_CMD_GPIO=y
-+CONFIG_CMD_GPT=y
-+CONFIG_CMD_I2C=y
-+CONFIG_CMD_MMC=y
-+# CONFIG_CMD_SETEXPR is not set
-+CONFIG_CMD_PMIC=y
-+CONFIG_CMD_REGULATOR=y
-+# CONFIG_SPL_DOS_PARTITION is not set
-+CONFIG_SPL_OF_CONTROL=y
-+CONFIG_OF_LIVE=y
-+CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_REGMAP=y
-+CONFIG_SPL_SYSCON=y
-+CONFIG_SPL_CLK=y
-+CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_SYS_I2C_ROCKCHIP=y
-+CONFIG_MISC=y
-+CONFIG_MMC_HS200_SUPPORT=y
-+CONFIG_SPL_MMC_HS200_SUPPORT=y
-+CONFIG_MMC_DW=y
-+CONFIG_MMC_DW_ROCKCHIP=y
-+CONFIG_MMC_SDHCI=y
-+CONFIG_MMC_SDHCI_SDMA=y
-+CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
-+CONFIG_ETH_DESIGNWARE=y
-+CONFIG_GMAC_ROCKCHIP=y
-+CONFIG_POWER_DOMAIN=y
-+CONFIG_DM_PMIC=y
-+CONFIG_PMIC_RK8XX=y
-+CONFIG_SPL_PMIC_RK8XX=y
-+CONFIG_REGULATOR_PWM=y
-+CONFIG_DM_REGULATOR_FIXED=y
-+CONFIG_SPL_DM_REGULATOR_FIXED=y
-+CONFIG_DM_REGULATOR_GPIO=y
-+CONFIG_REGULATOR_RK8XX=y
-+CONFIG_PWM_ROCKCHIP=y
-+CONFIG_SPL_RAM=y
-+CONFIG_DM_RESET=y
-+CONFIG_BAUDRATE=1500000
-+CONFIG_DEBUG_UART_SHIFT=2
-+CONFIG_SYSRESET=y
-+CONFIG_SYSRESET_PSCI=y
-+CONFIG_ERRNO_STR=y
---- /dev/null
-+++ b/include/configs/quartz64-a-rk3566.h
-@@ -0,0 +1,14 @@
-+/* SPDX-License-Identifier: GPL-2.0+ */
-+
-+#ifndef __QUARTZ64_A_RK3566_H
-+#define __QUARTZ64_A_RK3566_H
-+
-+#include <configs/rk3568_common.h>
-+
-+#define CONFIG_SUPPORT_EMMC_RPMB
-+
-+#define ROCKCHIP_DEVICE_SETTINGS \
-+			"stdout=serial,vidconsole\0" \
-+			"stderr=serial,vidconsole\0"
-+
-+#endif
---- /dev/null
-+++ b/include/dt-bindings/power/rk3568-power.h
-@@ -0,0 +1,32 @@
-+/* SPDX-License-Identifier: GPL-2.0 */
-+#ifndef __DT_BINDINGS_POWER_RK3568_POWER_H__
-+#define __DT_BINDINGS_POWER_RK3568_POWER_H__
-+
-+/* VD_CORE */
-+#define RK3568_PD_CPU_0		0
-+#define RK3568_PD_CPU_1		1
-+#define RK3568_PD_CPU_2		2
-+#define RK3568_PD_CPU_3		3
-+#define RK3568_PD_CORE_ALIVE	4
-+
-+/* VD_PMU */
-+#define RK3568_PD_PMU		5
-+
-+/* VD_NPU */
-+#define RK3568_PD_NPU		6
-+
-+/* VD_GPU */
-+#define RK3568_PD_GPU		7
-+
-+/* VD_LOGIC */
-+#define RK3568_PD_VI		8
-+#define RK3568_PD_VO		9
-+#define RK3568_PD_RGA		10
-+#define RK3568_PD_VPU		11
-+#define RK3568_PD_CENTER	12
-+#define RK3568_PD_RKVDEC	13
-+#define RK3568_PD_RKVENC	14
-+#define RK3568_PD_PIPE		15
-+#define RK3568_PD_LOGIC_ALIVE	16
-+
-+#endif
diff --git a/package/boot/uboot-rockchip/patches/007-gpio-rockchip-rk_gpio-support-v2-gpio-controller.patch b/package/boot/uboot-rockchip/patches/007-gpio-rockchip-rk_gpio-support-v2-gpio-controller.patch
deleted file mode 100644
index 3066eaaf4329..000000000000
--- a/package/boot/uboot-rockchip/patches/007-gpio-rockchip-rk_gpio-support-v2-gpio-controller.patch
+++ /dev/null
@@ -1,755 +0,0 @@
-From 3a4d973a743bc76cc734db9616f9053f45fa922f Mon Sep 17 00:00:00 2001
-From: Jianqun Xu <jay.xu@rock-chips.com>
-Date: Thu, 28 May 2020 11:01:58 +0800
-Subject: [PATCH 07/11] gpio/rockchip: rk_gpio support v2 gpio controller
-
-The v2 gpio controller add write enable bit for some register,
-such as data register, data direction register and so on.
-
-This patch support v2 gpio controller by redefine the read and
-write operation functions.
-
-Also adds support for the rk3568 pinctrl device.
-
-Squash all fixes into this commit.
-
-Change-Id: I2adbcca06a37c48e6f494b89833cd034ba0dae29
-Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/include/asm/arch-rockchip/gpio.h     |  36 ++
- drivers/gpio/Kconfig                          |  13 +
- drivers/gpio/rk_gpio.c                        |  89 ++++-
- drivers/pinctrl/rockchip/Makefile             |   1 +
- drivers/pinctrl/rockchip/pinctrl-rk3568.c     | 360 ++++++++++++++++++
- .../pinctrl/rockchip/pinctrl-rockchip-core.c  |  11 +-
- drivers/pinctrl/rockchip/pinctrl-rockchip.h   |  42 ++
- 7 files changed, 530 insertions(+), 22 deletions(-)
- create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3568.c
-
---- a/arch/arm/include/asm/arch-rockchip/gpio.h
-+++ b/arch/arm/include/asm/arch-rockchip/gpio.h
-@@ -6,6 +6,7 @@
- #ifndef _ASM_ARCH_GPIO_H
- #define _ASM_ARCH_GPIO_H
- 
-+#ifndef CONFIG_ROCKCHIP_GPIO_V2
- struct rockchip_gpio_regs {
- 	u32 swport_dr;
- 	u32 swport_ddr;
-@@ -23,6 +24,41 @@ struct rockchip_gpio_regs {
- 	u32 ls_sync;
- };
- check_member(rockchip_gpio_regs, ls_sync, 0x60);
-+#else
-+struct rockchip_gpio_regs {
-+	u32 swport_dr_l;                        /* ADDRESS OFFSET: 0x0000 */
-+	u32 swport_dr_h;                        /* ADDRESS OFFSET: 0x0004 */
-+	u32 swport_ddr_l;                       /* ADDRESS OFFSET: 0x0008 */
-+	u32 swport_ddr_h;                       /* ADDRESS OFFSET: 0x000c */
-+	u32 int_en_l;                           /* ADDRESS OFFSET: 0x0010 */
-+	u32 int_en_h;                           /* ADDRESS OFFSET: 0x0014 */
-+	u32 int_mask_l;                         /* ADDRESS OFFSET: 0x0018 */
-+	u32 int_mask_h;                         /* ADDRESS OFFSET: 0x001c */
-+	u32 int_type_l;                         /* ADDRESS OFFSET: 0x0020 */
-+	u32 int_type_h;                         /* ADDRESS OFFSET: 0x0024 */
-+	u32 int_polarity_l;                     /* ADDRESS OFFSET: 0x0028 */
-+	u32 int_polarity_h;                     /* ADDRESS OFFSET: 0x002c */
-+	u32 int_bothedge_l;                     /* ADDRESS OFFSET: 0x0030 */
-+	u32 int_bothedge_h;                     /* ADDRESS OFFSET: 0x0034 */
-+	u32 debounce_l;                         /* ADDRESS OFFSET: 0x0038 */
-+	u32 debounce_h;                         /* ADDRESS OFFSET: 0x003c */
-+	u32 dbclk_div_en_l;                     /* ADDRESS OFFSET: 0x0040 */
-+	u32 dbclk_div_en_h;                     /* ADDRESS OFFSET: 0x0044 */
-+	u32 dbclk_div_con;                      /* ADDRESS OFFSET: 0x0048 */
-+	u32 reserved004c;                       /* ADDRESS OFFSET: 0x004c */
-+	u32 int_status;                         /* ADDRESS OFFSET: 0x0050 */
-+	u32 reserved0054;                       /* ADDRESS OFFSET: 0x0054 */
-+	u32 int_rawstatus;                      /* ADDRESS OFFSET: 0x0058 */
-+	u32 reserved005c;                       /* ADDRESS OFFSET: 0x005c */
-+	u32 port_eoi_l;                         /* ADDRESS OFFSET: 0x0060 */
-+	u32 port_eoi_h;                         /* ADDRESS OFFSET: 0x0064 */
-+	u32 reserved0068[2];                    /* ADDRESS OFFSET: 0x0068 */
-+	u32 ext_port;                           /* ADDRESS OFFSET: 0x0070 */
-+	u32 reserved0074;                       /* ADDRESS OFFSET: 0x0074 */
-+	u32 ver_id;                             /* ADDRESS OFFSET: 0x0078 */
-+};
-+check_member(rockchip_gpio_regs, ver_id, 0x0078);
-+#endif
- 
- enum gpio_pu_pd {
- 	GPIO_PULL_NORMAL = 0,
---- a/drivers/gpio/Kconfig
-+++ b/drivers/gpio/Kconfig
-@@ -341,6 +341,19 @@ config ROCKCHIP_GPIO
- 	  The GPIOs for a device are defined in the device tree with one node
- 	  for each bank.
- 
-+config ROCKCHIP_GPIO_V2
-+	bool "Rockchip GPIO driver version 2.0"
-+	depends on ROCKCHIP_GPIO
-+	default n
-+	help
-+	  Support GPIO access on Rockchip SoCs. The GPIOs are arranged into
-+	  a number of banks (different for each SoC type) each with 32 GPIOs.
-+	  The GPIOs for a device are defined in the device tree with one node
-+	  for each bank.
-+
-+	  Support version 2.0 GPIO controller, which support write enable bits
-+	  for some registers, such as dr, ddr.
-+
- config SANDBOX_GPIO
- 	bool "Enable sandbox GPIO driver"
- 	depends on SANDBOX && DM && DM_GPIO
---- a/drivers/gpio/rk_gpio.c
-+++ b/drivers/gpio/rk_gpio.c
-@@ -2,12 +2,15 @@
- /*
-  * (C) Copyright 2015 Google, Inc
-  *
-- * (C) Copyright 2008-2014 Rockchip Electronics
-+ * (C) Copyright 2008-2020 Rockchip Electronics
-  * Peter, Software Engineering, <superpeter.cai@gmail.com>.
-+ * Jianqun Xu, Software Engineering, <jay.xu@rock-chips.com>.
-  */
- 
- #include <common.h>
- #include <dm.h>
-+#include <dm/of_access.h>
-+#include <dm/device_compat.h>
- #include <syscon.h>
- #include <linux/errno.h>
- #include <asm/gpio.h>
-@@ -17,12 +20,34 @@
- #include <dm/pinctrl.h>
- #include <dt-bindings/clock/rk3288-cru.h>
- 
--enum {
--	ROCKCHIP_GPIOS_PER_BANK		= 32,
--};
-+#include "../pinctrl/rockchip/pinctrl-rockchip.h"
- 
- #define OFFSET_TO_BIT(bit)	(1UL << (bit))
- 
-+#ifdef CONFIG_ROCKCHIP_GPIO_V2
-+#define REG_L(R)	(R##_l)
-+#define REG_H(R)	(R##_h)
-+#define READ_REG(REG)	((readl(REG_L(REG)) & 0xFFFF) | \
-+			((readl(REG_H(REG)) & 0xFFFF) << 16))
-+#define WRITE_REG(REG, VAL)	\
-+{\
-+	writel(((VAL) & 0xFFFF) | 0xFFFF0000, REG_L(REG)); \
-+	writel((((VAL) & 0xFFFF0000) >> 16) | 0xFFFF0000, REG_H(REG));\
-+}
-+#define CLRBITS_LE32(REG, MASK)	WRITE_REG(REG, READ_REG(REG) & ~(MASK))
-+#define SETBITS_LE32(REG, MASK)	WRITE_REG(REG, READ_REG(REG) | (MASK))
-+#define CLRSETBITS_LE32(REG, MASK, VAL)	WRITE_REG(REG, \
-+				(READ_REG(REG) & ~(MASK)) | (VAL))
-+
-+#else
-+#define READ_REG(REG)			readl(REG)
-+#define WRITE_REG(REG, VAL)		writel(VAL, REG)
-+#define CLRBITS_LE32(REG, MASK)		clrbits_le32(REG, MASK)
-+#define SETBITS_LE32(REG, MASK)		setbits_le32(REG, MASK)
-+#define CLRSETBITS_LE32(REG, MASK, VAL)	clrsetbits_le32(REG, MASK, VAL)
-+#endif
-+
-+
- struct rockchip_gpio_priv {
- 	struct rockchip_gpio_regs *regs;
- 	struct udevice *pinctrl;
-@@ -35,7 +60,7 @@ static int rockchip_gpio_direction_input
- 	struct rockchip_gpio_priv *priv = dev_get_priv(dev);
- 	struct rockchip_gpio_regs *regs = priv->regs;
- 
--	clrbits_le32(&regs->swport_ddr, OFFSET_TO_BIT(offset));
-+	CLRBITS_LE32(&regs->swport_ddr, OFFSET_TO_BIT(offset));
- 
- 	return 0;
- }
-@@ -47,8 +72,8 @@ static int rockchip_gpio_direction_outpu
- 	struct rockchip_gpio_regs *regs = priv->regs;
- 	int mask = OFFSET_TO_BIT(offset);
- 
--	clrsetbits_le32(&regs->swport_dr, mask, value ? mask : 0);
--	setbits_le32(&regs->swport_ddr, mask);
-+	CLRSETBITS_LE32(&regs->swport_dr, mask, value ? mask : 0);
-+	SETBITS_LE32(&regs->swport_ddr, mask);
- 
- 	return 0;
- }
-@@ -68,7 +93,7 @@ static int rockchip_gpio_set_value(struc
- 	struct rockchip_gpio_regs *regs = priv->regs;
- 	int mask = OFFSET_TO_BIT(offset);
- 
--	clrsetbits_le32(&regs->swport_dr, mask, value ? mask : 0);
-+	CLRSETBITS_LE32(&regs->swport_dr, mask, value ? mask : 0);
- 
- 	return 0;
- }
-@@ -86,8 +111,8 @@ static int rockchip_gpio_get_function(st
- 	ret = pinctrl_get_gpio_mux(priv->pinctrl, priv->bank, offset);
- 	if (ret)
- 		return ret;
--	is_output = readl(&regs->swport_ddr) & OFFSET_TO_BIT(offset);
--
-+	is_output = READ_REG(&regs->swport_ddr) & OFFSET_TO_BIT(offset);
-+	
- 	return is_output ? GPIOF_OUTPUT : GPIOF_INPUT;
- #endif
- }
-@@ -142,19 +167,49 @@ static int rockchip_gpio_probe(struct ud
- {
- 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
- 	struct rockchip_gpio_priv *priv = dev_get_priv(dev);
--	char *end;
--	int ret;
-+	struct rockchip_pinctrl_priv *pctrl_priv;
-+	struct rockchip_pin_bank *bank;
-+	char *end = NULL;
-+	static int gpio;
-+	int id = -1, ret;
- 
- 	priv->regs = dev_read_addr_ptr(dev);
- 	ret = uclass_first_device_err(UCLASS_PINCTRL, &priv->pinctrl);
--	if (ret)
-+	if (ret) {
-+		dev_err(dev, "failed to get pinctrl device %d\n", ret);
- 		return ret;
-+	}
-+
-+	pctrl_priv = dev_get_priv(priv->pinctrl);
-+	if (!pctrl_priv) {
-+		dev_err(dev, "failed to get pinctrl priv\n");
-+		return -EINVAL;
-+	}
- 
--	uc_priv->gpio_count = ROCKCHIP_GPIOS_PER_BANK;
- 	end = strrchr(dev->name, '@');
--	priv->bank = trailing_strtoln(dev->name, end);
--	priv->name[0] = 'A' + priv->bank;
--	uc_priv->bank_name = priv->name;
-+	if (end)
-+		id = trailing_strtoln(dev->name, end);
-+	else
-+		dev_read_alias_seq(dev, &id);
-+
-+	if (id < 0)
-+		id = gpio++;
-+
-+	if (id >= pctrl_priv->ctrl->nr_banks) {
-+		dev_err(dev, "bank id invalid\n");
-+		return -EINVAL;
-+	}
-+
-+	bank = &pctrl_priv->ctrl->pin_banks[id];
-+	if (bank->bank_num != id) {
-+		dev_err(dev, "bank id mismatch with pinctrl\n");
-+		return -EINVAL;
-+	}
-+
-+	priv->bank = bank->bank_num;
-+	uc_priv->gpio_count = bank->nr_pins;
-+	uc_priv->gpio_base = bank->pin_base;
-+	uc_priv->bank_name = bank->name;
- 
- 	return 0;
- }
---- a/drivers/pinctrl/rockchip/Makefile
-+++ b/drivers/pinctrl/rockchip/Makefile
-@@ -14,4 +14,5 @@ obj-$(CONFIG_ROCKCHIP_RK3308) += pinctrl
- obj-$(CONFIG_ROCKCHIP_RK3328) += pinctrl-rk3328.o
- obj-$(CONFIG_ROCKCHIP_RK3368) += pinctrl-rk3368.o
- obj-$(CONFIG_ROCKCHIP_RK3399) += pinctrl-rk3399.o
-+obj-$(CONFIG_ROCKCHIP_RK3568) += pinctrl-rk3568.o
- obj-$(CONFIG_ROCKCHIP_RV1108) += pinctrl-rv1108.o
---- /dev/null
-+++ b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
-@@ -0,0 +1,360 @@
-+// SPDX-License-Identifier: GPL-2.0+
-+/*
-+ * (C) Copyright 2020 Rockchip Electronics Co., Ltd
-+ */
-+
-+#include <common.h>
-+#include <dm.h>
-+#include <dm/pinctrl.h>
-+#include <regmap.h>
-+#include <syscon.h>
-+
-+#include "pinctrl-rockchip.h"
-+
-+static struct rockchip_mux_route_data rk3568_mux_route_data[] = {
-+	MR_TOPGRF(RK_GPIO0, RK_PB3, RK_FUNC_2, 0x0300, RK_GENMASK_VAL(0, 0, 0)), /* CAN0 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO2, RK_PA1, RK_FUNC_4, 0x0300, RK_GENMASK_VAL(0, 0, 1)), /* CAN0 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO1, RK_PA1, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(2, 2, 0)), /* CAN1 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO4, RK_PC3, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(2, 2, 1)), /* CAN1 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO4, RK_PB5, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(4, 4, 0)), /* CAN2 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO2, RK_PB2, RK_FUNC_4, 0x0300, RK_GENMASK_VAL(4, 4, 1)), /* CAN2 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO4, RK_PC4, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(6, 6, 0)), /* EDPDP_HPDIN IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO0, RK_PC2, RK_FUNC_2, 0x0300, RK_GENMASK_VAL(6, 6, 1)), /* EDPDP_HPDIN IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PB1, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(8, 8, 0)), /* GMAC1 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO4, RK_PA7, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(8, 8, 1)), /* GMAC1 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO4, RK_PD1, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(10, 10, 0)), /* HDMITX IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO0, RK_PC7, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(10, 10, 1)), /* HDMITX IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO0, RK_PB6, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(14, 14, 0)), /* I2C2 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO4, RK_PB4, RK_FUNC_1, 0x0300, RK_GENMASK_VAL(14, 14, 1)), /* I2C2 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO1, RK_PA0, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(0, 0, 0)), /* I2C3 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PB6, RK_FUNC_4, 0x0304, RK_GENMASK_VAL(0, 0, 1)), /* I2C3 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO4, RK_PB2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(2, 2, 0)), /* I2C4 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO2, RK_PB1, RK_FUNC_2, 0x0304, RK_GENMASK_VAL(2, 2, 1)), /* I2C4 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PB4, RK_FUNC_4, 0x0304, RK_GENMASK_VAL(4, 4, 0)), /* I2C5 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO4, RK_PD0, RK_FUNC_2, 0x0304, RK_GENMASK_VAL(4, 4, 1)), /* I2C5 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(6, 6, 0)), /* PWM4 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(6, 6, 1)), /* PWM4 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(8, 8, 0)), /* PWM5 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(8, 8, 1)), /* PWM5 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(10, 10, 0)), /* PWM6 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(10, 10, 1)), /* PWM6 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(12, 12, 0)), /* PWM7 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(12, 12, 1)), /* PWM7 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(14, 14, 0)), /* PWM8 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(14, 14, 1)), /* PWM8 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(0, 0, 0)), /* PWM9 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(0, 0, 1)), /* PWM9 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(2, 2, 0)), /* PWM10 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(2, 2, 1)), /* PWM10 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(4, 4, 0)), /* PWM11 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(4, 4, 1)), /* PWM11 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(6, 6, 0)), /* PWM12 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(6, 6, 1)), /* PWM12 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(8, 8, 0)), /* PWM13 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(8, 8, 1)), /* PWM13 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(10, 10, 0)), /* PWM14 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(10, 10, 1)), /* PWM14 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(12, 12, 0)), /* PWM15 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(12, 12, 1)), /* PWM15 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_3, 0x0308, RK_GENMASK_VAL(14, 14, 0)), /* SDMMC2 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PA5, RK_FUNC_5, 0x0308, RK_GENMASK_VAL(14, 14, 1)), /* SDMMC2 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO0, RK_PB5, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(0, 0, 0)), /* SPI0 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO2, RK_PD3, RK_FUNC_3, 0x030c, RK_GENMASK_VAL(0, 0, 1)), /* SPI0 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO2, RK_PB5, RK_FUNC_3, 0x030c, RK_GENMASK_VAL(2, 2, 0)), /* SPI1 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PC3, RK_FUNC_3, 0x030c, RK_GENMASK_VAL(2, 2, 1)), /* SPI1 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO2, RK_PC1, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(4, 4, 0)), /* SPI2 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PA0, RK_FUNC_3, 0x030c, RK_GENMASK_VAL(4, 4, 1)), /* SPI2 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO4, RK_PB3, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(6, 6, 0)), /* SPI3 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(6, 6, 1)), /* SPI3 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO2, RK_PB4, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(8, 8, 0)), /* UART1 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO0, RK_PD1, RK_FUNC_1, 0x030c, RK_GENMASK_VAL(8, 8, 1)), /* UART1 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO0, RK_PD1, RK_FUNC_1, 0x030c, RK_GENMASK_VAL(10, 10, 0)), /* UART2 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO1, RK_PD5, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(10, 10, 1)), /* UART2 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO1, RK_PA1, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(12, 12, 0)), /* UART3 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PB7, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(12, 12, 1)), /* UART3 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO1, RK_PA6, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(14, 14, 0)), /* UART4 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PB2, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(14, 14, 1)), /* UART4 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO2, RK_PA2, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(0, 0, 0)), /* UART5 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PC2, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(0, 0, 1)), /* UART5 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO2, RK_PA4, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(2, 2, 0)), /* UART6 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO1, RK_PD5, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(2, 2, 1)), /* UART6 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO2, RK_PA6, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(5, 4, 0)), /* UART7 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PC4, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(5, 4, 1)), /* UART7 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0310, RK_GENMASK_VAL(5, 4, 2)), /* UART7 IO mux selection M2 */
-+	MR_TOPGRF(RK_GPIO2, RK_PC5, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(6, 6, 0)), /* UART8 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO2, RK_PD7, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(6, 6, 1)), /* UART8 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO2, RK_PB0, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(9, 8, 0)), /* UART9 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO4, RK_PC5, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(9, 8, 1)), /* UART9 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO4, RK_PA4, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(9, 8, 2)), /* UART9 IO mux selection M2 */
-+	MR_TOPGRF(RK_GPIO1, RK_PA2, RK_FUNC_1, 0x0310, RK_GENMASK_VAL(11, 10, 0)), /* I2S1 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PC6, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(11, 10, 1)), /* I2S1 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO2, RK_PD0, RK_FUNC_5, 0x0310, RK_GENMASK_VAL(11, 10, 2)), /* I2S1 IO mux selection M2 */
-+	MR_TOPGRF(RK_GPIO2, RK_PC1, RK_FUNC_1, 0x0310, RK_GENMASK_VAL(12, 12, 0)), /* I2S2 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO4, RK_PB6, RK_FUNC_5, 0x0310, RK_GENMASK_VAL(12, 12, 1)), /* I2S2 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO3, RK_PA2, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(14, 14, 0)), /* I2S3 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_5, 0x0310, RK_GENMASK_VAL(14, 14, 1)), /* I2S3 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO1, RK_PA6, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(0, 0, 0)), /* PDM IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO3, RK_PD6, RK_FUNC_5, 0x0314, RK_GENMASK_VAL(0, 0, 1)), /* PDM IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO0, RK_PA5, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(3, 2, 0)), /* PCIE20 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO2, RK_PD0, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(3, 2, 1)), /* PCIE20 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO1, RK_PB0, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(3, 2, 2)), /* PCIE20 IO mux selection M2 */
-+	MR_TOPGRF(RK_GPIO0, RK_PA4, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(5, 4, 0)), /* PCIE30X1 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO2, RK_PD2, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(5, 4, 1)), /* PCIE30X1 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO1, RK_PA5, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(5, 4, 2)), /* PCIE30X1 IO mux selection M2 */
-+	MR_TOPGRF(RK_GPIO0, RK_PA6, RK_FUNC_2, 0x0314, RK_GENMASK_VAL(7, 6, 0)), /* PCIE30X2 IO mux selection M0 */
-+	MR_TOPGRF(RK_GPIO2, RK_PD4, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(7, 6, 1)), /* PCIE30X2 IO mux selection M1 */
-+	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(7, 6, 2)), /* PCIE30X2 IO mux selection M2 */
-+};
-+
-+static int rk3568_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
-+{
-+	struct rockchip_pinctrl_priv *priv = bank->priv;
-+	int iomux_num = (pin / 8);
-+	struct regmap *regmap;
-+	int reg, ret, mask;
-+	u8 bit;
-+	u32 data;
-+
-+	debug("setting mux of GPIO%d-%d to %d\n", bank->bank_num, pin, mux);
-+
-+	if (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
-+		regmap = priv->regmap_pmu;
-+	else
-+		regmap = priv->regmap_base;
-+
-+	reg = bank->iomux[iomux_num].offset;
-+	if ((pin % 8) >= 4)
-+		reg += 0x4;
-+	bit = (pin % 4) * 4;
-+	mask = 0xf;
-+
-+	data = (mask << (bit + 16));
-+	data |= (mux & mask) << bit;
-+	ret = regmap_write(regmap, reg, data);
-+
-+	return ret;
-+}
-+
-+#define RK3568_PULL_PMU_OFFSET		0x20
-+#define RK3568_PULL_GRF_OFFSET		0x80
-+#define RK3568_PULL_BITS_PER_PIN	2
-+#define RK3568_PULL_PINS_PER_REG	8
-+#define RK3568_PULL_BANK_STRIDE		0x10
-+
-+static void rk3568_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
-+					 int pin_num, struct regmap **regmap,
-+					 int *reg, u8 *bit)
-+{
-+	struct rockchip_pinctrl_priv *info = bank->priv;
-+
-+	if (bank->bank_num == 0) {
-+		*regmap = info->regmap_pmu;
-+		*reg = RK3568_PULL_PMU_OFFSET;
-+		*reg += bank->bank_num * RK3568_PULL_BANK_STRIDE;
-+	} else {
-+		*regmap = info->regmap_base;
-+		*reg = RK3568_PULL_GRF_OFFSET;
-+		*reg += (bank->bank_num - 1) * RK3568_PULL_BANK_STRIDE;
-+	}
-+
-+	*reg += ((pin_num / RK3568_PULL_PINS_PER_REG) * 4);
-+	*bit = (pin_num % RK3568_PULL_PINS_PER_REG);
-+	*bit *= RK3568_PULL_BITS_PER_PIN;
-+}
-+
-+#define RK3568_DRV_PMU_OFFSET		0x70
-+#define RK3568_DRV_GRF_OFFSET		0x200
-+#define RK3568_DRV_BITS_PER_PIN		8
-+#define RK3568_DRV_PINS_PER_REG		2
-+#define RK3568_DRV_BANK_STRIDE		0x40
-+
-+static void rk3568_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
-+					int pin_num, struct regmap **regmap,
-+					int *reg, u8 *bit)
-+{
-+	struct rockchip_pinctrl_priv *info = bank->priv;
-+
-+	/* The first 32 pins of the first bank are located in PMU */
-+	if (bank->bank_num == 0) {
-+		*regmap = info->regmap_pmu;
-+		*reg = RK3568_DRV_PMU_OFFSET;
-+	} else {
-+		*regmap = info->regmap_base;
-+		*reg = RK3568_DRV_GRF_OFFSET;
-+		*reg += (bank->bank_num - 1) * RK3568_DRV_BANK_STRIDE;
-+	}
-+
-+	*reg += ((pin_num / RK3568_DRV_PINS_PER_REG) * 4);
-+	*bit = (pin_num % RK3568_DRV_PINS_PER_REG);
-+	*bit *= RK3568_DRV_BITS_PER_PIN;
-+}
-+
-+#define RK3568_SCHMITT_BITS_PER_PIN		2
-+#define RK3568_SCHMITT_PINS_PER_REG		8
-+#define RK3568_SCHMITT_BANK_STRIDE		0x10
-+#define RK3568_SCHMITT_GRF_OFFSET		0xc0
-+#define RK3568_SCHMITT_PMUGRF_OFFSET		0x30
-+
-+static int rk3568_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
-+					   int pin_num, struct regmap **regmap,
-+					   int *reg, u8 *bit)
-+{
-+	struct rockchip_pinctrl_priv *info = bank->priv;
-+
-+	if (bank->bank_num == 0) {
-+		*regmap = info->regmap_pmu;
-+		*reg = RK3568_SCHMITT_PMUGRF_OFFSET;
-+	} else {
-+		*regmap = info->regmap_base;
-+		*reg = RK3568_SCHMITT_GRF_OFFSET;
-+		*reg += (bank->bank_num - 1) * RK3568_SCHMITT_BANK_STRIDE;
-+	}
-+
-+	*reg += ((pin_num / RK3568_SCHMITT_PINS_PER_REG) * 4);
-+	*bit = pin_num % RK3568_SCHMITT_PINS_PER_REG;
-+	*bit *= RK3568_SCHMITT_BITS_PER_PIN;
-+
-+	return 0;
-+}
-+
-+static int rk3568_set_pull(struct rockchip_pin_bank *bank,
-+			   int pin_num, int pull)
-+{
-+	struct regmap *regmap;
-+	int reg, ret;
-+	u8 bit, type;
-+	u32 data;
-+
-+	if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT)
-+		return -ENOTSUPP;
-+
-+	rk3568_calc_pull_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
-+	type = bank->pull_type[pin_num / 8];
-+	ret = rockchip_translate_pull_value(type, pull);
-+	if (ret < 0) {
-+		debug("unsupported pull setting %d\n", pull);
-+		return ret;
-+	}
-+
-+	/* enable the write to the equivalent lower bits */
-+	data = ((1 << ROCKCHIP_PULL_BITS_PER_PIN) - 1) << (bit + 16);
-+
-+	data |= (ret << bit);
-+	ret = regmap_write(regmap, reg, data);
-+
-+	return ret;
-+}
-+
-+static int rk3568_set_drive(struct rockchip_pin_bank *bank,
-+			    int pin_num, int strength)
-+{
-+	struct regmap *regmap;
-+	int reg;
-+	u32 data;
-+	u8 bit;
-+	int drv = (1 << (strength + 1)) - 1;
-+	int ret = 0;
-+
-+	rk3568_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
-+
-+	/* enable the write to the equivalent lower bits */
-+	data = ((1 << RK3568_DRV_BITS_PER_PIN) - 1) << (bit + 16);
-+	data |= (drv << bit);
-+
-+	ret = regmap_write(regmap, reg, data);
-+	if (ret)
-+		return ret;
-+
-+	if (bank->bank_num == 1 && pin_num == 21)
-+		reg = 0x0840;
-+	else if (bank->bank_num == 2 && pin_num == 2)
-+		reg = 0x0844;
-+	else if (bank->bank_num == 2 && pin_num == 8)
-+		reg = 0x0848;
-+	else if (bank->bank_num == 3 && pin_num == 0)
-+		reg = 0x084c;
-+	else if (bank->bank_num == 3 && pin_num == 6)
-+		reg = 0x0850;
-+	else if (bank->bank_num == 4 && pin_num == 0)
-+		reg = 0x0854;
-+	else
-+		return 0;
-+
-+	data = ((1 << RK3568_DRV_BITS_PER_PIN) - 1) << 16;
-+	data |= drv;
-+
-+	return regmap_write(regmap, reg, data);
-+}
-+
-+static int rk3568_set_schmitt(struct rockchip_pin_bank *bank,
-+			      int pin_num, int enable)
-+{
-+	struct regmap *regmap;
-+	int reg;
-+	u32 data;
-+	u8 bit;
-+
-+	rk3568_calc_schmitt_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
-+
-+	/* enable the write to the equivalent lower bits */
-+	data = ((1 << RK3568_SCHMITT_BITS_PER_PIN) - 1) << (bit + 16);
-+	data |= (enable << bit);
-+
-+	return regmap_write(regmap, reg, data);
-+}
-+static struct rockchip_pin_bank rk3568_pin_banks[] = {
-+	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", IOMUX_SOURCE_PMU | IOMUX_WIDTH_4BIT,
-+			     IOMUX_SOURCE_PMU | IOMUX_WIDTH_4BIT,
-+			     IOMUX_SOURCE_PMU | IOMUX_WIDTH_4BIT,
-+			     IOMUX_SOURCE_PMU | IOMUX_WIDTH_4BIT),
-+	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT),
-+	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT),
-+	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3", IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT),
-+	PIN_BANK_IOMUX_FLAGS(4, 32, "gpio4", IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT,
-+			     IOMUX_WIDTH_4BIT),
-+};
-+
-+static const struct rockchip_pin_ctrl rk3568_pin_ctrl = {
-+	.pin_banks		= rk3568_pin_banks,
-+	.nr_banks		= ARRAY_SIZE(rk3568_pin_banks),
-+	.nr_pins		= 160,
-+	.grf_mux_offset		= 0x0,
-+	.pmu_mux_offset		= 0x0,
-+	.iomux_routes		= rk3568_mux_route_data,
-+	.niomux_routes		= ARRAY_SIZE(rk3568_mux_route_data),
-+	.set_mux		= rk3568_set_mux,
-+	.set_pull		= rk3568_set_pull,
-+	.set_drive		= rk3568_set_drive,
-+	.set_schmitt		= rk3568_set_schmitt,
-+};
-+
-+static const struct udevice_id rk3568_pinctrl_ids[] = {
-+	{
-+		.compatible = "rockchip,rk3568-pinctrl",
-+		.data = (ulong)&rk3568_pin_ctrl
-+	},
-+	{ }
-+};
-+
-+U_BOOT_DRIVER(pinctrl_rk3568) = {
-+	.name		= "rockchip_rk3568_pinctrl",
-+	.id		= UCLASS_PINCTRL,
-+	.of_match	= rk3568_pinctrl_ids,
-+	.priv_auto = sizeof(struct rockchip_pinctrl_priv),
-+	.ops		= &rockchip_pinctrl_ops,
-+#if !CONFIG_IS_ENABLED(OF_PLATDATA)
-+	.bind		= dm_scan_fdt_dev,
-+#endif
-+	.probe		= rockchip_pinctrl_probe,
-+};
---- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
-+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
-@@ -400,7 +400,7 @@ static int rockchip_pinctrl_set_state(st
- 	int prop_len, param;
- 	const u32 *data;
- 	ofnode node;
--#ifdef CONFIG_OF_LIVE
-+#if CONFIG_IS_ENABLED(OF_LIVE)
- 	const struct device_node *np;
- 	struct property *pp;
- #else
-@@ -440,7 +440,7 @@ static int rockchip_pinctrl_set_state(st
- 		node = ofnode_get_by_phandle(conf);
- 		if (!ofnode_valid(node))
- 			return -ENODEV;
--#ifdef CONFIG_OF_LIVE
-+#if CONFIG_IS_ENABLED(OF_LIVE)
- 		np = ofnode_to_np(node);
- 		for (pp = np->properties; pp; pp = pp->next) {
- 			prop_name = pp->name;
-@@ -515,13 +515,14 @@ static struct rockchip_pin_ctrl *rockchi
- 
- 			/* preset iomux offset value, set new start value */
- 			if (iom->offset >= 0) {
--				if (iom->type & IOMUX_SOURCE_PMU)
-+				if ((iom->type & IOMUX_SOURCE_PMU) || (iom->type & IOMUX_L_SOURCE_PMU))
- 					pmu_offs = iom->offset;
- 				else
- 					grf_offs = iom->offset;
- 			} else { /* set current iomux offset */
--				iom->offset = (iom->type & IOMUX_SOURCE_PMU) ?
--							pmu_offs : grf_offs;
-+				iom->offset = ((iom->type & IOMUX_SOURCE_PMU) ||
-+						(iom->type & IOMUX_L_SOURCE_PMU)) ?
-+						pmu_offs : grf_offs;
- 			}
- 
- 			/* preset drv offset value, set new start value */
---- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
-+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
-@@ -6,9 +6,13 @@
- #ifndef __DRIVERS_PINCTRL_ROCKCHIP_H
- #define __DRIVERS_PINCTRL_ROCKCHIP_H
- 
-+#include <dt-bindings/pinctrl/rockchip.h>
- #include <linux/bitops.h>
- #include <linux/types.h>
- 
-+#define RK_GENMASK_VAL(h, l, v) \
-+	(GENMASK(((h) + 16), ((l) + 16)) | (((v) << (l)) & GENMASK((h), (l))))
-+
- /**
-  * Encode variants of iomux registers into a type variable
-  */
-@@ -18,6 +22,8 @@
- #define IOMUX_UNROUTED		BIT(3)
- #define IOMUX_WIDTH_3BIT	BIT(4)
- #define IOMUX_8WIDTH_2BIT	BIT(5)
-+#define IOMUX_WRITABLE_32BIT	BIT(6)
-+#define IOMUX_L_SOURCE_PMU	BIT(7)
- 
- /**
-  * Defined some common pins constants
-@@ -63,6 +69,21 @@ enum rockchip_pin_pull_type {
- };
- 
- /**
-+ * enum mux route register type, should be invalid/default/topgrf/pmugrf.
-+ * INVALID: means do not need to set mux route
-+ * DEFAULT: means same regmap as pin iomux
-+ * TOPGRF: means mux route setting in topgrf
-+ * PMUGRF: means mux route setting in pmugrf
-+ */
-+enum rockchip_pin_route_type {
-+	ROUTE_TYPE_DEFAULT = 0,
-+	ROUTE_TYPE_TOPGRF = 1,
-+	ROUTE_TYPE_PMUGRF = 2,
-+
-+	ROUTE_TYPE_INVALID = -1,
-+};
-+
-+/**
-  * @drv_type: drive strength variant using rockchip_perpin_drv_type
-  * @offset: if initialized to -1 it will be autocalculated, by specifying
-  *	    an initial offset value the relevant source offset can be reset
-@@ -220,6 +241,25 @@ struct rockchip_pin_bank {
- 		.pull_type[3] = pull3,					\
- 	}
- 
-+#define PIN_BANK_MUX_ROUTE_FLAGS(ID, PIN, FUNC, REG, VAL, FLAG)		\
-+	{								\
-+		.bank_num	= ID,					\
-+		.pin		= PIN,					\
-+		.func		= FUNC,					\
-+		.route_offset	= REG,					\
-+		.route_val	= VAL,					\
-+		.route_type	= FLAG,					\
-+	}
-+
-+#define MR_DEFAULT(ID, PIN, FUNC, REG, VAL)	\
-+	PIN_BANK_MUX_ROUTE_FLAGS(ID, PIN, FUNC, REG, VAL, ROUTE_TYPE_DEFAULT)
-+
-+#define MR_TOPGRF(ID, PIN, FUNC, REG, VAL)	\
-+	PIN_BANK_MUX_ROUTE_FLAGS(ID, PIN, FUNC, REG, VAL, ROUTE_TYPE_TOPGRF)
-+
-+#define MR_PMUGRF(ID, PIN, FUNC, REG, VAL)	\
-+	PIN_BANK_MUX_ROUTE_FLAGS(ID, PIN, FUNC, REG, VAL, ROUTE_TYPE_PMUGRF)
-+
- /**
-  * struct rockchip_mux_recalced_data: recalculate a pin iomux data.
-  * @num: bank number.
-@@ -241,6 +281,7 @@ struct rockchip_mux_recalced_data {
-  * @bank_num: bank number.
-  * @pin: index at register or used to calc index.
-  * @func: the min pin.
-+ * @route_type: the register type.
-  * @route_offset: the max pin.
-  * @route_val: the register offset.
-  */
-@@ -248,6 +289,7 @@ struct rockchip_mux_route_data {
- 	u8 bank_num;
- 	u8 pin;
- 	u8 func;
-+	enum rockchip_pin_route_type route_type : 8;
- 	u32 route_offset;
- 	u32 route_val;
- };
diff --git a/package/boot/uboot-rockchip/patches/008-rockchip-allow-sdmmc-at-full-speed.patch b/package/boot/uboot-rockchip/patches/008-rockchip-allow-sdmmc-at-full-speed.patch
deleted file mode 100644
index 3ad9d5b8b0e1..000000000000
--- a/package/boot/uboot-rockchip/patches/008-rockchip-allow-sdmmc-at-full-speed.patch
+++ /dev/null
@@ -1,22 +0,0 @@
-From 16cc17fc2cf2f308f5ac20b829d427114c6e59fa Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Mon, 20 Dec 2021 08:50:48 -0500
-Subject: [PATCH 08/11] rockchip: allow sdmmc at full speed
-
-Adding pinctrl and gpio support fixed quartz64-a sdmmc.
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi | 1 -
- 1 file changed, 1 deletion(-)
-
---- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
-+++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
-@@ -13,7 +13,6 @@
- };
- 
- &sdmmc0 {
--	max-frequency = <400000>;
- 	bus-width = <4>;
- 	u-boot,dm-spl;
- 	u-boot,spl-fifo-mode;
diff --git a/package/boot/uboot-rockchip/patches/009-rockchip-defconfig-add-gpio-v2-to-quartz64.patch b/package/boot/uboot-rockchip/patches/009-rockchip-defconfig-add-gpio-v2-to-quartz64.patch
deleted file mode 100644
index c0ca879bd53e..000000000000
--- a/package/boot/uboot-rockchip/patches/009-rockchip-defconfig-add-gpio-v2-to-quartz64.patch
+++ /dev/null
@@ -1,25 +0,0 @@
-From d3b3e9c1045e9fa0aff987a036b30cf380809e35 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Mon, 20 Dec 2021 10:11:52 -0500
-Subject: [PATCH 09/11] rockchip: defconfig: add gpio-v2 to quartz64
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- configs/quartz64-a-rk3566_defconfig | 2 ++
- 1 file changed, 2 insertions(+)
-
---- a/configs/quartz64-a-rk3566_defconfig
-+++ b/configs/quartz64-a-rk3566_defconfig
-@@ -42,10 +42,12 @@ CONFIG_CMD_REGULATOR=y
- CONFIG_SPL_OF_CONTROL=y
- CONFIG_OF_LIVE=y
- CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_DM_WARN=y
- CONFIG_SPL_REGMAP=y
- CONFIG_SPL_SYSCON=y
- CONFIG_SPL_CLK=y
- CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_ROCKCHIP_GPIO_V2=y
- CONFIG_SYS_I2C_ROCKCHIP=y
- CONFIG_MISC=y
- CONFIG_MMC_HS200_SUPPORT=y
diff --git a/package/boot/uboot-rockchip/patches/010-rockchip-rk356x-enable-usb2-support-on-quartz64-a.patch b/package/boot/uboot-rockchip/patches/010-rockchip-rk356x-enable-usb2-support-on-quartz64-a.patch
deleted file mode 100644
index a70c45a8be59..000000000000
--- a/package/boot/uboot-rockchip/patches/010-rockchip-rk356x-enable-usb2-support-on-quartz64-a.patch
+++ /dev/null
@@ -1,97 +0,0 @@
-From 981df845d960a9078893dad88e1dd82dfcb4a148 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Wed, 22 Dec 2021 19:40:32 -0500
-Subject: [PATCH 10/11] rockchip: rk356x: enable usb2 support on quartz64-a
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi | 22 ++++++++++++++++++++++
- configs/quartz64-a-rk3566_defconfig        | 17 +++++++++++++++++
- include/configs/quartz64-a-rk3566.h        |  3 +++
- 3 files changed, 42 insertions(+)
-
---- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
-+++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
-@@ -12,12 +12,34 @@
- 	};
- };
- 
-+&gmac1 {
-+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
-+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
-+	status = "disabled";
-+};
-+
- &sdmmc0 {
- 	bus-width = <4>;
- 	u-boot,dm-spl;
- 	u-boot,spl-fifo-mode;
- };
- 
-+&usb_host0_ehci {
-+	vbus-supply = <&vcc5v0_usb20_host>;
-+};
-+
-+&usb_host0_ohci {
-+	vbus-supply = <&vcc5v0_usb20_host>;
-+};
-+
-+&usb_host1_ehci {
-+	vbus-supply = <&vcc5v0_usb20_host>;
-+};
-+
-+&usb_host1_ohci {
-+	vbus-supply = <&vcc5v0_usb20_host>;
-+};
-+
- &uart2 {
- 	clock-frequency = <24000000>;
- 	u-boot,dm-spl;
---- a/configs/quartz64-a-rk3566_defconfig
-+++ b/configs/quartz64-a-rk3566_defconfig
-@@ -22,6 +22,7 @@ CONFIG_FIT=y
- CONFIG_FIT_VERBOSE=y
- CONFIG_SPL_LOAD_FIT=y
- CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-quartz64-a.dtb"
-+# CONFIG_SYS_DEVICE_NULLDEV is not set
- # CONFIG_DISPLAY_CPUINFO is not set
- CONFIG_DISPLAY_BOARDINFO_LATE=y
- # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-@@ -35,6 +36,7 @@ CONFIG_CMD_GPIO=y
- CONFIG_CMD_GPT=y
- CONFIG_CMD_I2C=y
- CONFIG_CMD_MMC=y
-+CONFIG_CMD_USB=y
- # CONFIG_CMD_SETEXPR is not set
- CONFIG_CMD_PMIC=y
- CONFIG_CMD_REGULATOR=y
-@@ -76,4 +78,19 @@ CONFIG_BAUDRATE=1500000
- CONFIG_DEBUG_UART_SHIFT=2
- CONFIG_SYSRESET=y
- CONFIG_SYSRESET_PSCI=y
-+CONFIG_USB=y
-+CONFIG_USB_XHCI_HCD=y
-+CONFIG_USB_XHCI_DWC3=y
-+CONFIG_USB_EHCI_HCD=y
-+CONFIG_USB_EHCI_GENERIC=y
-+CONFIG_USB_OHCI_HCD=y
-+CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_USB_DWC3=y
-+CONFIG_USB_DWC3_GENERIC=y
-+CONFIG_ROCKCHIP_USB2_PHY=y
-+CONFIG_USB_KEYBOARD=y
-+CONFIG_USB_HOST_ETHER=y
-+CONFIG_USB_ETHER_LAN75XX=y
-+CONFIG_USB_ETHER_LAN78XX=y
-+CONFIG_USB_ETHER_SMSC95XX=y
- CONFIG_ERRNO_STR=y
---- a/include/configs/quartz64-a-rk3566.h
-+++ b/include/configs/quartz64-a-rk3566.h
-@@ -11,4 +11,7 @@
- 			"stdout=serial,vidconsole\0" \
- 			"stderr=serial,vidconsole\0"
- 
-+#define CONFIG_USB_OHCI_NEW
-+#define CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS     2
-+
- #endif
diff --git a/package/boot/uboot-rockchip/patches/011-rockchip-rk356x-attempt-to-fix-ram-detection.patch b/package/boot/uboot-rockchip/patches/011-rockchip-rk356x-attempt-to-fix-ram-detection.patch
deleted file mode 100644
index 736de6b21a2b..000000000000
--- a/package/boot/uboot-rockchip/patches/011-rockchip-rk356x-attempt-to-fix-ram-detection.patch
+++ /dev/null
@@ -1,173 +0,0 @@
-From ea6da572fe3cee637319f1e7e588c059622c815e Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Wed, 22 Dec 2021 19:52:38 -0500
-Subject: [PATCH 11/11] rockchip: rk356x: attempt to fix ram detection
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/mach-rockchip/rk3568/rk3568.c | 29 ++++++++++++++++++++++++
- arch/arm/mach-rockchip/sdram.c         | 31 ++++++++++++++------------
- common/board_f.c                       |  7 ++++++
- configs/quartz64-a-rk3566_defconfig    |  1 +
- include/configs/rk3568_common.h        |  5 +++++
- 5 files changed, 59 insertions(+), 14 deletions(-)
-
---- a/arch/arm/mach-rockchip/rk3568/rk3568.c
-+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
-@@ -5,6 +5,7 @@
- 
- #include <common.h>
- #include <dm.h>
-+#include <fdt_support.h>
- #include <asm/armv8/mmu.h>
- #include <asm/io.h>
- #include <asm/arch-rockchip/bootrom.h>
-@@ -135,3 +136,31 @@ int arch_cpu_init(void)
- #endif
- 	return 0;
- }
-+
-+#ifdef CONFIG_OF_SYSTEM_SETUP
-+int ft_system_setup(void *blob, struct bd_info *bd)
-+{
-+	int ret;
-+	int areas = 1;
-+	u64 start[2], size[2];
-+
-+	/* Reserve the io address space. */
-+	if (gd->ram_top > SDRAM_UPPER_ADDR_MIN) {
-+		start[0] = gd->bd->bi_dram[0].start;
-+		size[0] = SDRAM_LOWER_ADDR_MAX - gd->bd->bi_dram[0].start;
-+
-+		/* Add the upper 4GB address space */
-+		start[1] = SDRAM_UPPER_ADDR_MIN;
-+		size[1] = gd->ram_top - SDRAM_UPPER_ADDR_MIN;
-+		areas = 2;
-+
-+		ret = fdt_set_usable_memory(blob, start, size, areas);
-+		if (ret) {
-+			printf("Cannot set usable memory\n");
-+			return ret;
-+		}
-+	}
-+
-+	return 0;
-+};
-+#endif
---- a/arch/arm/mach-rockchip/sdram.c
-+++ b/arch/arm/mach-rockchip/sdram.c
-@@ -3,6 +3,8 @@
-  * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
-  */
- 
-+#define DEBUG
-+
- #include <common.h>
- #include <dm.h>
- #include <init.h>
-@@ -98,8 +100,7 @@ size_t rockchip_sdram_size(phys_addr_t r
- 			  SYS_REG_COL_MASK);
- 		cs1_col = cs0_col;
- 		bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK);
--		if ((sys_reg3 >> SYS_REG_VERSION_SHIFT &
--		     SYS_REG_VERSION_MASK) == 0x2) {
-+		if ((sys_reg3 >> SYS_REG_VERSION_SHIFT & SYS_REG_VERSION_MASK) >= 0x2) {
- 			cs1_col = 9 + (sys_reg3 >> SYS_REG_CS1_COL_SHIFT(ch) &
- 				  SYS_REG_CS1_COL_MASK);
- 			if (((sys_reg3 >> SYS_REG_EXTEND_CS0_ROW_SHIFT(ch) &
-@@ -136,7 +137,7 @@ size_t rockchip_sdram_size(phys_addr_t r
- 			SYS_REG_BW_MASK));
- 		row_3_4 = sys_reg2 >> SYS_REG_ROW_3_4_SHIFT(ch) &
- 			SYS_REG_ROW_3_4_MASK;
--		if (dram_type == DDR4) {
-+		if ((dram_type == DDR4) && (sys_reg3 >> SYS_REG_VERSION_SHIFT & SYS_REG_VERSION_MASK) != 0x3){
- 			dbw = (sys_reg2 >> SYS_REG_DBW_SHIFT(ch)) &
- 				SYS_REG_DBW_MASK;
- 			bg = (dbw == 2) ? 2 : 1;
-@@ -150,15 +151,11 @@ size_t rockchip_sdram_size(phys_addr_t r
- 			chipsize_mb = chipsize_mb * 3 / 4;
- 		size_mb += chipsize_mb;
- 		if (rank > 1)
--			debug("rank %d cs0_col %d cs1_col %d bk %d cs0_row %d\
--			       cs1_row %d bw %d row_3_4 %d\n",
--			       rank, cs0_col, cs1_col, bk, cs0_row,
--			       cs1_row, bw, row_3_4);
-+			debug("rank=%d cs0_col=%d cs1_col=%d bk=%d cs0_row=%d cs1_row=%d bg=%d bw=%d row_3_4=%d\n",
-+			       rank, cs0_col, cs1_col, bk, cs0_row, cs1_row, bg, bw, row_3_4);
- 		else
--			debug("rank %d cs0_col %d bk %d cs0_row %d\
--			       bw %d row_3_4 %d\n",
--			       rank, cs0_col, bk, cs0_row,
--			       bw, row_3_4);
-+			debug("rank %d cs0_col %d bk %d cs0_row %d bw %d row_3_4 %d\n",
-+			       rank, cs0_col, bk, cs0_row, bw, row_3_4);
- 	}
- 
- 	/*
-@@ -176,9 +173,11 @@ size_t rockchip_sdram_size(phys_addr_t r
- 	 *   2. update board_get_usable_ram_top() and dram_init_banksize()
- 	 *   to reserve memory for peripheral space after previous update.
- 	 */
-+
-+#ifndef __aarch64__
- 	if (size_mb > (SDRAM_MAX_SIZE >> 20))
- 		size_mb = (SDRAM_MAX_SIZE >> 20);
--
-+#endif
- 	return (size_t)size_mb << 20;
- }
- 
-@@ -208,6 +207,10 @@ int dram_init(void)
- ulong board_get_usable_ram_top(ulong total_size)
- {
- 	unsigned long top = CONFIG_SYS_SDRAM_BASE + SDRAM_MAX_SIZE;
--
--	return (gd->ram_top > top) ? top : gd->ram_top;
-+#ifdef SDRAM_UPPER_ADDR_MIN
-+	if (gd->ram_top > SDRAM_UPPER_ADDR_MIN)
-+		return gd->ram_top;
-+	else
-+#endif
-+		return (gd->ram_top > top) ? top : gd->ram_top;
- }
---- a/common/board_f.c
-+++ b/common/board_f.c
-@@ -345,7 +345,14 @@ static int setup_dest_addr(void)
- #endif
- 	gd->ram_top = gd->ram_base + get_effective_memsize();
- 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
-+#ifdef SDRAM_LOWER_ADDR_MAX
-+	if (gd->ram_top > SDRAM_LOWER_ADDR_MAX)
-+		gd->relocaddr = SDRAM_LOWER_ADDR_MAX;
-+	else
-+		gd->relocaddr = gd->ram_top;
-+#else
- 	gd->relocaddr = gd->ram_top;
-+#endif
- 	debug("Ram top: %08lX\n", (ulong)gd->ram_top);
- #if defined(CONFIG_MP) && (defined(CONFIG_MPC86xx) || defined(CONFIG_E500))
- 	/*
---- a/configs/quartz64-a-rk3566_defconfig
-+++ b/configs/quartz64-a-rk3566_defconfig
-@@ -21,6 +21,7 @@ CONFIG_API=y
- CONFIG_FIT=y
- CONFIG_FIT_VERBOSE=y
- CONFIG_SPL_LOAD_FIT=y
-+CONFIG_OF_SYSTEM_SETUP=y
- CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-quartz64-a.dtb"
- # CONFIG_SYS_DEVICE_NULLDEV is not set
- # CONFIG_DISPLAY_CPUINFO is not set
---- a/include/configs/rk3568_common.h
-+++ b/include/configs/rk3568_common.h
-@@ -24,6 +24,11 @@
- #define CONFIG_SYS_SDRAM_BASE		0
- #define SDRAM_MAX_SIZE			0xf0000000
- 
-+#ifdef CONFIG_OF_SYSTEM_SETUP
-+#define SDRAM_LOWER_ADDR_MAX		0xf0000000
-+#define SDRAM_UPPER_ADDR_MIN		0x100000000
-+#endif
-+
- #ifndef CONFIG_SPL_BUILD
- #define ENV_MEM_LAYOUT_SETTINGS		\
- 	"scriptaddr=0x00c00000\0"	\
diff --git a/package/boot/uboot-rockchip/patches/012-resync-rk3566-device-tree-with-mainline.patch b/package/boot/uboot-rockchip/patches/012-resync-rk3566-device-tree-with-mainline.patch
deleted file mode 100644
index 11c791356fd9..000000000000
--- a/package/boot/uboot-rockchip/patches/012-resync-rk3566-device-tree-with-mainline.patch
+++ /dev/null
@@ -1,1060 +0,0 @@
-From 07cb5e592c2fe682d7f176282a16f389c94f46c8 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Tue, 18 Jan 2022 19:20:40 -0500
-Subject: [PATCH 12/13] resync rk3566 device tree with mainline
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- arch/arm/dts/rk3566-quartz64-a.dts      | 285 ++++++++++++++++++++---
- arch/arm/dts/rk3566.dtsi                |   8 +-
- arch/arm/dts/rk3568.dtsi                |  29 ++-
- arch/arm/dts/rk356x.dtsi                | 297 ++++++++++++------------
- include/dt-bindings/soc/rockchip,vop2.h |  14 ++
- 5 files changed, 442 insertions(+), 191 deletions(-)
- create mode 100644 include/dt-bindings/soc/rockchip,vop2.h
-
---- a/arch/arm/dts/rk3566-quartz64-a.dts
-+++ b/arch/arm/dts/rk3566-quartz64-a.dts
-@@ -4,6 +4,7 @@
- 
- #include <dt-bindings/gpio/gpio.h>
- #include <dt-bindings/pinctrl/rockchip.h>
-+#include <dt-bindings/soc/rockchip,vop2.h>
- #include "rk3566.dtsi"
- 
- / {
-@@ -55,6 +56,17 @@
- 		#cooling-cells = <2>;
- 	};
- 
-+	hdmi-con {
-+		compatible = "hdmi-connector";
-+		type = "c";
-+
-+		port {
-+			hdmi_con_in: endpoint {
-+				remote-endpoint = <&hdmi_out_con>;
-+			};
-+		};
-+	};
-+
- 	leds {
- 		compatible = "gpio-leds";
- 
-@@ -196,7 +208,7 @@
- 		enable-active-high;
- 		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
- 		pinctrl-names = "default";
--		pinctrl-0 = <&vcc5v0_usb20_host_en_h>;
-+		pinctrl-0 = <&vcc5v0_usb20_host_en>;
- 		regulator-min-microvolt = <5000000>;
- 		regulator-max-microvolt = <5000000>;
- 		vin-supply = <&vcc5v0_usb>;
-@@ -248,6 +260,29 @@
- 		vin-supply = <&vbus>;
- 	};
- 
-+	vcc_sys_ebc: vcc_sys_ebc {
-+		compatible = "regulator-fixed";
-+		gpio = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
-+		enable-active-high;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&vcc_sys_ebc_h>;
-+		regulator-boot-on;
-+		regulator-name = "vcc_sys_ebc";
-+		regulator-min-microvolt = <3300000>;
-+		regulator-max-microvolt = <3300000>;
-+		vin-supply = <&vcc_sys>;
-+	};
-+
-+	vcc_lcd_en: vcc_lcd_en {
-+		compatible = "regulator-fixed";
-+//		gpio = <&gpio2 RK_PC4 GPIO_ACTIVE_HIGH>;
-+		regulator-always-on;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&vcc_lcd_en_h>;
-+		regulator-name = "vcc_lcd_en";
-+		vin-supply = <&vcc_sys>;
-+	};
-+
- 	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
- 	vcc_wl: vcc_wl {
- 		compatible = "regulator-fixed";
-@@ -258,14 +293,21 @@
- 		regulator-max-microvolt = <3300000>;
- 		vin-supply = <&vcc_sys>;
- 	};
-+
-+	backlight: backlight {
-+		compatible = "pwm-backlight";
-+		pwms = <&pwm14 0 1000000 0>;
-+		brightness-levels = <0 4 8 16 32 64 128 255>;
-+		default-brightness-level = <6>;
-+	};
- };
- 
--&combphy1_usq {
-+&combphy1 {
- 	status = "okay";
- 	rockchip,enable-ssc;
- };
- 
--&combphy2_psq {
-+&combphy2 {
- 	status = "okay";
- };
- 
-@@ -302,6 +344,39 @@
- 	};
- };
- 
-+&ebc {
-+	panel,width = <1872>;
-+	panel,height = <1404>;
-+	panel,vir_width = <1872>;
-+	panel,vir_height = <1404>;
-+	panel,sdck = <33300000>;
-+	panel,lsl = <11>;
-+	panel,lbl = <8>;
-+	panel,ldl = <234>;
-+	panel,lel = <23>;
-+	panel,gdck-sta = <10>;
-+	panel,lgonl = <215>;
-+	panel,fsl = <1>;
-+	panel,fbl = <4>;
-+	panel,fdl = <1404>;
-+	panel,fel = <12>;
-+	panel,mirror = <1>;
-+	panel,panel_16bit = <1>;
-+	panel,panel_color = <0>;
-+	panel,width-mm = <157>;
-+	panel,height-mm = <210>;
-+
-+	io-channels = <&ebc_pmic 0>;
-+	panel-supply = <&v3p3>;
-+	vcom-supply = <&vcom>;
-+	vdrive-supply = <&vdrive>;
-+	status = "okay";
-+};
-+
-+&eink {
-+	status = "okay";
-+};
-+
- &gmac1 {
- 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>;
- 	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>, <&gmac1_clkin>;
-@@ -325,19 +400,28 @@
- 	status = "okay";
- };
- 
--&hdmi {
-+&gpu {
-+	mali-supply = <&vdd_gpu>;
- 	status = "okay";
-+};
-+
-+&hdmi {
- 	avdd-0v9-supply = <&vdda_0v9>;
- 	avdd-1v8-supply = <&vcc_1v8>;
-+	status = "okay";
- };
- 
--&hdmi_in_vp0 {
--	status = "okay";
-+&hdmi_in {
-+	hdmi_in_vp0: endpoint@0 {
-+		reg = <0>;
-+		remote-endpoint = <&vp0_out_hdmi>;
-+	};
- };
- 
--&gpu {
--	mali-supply = <&vdd_gpu>;
--	status = "okay";
-+&hdmi_out {
-+	hdmi_out_con: endpoint {
-+		remote-endpoint = <&hdmi_con_in>;
-+	};
- };
- 
- &i2c0 {
-@@ -357,6 +441,7 @@
- 
- 		regulator-state-mem {
- 			regulator-off-in-suspend;
-+			regulator-suspend-microvolt = <900000>;
- 		};
- 	};
- 
-@@ -420,8 +505,6 @@
- 			vcc_ddr: DCDC_REG3 {
- 				regulator-always-on;
- 				regulator-boot-on;
--				regulator-min-microvolt = <1100000>;
--				regulator-max-microvolt = <1100000>;
- 				regulator-initial-mode = <0x2>;
- 				regulator-name = "vcc_ddr";
- 				regulator-state-mem {
-@@ -571,6 +654,55 @@
- 	};
- };
- 
-+&i2c1 {
-+	status = "okay";
-+
-+	ebc_pmic: pmic@68 {
-+		compatible = "ti,tps65185";
-+		reg = <0x68>;
-+		interrupt-parent = <&gpio4>;
-+		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
-+		#io-channel-cells = <1>;
-+		pinctrl-0 = <&ebc_pmic_pins>;
-+		pinctrl-names = "default";
-+		powerup-gpios = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
-+		pwr_good-gpios = <&gpio4 RK_PB1 GPIO_ACTIVE_HIGH>;
-+		vcom_ctrl-gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_HIGH>;
-+		vin-supply = <&vcc_sys_ebc>;
-+		vin3p3-supply = <&vcc_sys_ebc>;
-+		wakeup-gpios = <&gpio4 RK_PC3 GPIO_ACTIVE_HIGH>;
-+		ti,up-sequence = <1>, <0>, <2>, <3>;
-+		ti,up-delay-ms = <3>, <3>, <3>, <3>;
-+		ti,down-sequence = <2>, <3>, <1>, <0>;
-+		ti,down-delay-ms = <3>, <6>, <6>, <6>;
-+
-+		regulators {
-+			v3p3: v3p3 {
-+				regulator-name = "v3p3";
-+				regulator-always-on;
-+				regulator-min-microvolt = <3300000>;
-+				regulator-max-microvolt = <3300000>;
-+			};
-+
-+			vcom: vcom {
-+				regulator-name = "vcom";
-+				regulator-min-microvolt = <1450000>;
-+				regulator-max-microvolt = <1450000>;
-+			};
-+
-+			vdrive: vdrive {
-+				regulator-name = "vdrive";
-+				regulator-min-microvolt = <15000000>;
-+				regulator-max-microvolt = <15000000>;
-+			};
-+		};
-+	};
-+};
-+
-+&i2c3 {
-+	status = "okay";
-+};
-+
- &i2s1_8ch {
- 	pinctrl-names = "default";
- 	pinctrl-0 = <&i2s1m0_sclktx
-@@ -611,6 +743,21 @@
- 		};
- 	};
- 
-+	ebc_pmic {
-+		ebc_pmic_pins: ebc-pmic-pins {
-+			rockchip,pins = /* wakeup */
-+					<4 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>,
-+					/* int */
-+					<4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>,
-+					/* pwr_good */
-+					<4 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>,
-+					/* pwrup */
-+					<4 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>,
-+					/* vcom_ctrl */
-+					<4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
- 	fan {
- 		fan_en_h: fan-en-h {
- 			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
-@@ -654,7 +801,7 @@
- 	};
- 
- 	usb2 {
--		vcc5v0_usb20_host_en_h: vcc5v0-usb20-host-en_h {
-+		vcc5v0_usb20_host_en: vcc5v0-usb20-host-en {
- 			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
- 		};
- 	};
-@@ -664,6 +811,18 @@
- 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
- 		};
- 	};
-+
-+	vcc_sys_ebc {
-+		vcc_sys_ebc_h: vcc-sys-ebc-h {
-+			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	vcc_lcd_en {
-+		vcc_lcd_en_h: vcc-lcd-en-h {
-+			rockchip,pins = <2 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
- };
- 
- &pmu_io_domains {
-@@ -681,12 +840,15 @@
- 
- /* sata1 is muxed with the usb3 port */
- &sata1 {
--	status = "okay";
-+	status = "disabled";
-+//	status = "okay";
- };
- 
- /* sata2 is muxed with the pcie2 slot*/
- &sata2 {
-+	target-supply = <&vcc3v3_pcie_p>;
- 	status = "disabled";
-+//	status = "okay";
- };
- 
- &sdhci {
-@@ -783,6 +945,10 @@
- 	status = "okay";
- };
- 
-+&u2phy0 {
-+	status = "okay";
-+};
-+
- &u2phy0_host {
- 	phy-supply = <&vcc5v0_usb20_host>;
- 	status = "okay";
-@@ -793,25 +959,17 @@
- 	status = "okay";
- };
- 
--&u2phy1_host {
--	phy-supply = <&vcc5v0_usb20_host>;
-+&u2phy1 {
- 	status = "okay";
- };
- 
--&u2phy1_otg {
-+&u2phy1_host {
- 	phy-supply = <&vcc5v0_usb20_host>;
- 	status = "okay";
- };
- 
--&usb2phy0 {
--	status = "okay";
--};
--
--&usb2phy1 {
--	status = "okay";
--};
--
--&usbdrd_dwc3 {
-+&u2phy1_otg {
-+	phy-supply = <&vcc5v0_usb20_host>;
- 	status = "okay";
- };
- 
-@@ -820,13 +978,9 @@
- };
- 
- /* usb3 controller is muxed with sata1 */
--&usbhost_dwc3 {
--	status = "disabled";
--};
--
--/* usb3 controller is muxed with sata1 */
- &usbhost30 {
--	status = "disabled";
-+//	status = "disabled";
-+	status = "okay";
- };
- 
- &usb_host0_ehci {
-@@ -846,15 +1000,80 @@
- };
- 
- &vop {
--	status = "okay";
- 	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
- 	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
-+	status = "okay";
- };
- 
- &vop_mmu {
- 	status = "okay";
- };
- 
--&vp0_out_hdmi {
-+&vp0 {
-+	vp0_out_hdmi: endpoint@RK3568_VOP2_EP_HDMI {
-+		reg = <RK3568_VOP2_EP_HDMI>;
-+		remote-endpoint = <&hdmi_in_vp0>;
-+	};
-+};
-+/*
-+&video_phy0 {
-+	status = "okay";
-+};
-+
-+&dsi0 {
-+	status = "okay";
-+	clock-master;
-+
-+	mipi_panel: panel@0 {
-+		compatible = "feiyang,fy07024di26a30d";
-+		reg = <0>;
-+		backlight = <&backlight>;
-+		reset-gpios = <&gpio2 RK_PC4 GPIO_ACTIVE_HIGH>;
-+		width-mm = <154>;
-+		height-mm = <86>;
-+		rotation = <0>;
-+//		avdd-supply = <&avdd>;
-+//		dvdd-supply = <&vcc3v3_s0>;
-+
-+		ports {
-+			#address-cells = <1>;
-+			#size-cells = <0>;
-+
-+			port@0 {
-+				reg = <0>;
-+
-+				mipi_in_panel: endpoint {
-+					remote-endpoint = <&mipi_out_panel>;
-+				};
-+			};
-+		};
-+	};
-+};
-+
-+&dsi0_in {
-+	dsi0_in_vp1: endpoint@1 {
-+		reg = <1>;
-+		remote-endpoint = <&vp1_out_dsi0>;
-+	};
-+};
-+
-+&dsi0_out {
-+	mipi_out_panel: endpoint {
-+		remote-endpoint = <&mipi_in_panel>;
-+	};
-+
-+};
-+
-+&vp1 {
-+	vp1_out_dsi0: endpoint@RK3568_VOP2_EP_MIPI0 {
-+		reg = <RK3568_VOP2_EP_MIPI0>;
-+		remote-endpoint = <&dsi0_in_vp1>;
-+	};
-+};
-+
-+&pwm14 {
- 	status = "okay";
-+	pinctrl-0 = <&pwm14m1_pins>;
-+	pinctrl-names = "default";
- };
-+*/
---- a/arch/arm/dts/rk3566.dtsi
-+++ b/arch/arm/dts/rk3566.dtsi
-@@ -23,10 +23,14 @@
- 	};
- };
- 
--&usbdrd_dwc3 {
-+&usbdrd30 {
- 	phys = <&u2phy0_otg>;
- 	phy-names = "usb2-phy";
--	extcon = <&usb2phy0>;
-+	extcon = <&u2phy0>;
- 	maximum-speed = "high-speed";
- 	snps,dis_u2_susphy_quirk;
- };
-+
-+&vop {
-+	compatible = "rockchip,rk3566-vop";
-+};
---- a/arch/arm/dts/rk3568.dtsi
-+++ b/arch/arm/dts/rk3568.dtsi
-@@ -16,13 +16,18 @@
- 		clock-names = "sata", "pmalive", "rxoob";
- 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
- 		interrupt-names = "hostc";
--		phys = <&combphy0_us PHY_TYPE_SATA>;
-+		phys = <&combphy0 PHY_TYPE_SATA>;
- 		phy-names = "sata-phy";
- 		ports-implemented = <0x1>;
- 		power-domains = <&power RK3568_PD_PIPE>;
- 		status = "disabled";
- 	};
- 
-+	pipe_phy_grf0: syscon@fdc70000 {
-+		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
-+		reg = <0x0 0xfdc70000 0x0 0x1000>;
-+	};
-+
- 	qos_pcie3x1: qos@fe190080 {
- 		compatible = "rockchip,rk3568-qos", "syscon";
- 		reg = <0x0 0xfe190080 0x0 0x20>;
-@@ -87,19 +92,19 @@
- 		};
- 	};
- 
--	combphy0_us: phy@fe820000 {
-+	combphy0: phy@fe820000 {
- 		compatible = "rockchip,rk3568-naneng-combphy";
- 		reg = <0x0 0xfe820000 0x0 0x100>;
--		#phy-cells = <1>;
--		assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
--		assigned-clock-rates = <100000000>;
--		clocks = <&pmucru CLK_PCIEPHY0_REF>, <&cru PCLK_PIPEPHY0>,
-+		clocks = <&pmucru CLK_PCIEPHY0_REF>,
-+			 <&cru PCLK_PIPEPHY0>,
- 			 <&cru PCLK_PIPE>;
- 		clock-names = "ref", "apb", "pipe";
--		resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;
--		reset-names = "combphy-apb", "combphy";
-+		assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
-+		assigned-clock-rates = <100000000>;
-+		resets = <&cru SRST_PIPEPHY0>;
- 		rockchip,pipe-grf = <&pipegrf>;
- 		rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
-+		#phy-cells = <1>;
- 		status = "disabled";
- 	};
- };
-@@ -131,7 +136,11 @@
- 	};
- };
- 
--&usbdrd_dwc3 {
--	phys = <&u2phy0_otg>, <&combphy0_us PHY_TYPE_USB3>;
-+&usbdrd30 {
-+	phys = <&u2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
- 	phy-names = "usb2-phy", "usb3-phy";
- };
-+
-+&vop {
-+	compatible = "rockchip,rk3568-vop";
-+};
---- a/arch/arm/dts/rk356x.dtsi
-+++ b/arch/arm/dts/rk356x.dtsi
-@@ -159,6 +159,11 @@
- 		};
- 	};
- 
-+	display_subsystem: display-subsystem {
-+		compatible = "rockchip,display-subsystem";
-+		ports = <&vop_out>;
-+	};
-+
- 	firmware {
- 		scmi: scmi {
- 			compatible = "arm,scmi-smc";
-@@ -234,7 +239,7 @@
- 		clock-names = "sata", "pmalive", "rxoob";
- 		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
- 		interrupt-names = "hostc";
--		phys = <&combphy1_usq PHY_TYPE_SATA>;
-+		phys = <&combphy1 PHY_TYPE_SATA>;
- 		phy-names = "sata-phy";
- 		ports-implemented = <0x1>;
- 		power-domains = <&power RK3568_PD_PIPE>;
-@@ -249,7 +254,7 @@
- 		clock-names = "sata", "pmalive", "rxoob";
- 		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
- 		interrupt-names = "hostc";
--		phys = <&combphy2_psq PHY_TYPE_SATA>;
-+		phys = <&combphy2 PHY_TYPE_SATA>;
- 		phy-names = "sata-phy";
- 		ports-implemented = <0x1>;
- 		power-domains = <&power RK3568_PD_PIPE>;
-@@ -258,66 +263,46 @@
- 
- 	usbdrd30: usbdrd {
- 		compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
-+		reg = <0x0 0xfcc00000 0x0 0x400000>;
-+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
- 		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
- 			 <&cru ACLK_USB3OTG0>, <&cru PCLK_PIPE>;
- 		clock-names = "ref_clk", "suspend_clk",
- 			      "bus_clk", "pipe_clk";
--		#address-cells = <2>;
--		#size-cells = <2>;
--		ranges;
-+		dr_mode = "host";
-+		phy_type = "utmi_wide";
-+		power-domains = <&power RK3568_PD_PIPE>;
-+		resets = <&cru SRST_USB3OTG0>;
-+		reset-names = "usb3-otg";
-+		snps,dis_enblslpm_quirk;
-+		snps,dis-u2-freeclk-exists-quirk;
-+		snps,dis-del-phy-power-chg-quirk;
-+		snps,dis-tx-ipgap-linecheck-quirk;
-+		snps,xhci-trb-ent-quirk;
- 		status = "disabled";
--
--		usbdrd_dwc3: dwc3@fcc00000 {
--			compatible = "snps,dwc3";
--			reg = <0x0 0xfcc00000 0x0 0x400000>;
--			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
--			dr_mode = "host";
--			phys = <&u2phy0_otg>, <&combphy0_us PHY_TYPE_USB3>;
--			phy-names = "usb2-phy", "usb3-phy";
--			phy_type = "utmi_wide";
--			power-domains = <&power RK3568_PD_PIPE>;
--			resets = <&cru SRST_USB3OTG0>;
--			reset-names = "usb3-otg";
--			snps,dis_enblslpm_quirk;
--			snps,dis-u2-freeclk-exists-quirk;
--			snps,dis-del-phy-power-chg-quirk;
--			snps,dis-tx-ipgap-linecheck-quirk;
--			snps,xhci-trb-ent-quirk;
--			status = "disabled";
--		};
- 	};
- 
- 	usbhost30: usbhost {
- 		compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
-+		reg = <0x0 0xfd000000 0x0 0x400000>;
-+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
- 		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
- 			 <&cru ACLK_USB3OTG1>, <&cru PCLK_PIPE>;
- 		clock-names = "ref_clk", "suspend_clk",
- 			      "bus_clk", "pipe_clk";
--		#address-cells = <2>;
--		#size-cells = <2>;
--		assigned-clocks = <&cru CLK_PCIEPHY1_REF>;
--		assigned-clock-rates = <25000000>;
--		ranges;
--		status = "disabled";
--
--		usbhost_dwc3: dwc3@fd000000 {
--			compatible = "snps,dwc3";
--			reg = <0x0 0xfd000000 0x0 0x400000>;
--			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
--			dr_mode = "host";
--			phys = <&u2phy0_host>, <&combphy1_usq PHY_TYPE_USB3>;
--			phy-names = "usb2-phy", "usb3-phy";
--			phy_type = "utmi_wide";
--			power-domains = <&power RK3568_PD_PIPE>;
--			resets = <&cru SRST_USB3OTG1>;
--			reset-names = "usb3-host";
--			snps,dis_enblslpm_quirk;
--			snps,dis-u2-freeclk-exists-quirk;
--			snps,dis_u2_susphy_quirk;
--			snps,dis-del-phy-power-chg-quirk;
--			snps,dis-tx-ipgap-linecheck-quirk;
--			status = "disabled";
--		};
-+		dr_mode = "host";
-+		phys = <&u2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
-+		phy-names = "usb2-phy", "usb3-phy";
-+		phy_type = "utmi_wide";
-+		power-domains = <&power RK3568_PD_PIPE>;
-+		resets = <&cru SRST_USB3OTG1>;
-+		reset-names = "usb3-host";
-+		snps,dis_enblslpm_quirk;
-+		snps,dis-u2-freeclk-exists-quirk;
-+		snps,dis_u2_susphy_quirk;
-+		snps,dis-del-phy-power-chg-quirk;
-+		snps,dis-tx-ipgap-linecheck-quirk;
-+		status = "disabled";
- 	};
- 
- 	gic: interrupt-controller@fd400000 {
-@@ -339,7 +324,7 @@
- 		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
- 			 <&cru PCLK_USB>;
- 		phys = <&u2phy1_otg>;
--		phy-names = "usb2-phy";
-+		phy-names = "usb";
- 		status = "disabled";
- 	};
- 
-@@ -350,7 +335,7 @@
- 		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
- 			 <&cru PCLK_USB>;
- 		phys = <&u2phy1_otg>;
--		phy-names = "usb2-phy";
-+		phy-names = "usb";
- 		status = "disabled";
- 	};
- 
-@@ -361,7 +346,7 @@
- 		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
- 			 <&cru PCLK_USB>;
- 		phys = <&u2phy1_host>;
--		phy-names = "usb2-phy";
-+		phy-names = "usb";
- 		status = "disabled";
- 	};
- 
-@@ -372,7 +357,7 @@
- 		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
- 			 <&cru PCLK_USB>;
- 		phys = <&u2phy1_host>;
--		phy-names = "usb2-phy";
-+		phy-names = "usb";
- 		status = "disabled";
- 	};
- 
-@@ -395,21 +380,17 @@
- 		reg = <0x0 0xfdc60000 0x0 0x10000>;
- 	};
- 
--	pipe_phy_grf0: syscon@fdc70000 {
--		compatible = "rockchip,pipe-phy-grf", "syscon";
--		reg = <0x0 0xfdc70000 0x0 0x1000>;
--	};
--
- 	pipe_phy_grf1: syscon@fdc80000 {
--		compatible = "rockchip,pipe-phy-grf", "syscon";
-+		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
- 		reg = <0x0 0xfdc80000 0x0 0x1000>;
- 	};
- 
- 	pipe_phy_grf2: syscon@fdc90000 {
--		compatible = "rockchip,pipe-phy-grf", "syscon";
-+		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
- 		reg = <0x0 0xfdc90000 0x0 0x1000>;
- 	};
- 
-+
- 	usb2phy0_grf: syscon@fdca0000 {
- 		compatible = "rockchip,rk3568-usb2phy-grf", "syscon";
- 		reg = <0x0 0xfdca0000 0x0 0x8000>;
-@@ -604,6 +585,28 @@
- 		status = "disabled";
- 	};
- 
-+	ebc: ebc@fdec0000 {
-+		compatible = "rockchip,rk3568-ebc-tcon";
-+		reg = <0x0 0xfdec0000 0x0 0x5000>;
-+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru HCLK_EBC>, <&cru DCLK_EBC>;
-+		clock-names = "hclk", "dclk";
-+		pinctrl-0 = <&ebc_pins>;
-+		pinctrl-names = "default";
-+		power-domains = <&power RK3568_PD_RGA>;
-+		rockchip,grf = <&grf>;
-+		status = "disabled";
-+	};
-+
-+	eink: eink@fdf00000 {
-+		compatible = "rockchip,rk3568-eink-tcon";
-+		reg = <0x0 0xfdf00000 0x0 0x74>;
-+		clocks = <&cru PCLK_EINK>, <&cru HCLK_EINK>;
-+		clock-names = "pclk", "hclk";
-+		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
-+		status = "disabled";
-+	};
-+
- 	sdmmc2: mmc@fe000000 {
- 		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
- 		reg = <0x0 0xfe000000 0x0 0x4000>;
-@@ -665,21 +668,15 @@
- 		};
- 	};
- 
--	display_subsystem: display-subsystem {
--		compatible = "rockchip,display-subsystem";
--		ports = <&vop_out>;
--	};
--
- 	vop: vop@fe040000 {
--		compatible = "rockchip,rk3568-vop";
- 		reg = <0x0 0xfe040000 0x0 0x3000>, <0x0 0xfe044000 0x0 0x1000>;
- 		reg-names = "regs", "gamma_lut";
--		rockchip,grf = <&grf>;
- 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
- 		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>, <&cru DCLK_VOP0>, <&cru DCLK_VOP1>, <&cru DCLK_VOP2>;
- 		clock-names = "aclk_vop", "hclk_vop", "dclk_vp0", "dclk_vp1", "dclk_vp2";
- 		iommus = <&vop_mmu>;
- 		power-domains = <&power RK3568_PD_VO>;
-+		rockchip,grf = <&grf>;
- 		status = "disabled";
- 
- 		vop_out: ports {
-@@ -687,39 +684,21 @@
- 			#size-cells = <0>;
- 
- 			vp0: port@0 {
-+				reg = <0>;
- 				#address-cells = <1>;
- 				#size-cells = <0>;
--				reg = <0>;
--
--				vp0_out_hdmi: endpoint@0 {
--					reg = <0>;
--					remote-endpoint = <&hdmi_in_vp0>;
--					status = "disabled";
--				};
- 			};
- 
- 			vp1: port@1 {
-+				reg = <1>;
- 				#address-cells = <1>;
- 				#size-cells = <0>;
--				reg = <1>;
--
--				vp1_out_hdmi: endpoint@0 {
--					reg = <0>;
--					remote-endpoint = <&hdmi_in_vp1>;
--					status = "disabled";
--				};
- 			};
- 
- 			vp2: port@2 {
-+				reg = <2>;
- 				#address-cells = <1>;
- 				#size-cells = <0>;
--				reg = <2>;
--
--				vp2_out_hdmi: endpoint@0 {
--					reg = <0>;
--					remote-endpoint = <&hdmi_in_vp2>;
--					status = "disabled";
--				};
- 			};
- 		};
- 	};
-@@ -728,7 +707,6 @@
- 		compatible = "rockchip,rk3568-iommu";
- 		reg = <0x0 0xfe043e00 0x0 0x100>, <0x0 0xfe043f00 0x0 0x100>;
- 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
--		interrupt-names = "vop_mmu";
- 		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
- 		clock-names = "aclk", "iface";
- 		#iommu-cells = <0>;
-@@ -742,14 +720,15 @@
- 		clocks = <&cru PCLK_HDMI_HOST>,
- 			 <&cru CLK_HDMI_SFR>,
- 			 <&cru CLK_HDMI_CEC>,
-+			 <&pmucru CLK_HDMI_REF>,
- 			 <&cru HCLK_VOP>;
--		clock-names = "iahb", "isfr", "cec", "hclk";
-+		clock-names = "iahb", "isfr", "cec", "ref", "hclk";
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&hdmitx_scl &hdmitx_sda &hdmitxm0_cec>;
- 		power-domains = <&power RK3568_PD_VO>;
- 		reg-io-width = <4>;
- 		rockchip,grf = <&grf>;
- 		#sound-dai-cells = <0>;
--		pinctrl-names = "default";
--		pinctrl-0 = <&hdmitx_scl &hdmitx_sda &hdmitxm0_cec>;
- 		status = "disabled";
- 
- 		ports {
-@@ -760,24 +739,12 @@
- 				reg = <0>;
- 				#address-cells = <1>;
- 				#size-cells = <0>;
-+			};
- 
--				hdmi_in_vp0: endpoint@0 {
--					reg = <0>;
--					remote-endpoint = <&vp0_out_hdmi>;
--					status = "disabled";
--				};
--
--				hdmi_in_vp1: endpoint@1 {
--					reg = <1>;
--					remote-endpoint = <&vp1_out_hdmi>;
--					status = "disabled";
--				};
--
--				hdmi_in_vp2: endpoint@2 {
--					reg = <2>;
--					remote-endpoint = <&vp2_out_hdmi>;
--					status = "disabled";
--				};
-+			hdmi_out: port@1 {
-+				reg = <1>;
-+				#address-cells = <1>;
-+				#size-cells = <0>;
- 			};
- 		};
- 	};
-@@ -934,7 +901,7 @@
- 		max-link-speed = <2>;
- 		msi-map = <0x0 &gic 0x0 0x1000>;
- 		num-lanes = <1>;
--		phys = <&combphy2_psq PHY_TYPE_PCIE>;
-+		phys = <&combphy2 PHY_TYPE_PCIE>;
- 		phy-names = "pcie-phy";
- 		power-domains = <&power RK3568_PD_PIPE>;
- 		reg = <0x3 0xc0000000 0x0 0x400000>,
-@@ -1048,6 +1015,43 @@
- 		status = "disabled";
- 	};
- 
-+	i2s2_2ch: i2s@fe420000 {
-+		compatible = "rockchip,rk3568-i2s-tdm";
-+		reg = <0x0 0xfe420000 0x0 0x1000>;
-+		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-+		clocks = <&cru MCLK_I2S2_2CH>, <&cru MCLK_I2S2_2CH>, <&cru HCLK_I2S2_2CH>;
-+		clock-names = "mclk_tx", "mclk_rx", "hclk";
-+		dmas = <&dmac1 4>, <&dmac1 5>;
-+		dma-names = "tx", "rx";
-+		rockchip,cru = <&cru>;
-+		rockchip,grf = <&grf>;
-+		pinctrl-0 = <&i2s2m0_sclktx
-+			     &i2s2m0_lrcktx
-+			     &i2s2m0_sdi
-+			     &i2s2m0_sdo>;
-+		pinctrl-names = "default";
-+		#sound-dai-cells = <0>;
-+		status = "disabled";
-+	};
-+
-+	pdm: pdm@fe440000 {
-+		compatible = "rockchip,rk3568-pdm", "rockchip,pdm";
-+		reg = <0x0 0xfe440000 0x0 0x1000>;
-+		clocks = <&cru MCLK_PDM>, <&cru HCLK_PDM>;
-+		clock-names = "pdm_clk", "pdm_hclk";
-+		dmas = <&dmac1 9>;
-+		dma-names = "rx";
-+		pinctrl-0 = <&pdmm0_clk
-+			     &pdmm0_clk1
-+			     &pdmm0_sdi0
-+			     &pdmm0_sdi1
-+			     &pdmm0_sdi2
-+			     &pdmm0_sdi3>;
-+		pinctrl-names = "default";
-+		#sound-dai-cells = <0>;
-+		status = "disabled";
-+	};
-+
- 	dmac0: dmac@fe530000 {
- 		compatible = "arm,pl330", "arm,primecell";
- 		reg = <0x0 0xfe530000 0x0 0x4000>;
-@@ -1487,47 +1491,15 @@
- 		status = "disabled";
- 	};
- 
--	combphy1_usq: phy@fe830000 {
--		compatible = "rockchip,rk3568-naneng-combphy";
--		reg = <0x0 0xfe830000 0x0 0x100>;
--		#phy-cells = <1>;
--		assigned-clocks = <&pmucru CLK_PCIEPHY1_REF>;
--		assigned-clock-rates = <100000000>;
--		clocks = <&pmucru CLK_PCIEPHY1_REF>, <&cru PCLK_PIPEPHY1>,
--			 <&cru PCLK_PIPE>;
--		clock-names = "ref", "apb", "pipe";
--		resets = <&cru SRST_P_PIPEPHY1>, <&cru SRST_PIPEPHY1>;
--		reset-names = "combphy-apb", "combphy";
--		rockchip,pipe-grf = <&pipegrf>;
--		rockchip,pipe-phy-grf = <&pipe_phy_grf1>;
--		status = "disabled";
--	};
--
--	combphy2_psq: phy@fe840000 {
--		compatible = "rockchip,rk3568-naneng-combphy";
--		reg = <0x0 0xfe840000 0x0 0x100>;
--		#phy-cells = <1>;
--		assigned-clocks = <&pmucru CLK_PCIEPHY2_REF>;
--		assigned-clock-rates = <100000000>;
--		clocks = <&pmucru CLK_PCIEPHY2_REF>, <&cru PCLK_PIPEPHY2>,
--			 <&cru PCLK_PIPE>;
--		clock-names = "ref", "apb", "pipe";
--		resets = <&cru SRST_P_PIPEPHY2>, <&cru SRST_PIPEPHY2>;
--		reset-names = "combphy-apb", "combphy";
--		rockchip,pipe-grf = <&pipegrf>;
--		rockchip,pipe-phy-grf = <&pipe_phy_grf2>;
--		status = "disabled";
--	};
--
--	usb2phy0: usb2-phy@fe8a0000 {
-+	u2phy0: usb2phy@fe8a0000 {
- 		compatible = "rockchip,rk3568-usb2phy";
- 		reg = <0x0 0xfe8a0000 0x0 0x10000>;
- 		clocks = <&pmucru CLK_USBPHY0_REF>;
- 		clock-names = "phyclk";
--		#clock-cells = <0>;
--		clock-output-names = "usb480m_phy";
-+		clock-output-names = "clk_usbphy0_480m";
- 		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
- 		rockchip,usbgrf = <&usb2phy0_grf>;
-+		#clock-cells = <0>;
- 		status = "disabled";
- 
- 		u2phy0_host: host-port {
-@@ -1541,14 +1513,15 @@
- 		};
- 	};
- 
--	usb2phy1: usb2-phy@fe8b0000 {
-+	u2phy1: usb2phy@fe8b0000 {
- 		compatible = "rockchip,rk3568-usb2phy";
- 		reg = <0x0 0xfe8b0000 0x0 0x10000>;
- 		clocks = <&pmucru CLK_USBPHY1_REF>;
- 		clock-names = "phyclk";
--		#clock-cells = <0>;
-+		clock-output-names = "clk_usbphy1_480m";
- 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
- 		rockchip,usbgrf = <&usb2phy1_grf>;
-+		#clock-cells = <0>;
- 		status = "disabled";
- 
- 		u2phy1_host: host-port {
-@@ -1562,6 +1535,38 @@
- 		};
- 	};
- 
-+	combphy1: phy@fe830000 {
-+		compatible = "rockchip,rk3568-naneng-combphy";
-+		reg = <0x0 0xfe830000 0x0 0x100>;
-+		clocks = <&pmucru CLK_PCIEPHY1_REF>,
-+			 <&cru PCLK_PIPEPHY1>,
-+			 <&cru PCLK_PIPE>;
-+		clock-names = "ref", "apb", "pipe";
-+		assigned-clocks = <&pmucru CLK_PCIEPHY1_REF>;
-+		assigned-clock-rates = <100000000>;
-+		resets = <&cru SRST_PIPEPHY1>;
-+		rockchip,pipe-grf = <&pipegrf>;
-+		rockchip,pipe-phy-grf = <&pipe_phy_grf1>;
-+		#phy-cells = <1>;
-+		status = "disabled";
-+	};
-+
-+	combphy2: phy@fe840000 {
-+		compatible = "rockchip,rk3568-naneng-combphy";
-+		reg = <0x0 0xfe840000 0x0 0x100>;
-+		clocks = <&pmucru CLK_PCIEPHY2_REF>,
-+			 <&cru PCLK_PIPEPHY2>,
-+			 <&cru PCLK_PIPE>;
-+		clock-names = "ref", "apb", "pipe";
-+		assigned-clocks = <&pmucru CLK_PCIEPHY2_REF>;
-+		assigned-clock-rates = <100000000>;
-+		resets = <&cru SRST_PIPEPHY2>;
-+		rockchip,pipe-grf = <&pipegrf>;
-+		rockchip,pipe-phy-grf = <&pipe_phy_grf2>;
-+		#phy-cells = <1>;
-+		status = "disabled";
-+	};
-+
- 	pinctrl: pinctrl {
- 		compatible = "rockchip,rk3568-pinctrl";
- 		rockchip,grf = <&grf>;
---- /dev/null
-+++ b/include/dt-bindings/soc/rockchip,vop2.h
-@@ -0,0 +1,14 @@
-+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
-+
-+#ifndef __DT_BINDINGS_ROCKCHIP_VOP2_H
-+#define __DT_BINDINGS_ROCKCHIP_VOP2_H
-+
-+#define RK3568_VOP2_EP_RGB	0
-+#define RK3568_VOP2_EP_HDMI	1
-+#define RK3568_VOP2_EP_EDP	2
-+#define RK3568_VOP2_EP_MIPI0	3
-+#define RK3568_VOP2_EP_LVDS0	4
-+#define RK3568_VOP2_EP_MIPI1	5
-+#define RK3568_VOP2_EP_LVDS1	6
-+
-+#endif /* __DT_BINDINGS_ROCKCHIP_VOP2_H */
diff --git a/package/boot/uboot-rockchip/patches/013-rockchip-rk356x-add-bpi-r2-pro-board.patch b/package/boot/uboot-rockchip/patches/013-rockchip-rk356x-add-bpi-r2-pro-board.patch
deleted file mode 100644
index 0728caea486a..000000000000
--- a/package/boot/uboot-rockchip/patches/013-rockchip-rk356x-add-bpi-r2-pro-board.patch
+++ /dev/null
@@ -1,795 +0,0 @@
-From 89d609d74e4ef84e0e3d399d8763b268b60302fc Mon Sep 17 00:00:00 2001
-From: Marty Jones <mj8263788@gmail.com>
-Date: Sat, 28 May 2022 20:19:38 -0400
-Subject: [PATCH] rockchip: rk356x: add bpi r2 pro board
-
-Signed-off-by: Marty Jones <mj8263788@gmail.com>
----
- arch/arm/dts/Makefile                         |   1 +
- arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi    |  47 ++
- arch/arm/dts/rk3568-bpi-r2-pro.dts            | 532 ++++++++++++++++++
- arch/arm/mach-rockchip/rk3568/Kconfig         |   6 +
- board/rockchip/bpi-r2-pro-rk3568/Kconfig      |  15 +
- board/rockchip/bpi-r2-pro-rk3568/Makefile     |   7 +
- .../bpi-r2-pro-rk3568/bpi-r2-pro-rk3568.c     |   4 +
- configs/bpi-r2-pro-rk3568_defconfig           |  97 ++++
- include/configs/bpi-r2-pro-rk3568.h           |  15 +
- 9 files changed, 724 insertions(+)
- create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
- create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro.dts
- create mode 100644 board/rockchip/bpi-r2-pro-rk3568/Kconfig
- create mode 100644 board/rockchip/bpi-r2-pro-rk3568/Makefile
- create mode 100644 board/rockchip/bpi-r2-pro-rk3568/bpi-r2-pro-rk3568.c
- create mode 100644 configs/bpi-r2-pro-rk3568_defconfig
- create mode 100644 include/configs/bpi-r2-pro-rk3568.h
-
---- a/arch/arm/dts/Makefile
-+++ b/arch/arm/dts/Makefile
-@@ -164,6 +164,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3399) += \
- 	rk3399pro-rock-pi-n10.dtb
- 
- dtb-$(CONFIG_ROCKCHIP_RK3568) += \
-+	rk3568-bpi-r2-pro.dtb \
- 	rk3568-evb.dtb \
- 	rk3566-quartz64-a.dtb
- 
---- /dev/null
-+++ b/arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
-@@ -0,0 +1,47 @@
-+// SPDX-License-Identifier: GPL-2.0+
-+/*
-+ * (C) Copyright 2021 Rockchip Electronics Co., Ltd
-+ */
-+
-+#include "rk3568-u-boot.dtsi"
-+
-+/ {
-+	chosen {
-+		stdout-path = &uart2;
-+		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;
-+	};
-+};
-+
-+&gmac1 {
-+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
-+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
-+	status = "disabled";
-+};
-+
-+&sdmmc0 {
-+	bus-width = <4>;
-+	u-boot,dm-spl;
-+	u-boot,spl-fifo-mode;
-+};
-+
-+&usb_host0_ehci {
-+	vbus-supply = <&vcc5v0_usb_host>;
-+};
-+
-+&usb_host0_ohci {
-+	vbus-supply = <&vcc5v0_usb_host>;
-+};
-+
-+&usb_host1_ehci {
-+	vbus-supply = <&vcc5v0_usb_host>;
-+};
-+
-+&usb_host1_ohci {
-+	vbus-supply = <&vcc5v0_usb_host>;
-+};
-+
-+&uart2 {
-+	clock-frequency = <24000000>;
-+	u-boot,dm-spl;
-+	status = "okay";
-+};
---- /dev/null
-+++ b/arch/arm/dts/rk3568-bpi-r2-pro.dts
-@@ -0,0 +1,532 @@
-+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-+/*
-+ * Author: Frank Wunderlich <frank-w@public-files.de>
-+ *
-+ */
-+
-+/dts-v1/;
-+#include <dt-bindings/gpio/gpio.h>
-+#include <dt-bindings/pinctrl/rockchip.h>
-+#include <dt-bindings/leds/common.h>
-+#include "rk3568.dtsi"
-+
-+/ {
-+	model = "Bananapi-R2 Pro (RK3568) DDR4 Board";
-+	compatible = "rockchip,rk3568-bpi-r2pro", "rockchip,rk3568";
-+
-+	aliases {
-+		ethernet0 = &gmac0;
-+		ethernet1 = &gmac1;
-+		mmc0 = &sdmmc0;
-+		mmc1 = &sdhci;
-+	};
-+
-+	chosen: chosen {
-+		stdout-path = "serial2:1500000n8";
-+	};
-+
-+	leds {
-+		compatible = "gpio-leds";
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&blue_led_pin &green_led_pin>;
-+
-+		blue_led: led-0 {
-+			color = <LED_COLOR_ID_BLUE>;
-+			default-state = "off";
-+			function = LED_FUNCTION_STATUS;
-+			gpios = <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
-+		};
-+
-+		green_led: led-1 {
-+			color = <LED_COLOR_ID_GREEN>;
-+			default-state = "on";
-+			function = LED_FUNCTION_POWER;
-+			gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
-+		};
-+	};
-+
-+	dc_12v: dc-12v {
-+		compatible = "regulator-fixed";
-+		regulator-name = "dc_12v";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <12000000>;
-+		regulator-max-microvolt = <12000000>;
-+	};
-+
-+	vcc3v3_sys: vcc3v3-sys {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc3v3_sys";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <3300000>;
-+		regulator-max-microvolt = <3300000>;
-+		vin-supply = <&dc_12v>;
-+	};
-+
-+	vcc5v0_sys: vcc5v0-sys {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc5v0_sys";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&dc_12v>;
-+	};
-+
-+	vcc5v0_usb: vcc5v0_usb {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc5v0_usb";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&dc_12v>;
-+	};
-+
-+	vcc5v0_usb_host: vcc5v0-usb-host {
-+		compatible = "regulator-fixed";
-+		enable-active-high;
-+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&vcc5v0_usb_host_en>;
-+		regulator-name = "vcc5v0_usb_host";
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&vcc5v0_usb>;
-+	};
-+
-+	vcc5v0_usb_otg: vcc5v0-usb-otg {
-+		compatible = "regulator-fixed";
-+		enable-active-high;
-+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&vcc5v0_usb_otg_en>;
-+		regulator-name = "vcc5v0_usb_otg";
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&vcc5v0_usb>;
-+	};
-+};
-+
-+&combphy0 {
-+	/* used for USB3 */
-+	status = "okay";
-+};
-+
-+&combphy1 {
-+	/* used for USB3 */
-+	status = "okay";
-+};
-+
-+&combphy2 {
-+	/* used for SATA */
-+	status = "okay";
-+};
-+
-+&gmac0 {
-+	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
-+	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
-+	clock_in_out = "input";
-+	phy-mode = "rgmii";
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&gmac0_miim
-+		     &gmac0_tx_bus2
-+		     &gmac0_rx_bus2
-+		     &gmac0_rgmii_clk
-+		     &gmac0_rgmii_bus>;
-+	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
-+	snps,reset-active-low;
-+	/* Reset time is 20ms, 100ms for rtl8211f */
-+	snps,reset-delays-us = <0 20000 100000>;
-+	tx_delay = <0x4f>;
-+	rx_delay = <0x0f>;
-+	status = "okay";
-+
-+	fixed-link {
-+		speed = <1000>;
-+		full-duplex;
-+		pause;
-+	};
-+};
-+
-+&gmac1 {
-+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
-+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
-+	clock_in_out = "output";
-+	phy-handle = <&rgmii_phy1>;
-+	phy-mode = "rgmii";
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&gmac1m1_miim
-+		     &gmac1m1_tx_bus2
-+		     &gmac1m1_rx_bus2
-+		     &gmac1m1_rgmii_clk
-+		     &gmac1m1_rgmii_bus>;
-+
-+	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
-+	snps,reset-active-low;
-+	/* Reset time is 20ms, 100ms for rtl8211f */
-+	snps,reset-delays-us = <0 20000 100000>;
-+
-+	tx_delay = <0x3c>;
-+	rx_delay = <0x2f>;
-+
-+	status = "okay";
-+};
-+
-+&i2c0 {
-+	status = "okay";
-+
-+	rk809: pmic@20 {
-+		compatible = "rockchip,rk809";
-+		reg = <0x20>;
-+		interrupt-parent = <&gpio0>;
-+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
-+		#clock-cells = <1>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&pmic_int>;
-+		rockchip,system-power-controller;
-+		vcc1-supply = <&vcc3v3_sys>;
-+		vcc2-supply = <&vcc3v3_sys>;
-+		vcc3-supply = <&vcc3v3_sys>;
-+		vcc4-supply = <&vcc3v3_sys>;
-+		vcc5-supply = <&vcc3v3_sys>;
-+		vcc6-supply = <&vcc3v3_sys>;
-+		vcc7-supply = <&vcc3v3_sys>;
-+		vcc8-supply = <&vcc3v3_sys>;
-+		vcc9-supply = <&vcc3v3_sys>;
-+		wakeup-source;
-+
-+		regulators {
-+			vdd_logic: DCDC_REG1 {
-+				regulator-name = "vdd_logic";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-init-microvolt = <900000>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-min-microvolt = <500000>;
-+				regulator-max-microvolt = <1350000>;
-+				regulator-ramp-delay = <6001>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vdd_gpu: DCDC_REG2 {
-+				regulator-name = "vdd_gpu";
-+				regulator-init-microvolt = <900000>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-min-microvolt = <500000>;
-+				regulator-max-microvolt = <1350000>;
-+				regulator-ramp-delay = <6001>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc_ddr: DCDC_REG3 {
-+				regulator-name = "vcc_ddr";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-initial-mode = <0x2>;
-+
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+				};
-+			};
-+
-+			vdd_npu: DCDC_REG4 {
-+				regulator-name = "vdd_npu";
-+				regulator-init-microvolt = <900000>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-min-microvolt = <500000>;
-+				regulator-max-microvolt = <1350000>;
-+				regulator-ramp-delay = <6001>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc_1v8: DCDC_REG5 {
-+				regulator-name = "vcc_1v8";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vdda0v9_image: LDO_REG1 {
-+				regulator-name = "vdda0v9_image";
-+				regulator-min-microvolt = <900000>;
-+				regulator-max-microvolt = <900000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vdda_0v9: LDO_REG2 {
-+				regulator-name = "vdda_0v9";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <900000>;
-+				regulator-max-microvolt = <900000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vdda0v9_pmu: LDO_REG3 {
-+				regulator-name = "vdda0v9_pmu";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <900000>;
-+				regulator-max-microvolt = <900000>;
-+
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <900000>;
-+				};
-+			};
-+
-+			vccio_acodec: LDO_REG4 {
-+				regulator-name = "vccio_acodec";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <3300000>;
-+				regulator-max-microvolt = <3300000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vccio_sd: LDO_REG5 {
-+				regulator-name = "vccio_sd";
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <3300000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc3v3_pmu: LDO_REG6 {
-+				regulator-name = "vcc3v3_pmu";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <3300000>;
-+				regulator-max-microvolt = <3300000>;
-+
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <3300000>;
-+				};
-+			};
-+
-+			vcca_1v8: LDO_REG7 {
-+				regulator-name = "vcca_1v8";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcca1v8_pmu: LDO_REG8 {
-+				regulator-name = "vcca1v8_pmu";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <1800000>;
-+				};
-+			};
-+
-+			vcca1v8_image: LDO_REG9 {
-+				regulator-name = "vcca1v8_image";
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc_3v3: SWITCH_REG1 {
-+				regulator-name = "vcc_3v3";
-+				regulator-always-on;
-+				regulator-boot-on;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc3v3_sd: SWITCH_REG2 {
-+				regulator-name = "vcc3v3_sd";
-+				regulator-always-on;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+		};
-+	};
-+};
-+
-+&i2c5 {
-+	/* pin 3 (SDA) + 4 (SCL) of header con2 */
-+	status = "disabled";
-+};
-+
-+&mdio1 {
-+	rgmii_phy1: ethernet-phy@0 {
-+		compatible = "ethernet-phy-ieee802.3-c22";
-+		reg = <0x0>;
-+	};
-+};
-+
-+&pinctrl {
-+	leds {
-+		blue_led_pin: blue-led-pin {
-+			rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+		green_led_pin: green-led-pin {
-+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	pmic {
-+		pmic_int: pmic_int {
-+			rockchip,pins =
-+				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
-+		};
-+	};
-+
-+	usb {
-+		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
-+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+
-+		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
-+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+};
-+
-+&pmu_io_domains {
-+	pmuio1-supply = <&vcc3v3_pmu>;
-+	pmuio2-supply = <&vcc3v3_pmu>;
-+	vccio1-supply = <&vccio_acodec>;
-+	vccio3-supply = <&vccio_sd>;
-+	vccio4-supply = <&vcc_3v3>;
-+	vccio5-supply = <&vcc_3v3>;
-+	vccio6-supply = <&vcc_1v8>;
-+	vccio7-supply = <&vcc_3v3>;
-+	status = "okay";
-+};
-+
-+&pwm8 {
-+	/* fan 5v - gnd - pwm */
-+	status = "okay";
-+};
-+
-+&pwm10 {
-+	/* pin 7 of header con2 */
-+	status = "disabled";
-+};
-+
-+&pwm11 {
-+	/* pin 15 of header con2 */
-+	status = "disabled";
-+};
-+
-+
-+&pwm13 {
-+	/* pin 24 of header con2 */
-+	/* shared with uart9 */
-+	pinctrl-0 = <&pwm13m1_pins>;
-+	status = "disabled";
-+};
-+
-+&saradc {
-+	vref-supply = <&vcca_1v8>;
-+	status = "okay";
-+};
-+
-+&sata2 {
-+	status = "okay";
-+};
-+
-+&sdhci {
-+	bus-width = <8>;
-+	max-frequency = <200000000>;
-+	non-removable;
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
-+	status = "okay";
-+};
-+
-+&sdmmc0 {
-+	bus-width = <4>;
-+	cap-sd-highspeed;
-+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
-+	disable-wp;
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
-+	sd-uhs-sdr104;
-+	vmmc-supply = <&vcc3v3_sd>;
-+	vqmmc-supply = <&vccio_sd>;
-+	status = "okay";
-+};
-+
-+&tsadc {
-+	status = "okay";
-+};
-+
-+&uart0 {
-+	/* pin 8 (TX) + 10 (RX) (RTS:16, CTS:18) of header con2 */
-+	status = "disabled";
-+};
-+
-+&uart2 {
-+	/* debug-uart */
-+	status = "okay";
-+};
-+
-+&uart7 {
-+	/* pin 11 (TX) + 13 (RX) of header con2 */
-+	pinctrl-0 = <&uart7m1_xfer>;
-+	status = "disabled";
-+};
-+
-+&usb_host0_ehci {
-+	status = "okay";
-+};
-+
-+&usb_host0_ohci {
-+	status = "okay";
-+};
-+
-+&usb_host1_ehci {
-+	status = "okay";
-+};
-+
-+&usb_host1_ohci {
-+	status = "okay";
-+};
---- a/arch/arm/mach-rockchip/rk3568/Kconfig
-+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
-@@ -3,6 +3,11 @@ if ROCKCHIP_RK3568
- choice
- 	prompt "RK3568/RK3566 board select"
- 
-+config TARGET_BPI_R2_PRO_RK3568
-+	bool "Banana Pi R2 Pro RK3566 development board"
-+	help
-+	  Banana Pi R2 Pro is a development board Rockchp RK3568.
-+
- config TARGET_EVB_RK3568
- 	bool "RK3568 evaluation board"
- 	help
-@@ -27,6 +32,7 @@ config SYS_SOC
- config SYS_MALLOC_F_LEN
- 	default 0x2000
- 
-+source "board/rockchip/bpi-r2-pro-rk3568/Kconfig"
- source "board/rockchip/evb_rk3568/Kconfig"
- source "board/pine64/quartz64-a-rk3566/Kconfig"
- 
---- /dev/null
-+++ b/board/rockchip/bpi-r2-pro-rk3568/Kconfig
-@@ -0,0 +1,15 @@
-+if TARGET_BPI_R2_PRO_RK3568
-+
-+config SYS_BOARD
-+	default "bpi-r2-pro-rk3568"
-+
-+config SYS_VENDOR
-+	default "rockchip"
-+
-+config SYS_CONFIG_NAME
-+	default "bpi-r2-pro-rk3568"
-+
-+config BOARD_SPECIFIC_OPTIONS # dummy
-+	def_bool y
-+
-+endif
---- /dev/null
-+++ b/board/rockchip/bpi-r2-pro-rk3568/Makefile
-@@ -0,0 +1,7 @@
-+#
-+# (C) Copyright 2021 Rockchip Electronics Co., Ltd
-+#
-+# SPDX-License-Identifier:     GPL-2.0+
-+#
-+
-+obj-y	+= bpi-r2-pro-rk3568.o
---- /dev/null
-+++ b/board/rockchip/bpi-r2-pro-rk3568/bpi-r2-pro-rk3568.c
-@@ -0,0 +1,4 @@
-+// SPDX-License-Identifier: GPL-2.0+
-+/*
-+ * (C) Copyright 2021 Rockchip Electronics Co., Ltd
-+ */
---- /dev/null
-+++ b/configs/bpi-r2-pro-rk3568_defconfig
-@@ -0,0 +1,97 @@
-+CONFIG_ARM=y
-+CONFIG_SKIP_LOWLEVEL_INIT=y
-+CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
-+CONFIG_SPL_LIBCOMMON_SUPPORT=y
-+CONFIG_SPL_LIBGENERIC_SUPPORT=y
-+CONFIG_NR_DRAM_BANKS=2
-+CONFIG_DEFAULT_DEVICE_TREE="rk3568-bpi-r2-pro"
-+CONFIG_ROCKCHIP_RK3568=y
-+CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
-+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
-+CONFIG_SPL_MMC=y
-+CONFIG_SPL_SERIAL=y
-+CONFIG_SPL_STACK_R_ADDR=0x600000
-+CONFIG_TARGET_BPI_R2_PRO_RK3568=y
-+CONFIG_DEBUG_UART_BASE=0xFE660000
-+CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
-+CONFIG_SYS_LOAD_ADDR=0xc00800
-+CONFIG_API=y
-+CONFIG_FIT=y
-+CONFIG_FIT_VERBOSE=y
-+CONFIG_SPL_LOAD_FIT=y
-+CONFIG_OF_SYSTEM_SETUP=y
-+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2-pro.dtb"
-+# CONFIG_SYS_DEVICE_NULLDEV is not set
-+# CONFIG_DISPLAY_CPUINFO is not set
-+CONFIG_DISPLAY_BOARDINFO_LATE=y
-+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-+CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
-+CONFIG_SPL_ATF=y
-+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
-+CONFIG_CMD_BIND=y
-+CONFIG_CMD_CLK=y
-+CONFIG_CMD_GPIO=y
-+CONFIG_CMD_GPT=y
-+CONFIG_CMD_I2C=y
-+CONFIG_CMD_MMC=y
-+CONFIG_CMD_USB=y
-+# CONFIG_CMD_SETEXPR is not set
-+CONFIG_CMD_PMIC=y
-+CONFIG_CMD_REGULATOR=y
-+# CONFIG_SPL_DOS_PARTITION is not set
-+CONFIG_SPL_OF_CONTROL=y
-+CONFIG_OF_LIVE=y
-+CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_DM_WARN=y
-+CONFIG_SPL_REGMAP=y
-+CONFIG_SPL_SYSCON=y
-+CONFIG_SPL_CLK=y
-+CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_ROCKCHIP_GPIO_V2=y
-+CONFIG_SYS_I2C_ROCKCHIP=y
-+CONFIG_MISC=y
-+CONFIG_MMC_HS200_SUPPORT=y
-+CONFIG_SPL_MMC_HS200_SUPPORT=y
-+CONFIG_MMC_DW=y
-+CONFIG_MMC_DW_ROCKCHIP=y
-+CONFIG_MMC_SDHCI=y
-+CONFIG_MMC_SDHCI_SDMA=y
-+CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
-+CONFIG_ETH_DESIGNWARE=y
-+CONFIG_GMAC_ROCKCHIP=y
-+CONFIG_POWER_DOMAIN=y
-+CONFIG_DM_PMIC=y
-+CONFIG_PMIC_RK8XX=y
-+CONFIG_SPL_PMIC_RK8XX=y
-+CONFIG_REGULATOR_PWM=y
-+CONFIG_DM_REGULATOR_FIXED=y
-+CONFIG_SPL_DM_REGULATOR_FIXED=y
-+CONFIG_DM_REGULATOR_GPIO=y
-+CONFIG_REGULATOR_RK8XX=y
-+CONFIG_PWM_ROCKCHIP=y
-+CONFIG_SPL_RAM=y
-+CONFIG_DM_RESET=y
-+CONFIG_BAUDRATE=1500000
-+CONFIG_DEBUG_UART_SHIFT=2
-+CONFIG_SYSRESET=y
-+CONFIG_SYSRESET_PSCI=y
-+CONFIG_USB=y
-+CONFIG_USB_XHCI_HCD=y
-+CONFIG_USB_XHCI_DWC3=y
-+CONFIG_USB_EHCI_HCD=y
-+CONFIG_USB_EHCI_GENERIC=y
-+CONFIG_USB_OHCI_HCD=y
-+CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_USB_DWC3=y
-+CONFIG_USB_DWC3_GENERIC=y
-+CONFIG_ROCKCHIP_USB2_PHY=y
-+CONFIG_USB_KEYBOARD=y
-+CONFIG_USB_HOST_ETHER=y
-+CONFIG_USB_ETHER_LAN75XX=y
-+CONFIG_USB_ETHER_LAN78XX=y
-+CONFIG_USB_ETHER_SMSC95XX=y
-+CONFIG_ERRNO_STR=y
---- /dev/null
-+++ b/include/configs/bpi-r2-pro-rk3568.h
-@@ -0,0 +1,15 @@
-+#ifndef __BPI_R2_PRO_RK3568_H
-+#define __BPI_R2_PRO_RK3568_H
-+
-+#include <configs/rk3568_common.h>
-+
-+#define CONFIG_SUPPORT_EMMC_RPMB
-+
-+#define ROCKCHIP_DEVICE_SETTINGS \
-+			"stdout=serial,vidconsole\0" \
-+			"stderr=serial,vidconsole\0"
-+
-+#define CONFIG_USB_OHCI_NEW
-+#define CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS     2
-+
-+#endif
diff --git a/package/boot/uboot-rockchip/patches/014-uboot-add-Radxa-ROCK-3A-board.patch b/package/boot/uboot-rockchip/patches/014-uboot-add-Radxa-ROCK-3A-board.patch
deleted file mode 100644
index 4f38e6951820..000000000000
--- a/package/boot/uboot-rockchip/patches/014-uboot-add-Radxa-ROCK-3A-board.patch
+++ /dev/null
@@ -1,690 +0,0 @@
-From 443eb96a82563a3b38a3c9548853a5a266dfd072 Mon Sep 17 00:00:00 2001
-From: Marty Jones <mj8263788@gmail.com>
-Date: Sun, 29 May 2022 06:09:59 -0400
-Subject: [PATCH] uboot: add Radxa ROCK 3A board
-
-Signed-off-by: Marty Jones <mj8263788@gmail.com>
----
- arch/arm/dts/Makefile                       |   3 +-
- arch/arm/dts/rk3568-rock-3a-u-boot.dtsi     |  25 +
- arch/arm/dts/rk3568-rock-3a.dts             | 525 ++++++++++++++++++++
- arch/arm/mach-rockchip/rk3568/Kconfig       |   6 +
- board/radxa/rock-3a-rk3568/Kconfig          |  15 +
- board/radxa/rock-3a-rk3568/Makefile         |   4 +
- board/radxa/rock-3a-rk3568/rock-3a-rk3568.c |   1 +
- configs/rock-3a-rk3568_defconfig            |  97 ++++
- include/configs/rock-3a-rk3568.h            |  17 +
- 9 files changed, 692 insertions(+), 1 deletion(-)
- create mode 100644 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
- create mode 100644 arch/arm/dts/rk3568-rock-3a.dts
- create mode 100644 configs/rock-3a-rk3568_defconfig
- create mode 100644 include/configs/rock-3a-rk3568.h
-
---- a/arch/arm/dts/Makefile
-+++ b/arch/arm/dts/Makefile
-@@ -166,7 +166,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3399) += \
- dtb-$(CONFIG_ROCKCHIP_RK3568) += \
- 	rk3568-bpi-r2-pro.dtb \
- 	rk3568-evb.dtb \
--	rk3566-quartz64-a.dtb
-+	rk3566-quartz64-a.dtb \
-+	rk3568-rock-3a.dtb
- 
- dtb-$(CONFIG_ROCKCHIP_RV1108) += \
- 	rv1108-elgin-r1.dtb \
---- /dev/null
-+++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
-@@ -0,0 +1,24 @@
-+// SPDX-License-Identifier: GPL-2.0+
-+/*
-+ * (C) Copyright 2021 Rockchip Electronics Co., Ltd
-+ */
-+
-+#include "rk3568-u-boot.dtsi"
-+
-+/ {
-+	chosen {
-+		stdout-path = &uart2;
-+		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;
-+	};
-+};
-+
-+&sdmmc0 {
-+	bus-width = <4>;
-+	u-boot,spl-fifo-mode;
-+};
-+
-+&uart2 {
-+	u-boot,dm-spl;
-+	clock-frequency = <24000000>;
-+	status = "okay";
-+};
---- /dev/null
-+++ b/arch/arm/dts/rk3568-rock-3a.dts
-@@ -0,0 +1,525 @@
-+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-+
-+/dts-v1/;
-+#include <dt-bindings/gpio/gpio.h>
-+#include <dt-bindings/leds/common.h>
-+#include <dt-bindings/pinctrl/rockchip.h>
-+#include "rk3568.dtsi"
-+
-+/ {
-+	model = "Radxa ROCK3 Model A";
-+	compatible = "radxa,rock3a", "rockchip,rk3568";
-+
-+	aliases {
-+		ethernet0 = &gmac1;
-+		mmc0 = &sdmmc0;
-+		mmc1 = &sdhci;
-+	};
-+
-+	chosen: chosen {
-+		stdout-path = "serial2:1500000n8";
-+	};
-+
-+	leds {
-+		compatible = "gpio-leds";
-+
-+		led_user: led-0 {
-+			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
-+			function = LED_FUNCTION_HEARTBEAT;
-+			color = <LED_COLOR_ID_BLUE>;
-+			linux,default-trigger = "heartbeat";
-+			pinctrl-names = "default";
-+			pinctrl-0 = <&led_user_en>;
-+		};
-+	};
-+
-+	rk809-sound {
-+		compatible = "simple-audio-card";
-+		simple-audio-card,format = "i2s";
-+		simple-audio-card,name = "Analog RK809";
-+		simple-audio-card,mclk-fs = <256>;
-+
-+		simple-audio-card,cpu {
-+			sound-dai = <&i2s1_8ch>;
-+		};
-+
-+		simple-audio-card,codec {
-+			sound-dai = <&rk809>;
-+		};
-+	};
-+
-+	vcc12v_dcin: vcc12v-dcin {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc12v_dcin";
-+		regulator-always-on;
-+		regulator-boot-on;
-+	};
-+
-+	vcc3v3_sys: vcc3v3-sys {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc3v3_sys";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <3300000>;
-+		regulator-max-microvolt = <3300000>;
-+		vin-supply = <&vcc12v_dcin>;
-+	};
-+
-+	vcc5v0_sys: vcc5v0-sys {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc5v0_sys";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&vcc12v_dcin>;
-+	};
-+
-+	vcc5v0_usb: vcc5v0-usb {
-+		compatible = "regulator-fixed";
-+		regulator-name = "vcc5v0_usb";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&vcc12v_dcin>;
-+	};
-+
-+	vcc5v0_usb_host: vcc5v0-usb-host {
-+		compatible = "regulator-fixed";
-+		enable-active-high;
-+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&vcc5v0_usb_host_en>;
-+		regulator-name = "vcc5v0_usb_host";
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&vcc5v0_usb>;
-+	};
-+
-+	vcc5v0_usb_hub: vcc5v0-usb-hub-regulator {
-+		compatible = "regulator-fixed";
-+		enable-active-high;
-+		gpio = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&vcc5v0_usb_hub_en>;
-+		regulator-name = "vcc5v0_usb_hub";
-+		regulator-always-on;
-+		vin-supply = <&vcc5v0_usb>;
-+	};
-+
-+	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
-+		compatible = "regulator-fixed";
-+		enable-active-high;
-+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&vcc5v0_usb_otg_en>;
-+		regulator-name = "vcc5v0_usb_otg";
-+		regulator-min-microvolt = <5000000>;
-+		regulator-max-microvolt = <5000000>;
-+		vin-supply = <&vcc5v0_usb>;
-+	};
-+};
-+
-+&combphy0 {
-+	status = "okay";
-+};
-+
-+&combphy1 {
-+	status = "okay";
-+};
-+
-+&cpu0 {
-+	cpu-supply = <&vdd_cpu>;
-+};
-+
-+&cpu1 {
-+	cpu-supply = <&vdd_cpu>;
-+};
-+
-+&cpu2 {
-+	cpu-supply = <&vdd_cpu>;
-+};
-+
-+&cpu3 {
-+	cpu-supply = <&vdd_cpu>;
-+};
-+
-+&gmac1 {
-+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
-+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
-+	assigned-clock-rates = <0>, <125000000>;
-+	clock_in_out = "output";
-+	phy-handle = <&rgmii_phy1>;
-+	phy-mode = "rgmii-id";
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&gmac1m1_miim
-+		     &gmac1m1_tx_bus2
-+		     &gmac1m1_rx_bus2
-+		     &gmac1m1_rgmii_clk
-+		     &gmac1m1_rgmii_bus>;
-+	status = "okay";
-+};
-+
-+&gpu {
-+	mali-supply = <&vdd_gpu>;
-+	status = "okay";
-+};
-+
-+&i2c0 {
-+	status = "okay";
-+
-+	vdd_cpu: regulator@1c {
-+		compatible = "tcs,tcs4525";
-+		reg = <0x1c>;
-+		fcs,suspend-voltage-selector = <1>;
-+		regulator-name = "vdd_cpu";
-+		regulator-always-on;
-+		regulator-boot-on;
-+		regulator-min-microvolt = <800000>;
-+		regulator-max-microvolt = <1150000>;
-+		regulator-ramp-delay = <2300>;
-+		vin-supply = <&vcc5v0_sys>;
-+
-+		regulator-state-mem {
-+			regulator-off-in-suspend;
-+		};
-+	};
-+
-+	rk809: pmic@20 {
-+		compatible = "rockchip,rk809";
-+		reg = <0x20>;
-+		interrupt-parent = <&gpio0>;
-+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
-+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
-+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
-+		#clock-cells = <1>;
-+		clock-names = "mclk";
-+		clocks = <&cru I2S1_MCLKOUT_TX>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
-+		rockchip,system-power-controller;
-+		#sound-dai-cells = <0>;
-+		vcc1-supply = <&vcc3v3_sys>;
-+		vcc2-supply = <&vcc3v3_sys>;
-+		vcc3-supply = <&vcc3v3_sys>;
-+		vcc4-supply = <&vcc3v3_sys>;
-+		vcc5-supply = <&vcc3v3_sys>;
-+		vcc6-supply = <&vcc3v3_sys>;
-+		vcc7-supply = <&vcc3v3_sys>;
-+		vcc8-supply = <&vcc3v3_sys>;
-+		vcc9-supply = <&vcc3v3_sys>;
-+		wakeup-source;
-+
-+		regulators {
-+			vdd_logic: DCDC_REG1 {
-+				regulator-name = "vdd_logic";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-init-microvolt = <900000>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-min-microvolt = <500000>;
-+				regulator-max-microvolt = <1350000>;
-+				regulator-ramp-delay = <6001>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vdd_gpu: DCDC_REG2 {
-+				regulator-name = "vdd_gpu";
-+				regulator-always-on;
-+				regulator-init-microvolt = <900000>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-min-microvolt = <500000>;
-+				regulator-max-microvolt = <1350000>;
-+				regulator-ramp-delay = <6001>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc_ddr: DCDC_REG3 {
-+				regulator-name = "vcc_ddr";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-initial-mode = <0x2>;
-+
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+				};
-+			};
-+
-+			vdd_npu: DCDC_REG4 {
-+				regulator-name = "vdd_npu";
-+				regulator-init-microvolt = <900000>;
-+				regulator-initial-mode = <0x2>;
-+				regulator-min-microvolt = <500000>;
-+				regulator-max-microvolt = <1350000>;
-+				regulator-ramp-delay = <6001>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc_1v8: DCDC_REG5 {
-+				regulator-name = "vcc_1v8";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vdda0v9_image: LDO_REG1 {
-+				regulator-name = "vdda0v9_image";
-+				regulator-min-microvolt = <900000>;
-+				regulator-max-microvolt = <900000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vdda_0v9: LDO_REG2 {
-+				regulator-name = "vdda_0v9";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <900000>;
-+				regulator-max-microvolt = <900000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vdda0v9_pmu: LDO_REG3 {
-+				regulator-name = "vdda0v9_pmu";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <900000>;
-+				regulator-max-microvolt = <900000>;
-+
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <900000>;
-+				};
-+			};
-+
-+			vccio_acodec: LDO_REG4 {
-+				regulator-name = "vccio_acodec";
-+				regulator-always-on;
-+				regulator-min-microvolt = <3300000>;
-+				regulator-max-microvolt = <3300000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vccio_sd: LDO_REG5 {
-+				regulator-name = "vccio_sd";
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <3300000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc3v3_pmu: LDO_REG6 {
-+				regulator-name = "vcc3v3_pmu";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <3300000>;
-+				regulator-max-microvolt = <3300000>;
-+
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <3300000>;
-+				};
-+			};
-+
-+			vcca_1v8: LDO_REG7 {
-+				regulator-name = "vcca_1v8";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcca1v8_pmu: LDO_REG8 {
-+				regulator-name = "vcca1v8_pmu";
-+				regulator-always-on;
-+				regulator-boot-on;
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+
-+				regulator-state-mem {
-+					regulator-on-in-suspend;
-+					regulator-suspend-microvolt = <1800000>;
-+				};
-+			};
-+
-+			vcca1v8_image: LDO_REG9 {
-+				regulator-name = "vcca1v8_image";
-+				regulator-min-microvolt = <1800000>;
-+				regulator-max-microvolt = <1800000>;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc_3v3: SWITCH_REG1 {
-+				regulator-name = "vcc_3v3";
-+				regulator-always-on;
-+				regulator-boot-on;
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+
-+			vcc3v3_sd: SWITCH_REG2 {
-+				regulator-name = "vcc3v3_sd";
-+
-+				regulator-state-mem {
-+					regulator-off-in-suspend;
-+				};
-+			};
-+		};
-+
-+		codec {
-+			mic-in-differential;
-+		};
-+	};
-+};
-+
-+&i2s1_8ch {
-+	rockchip,trcm-sync-tx-only;
-+	status = "okay";
-+};
-+
-+&mdio1 {
-+	rgmii_phy1: ethernet-phy@0 {
-+		compatible = "ethernet-phy-ieee802.3-c22";
-+		reg = <0x0>;
-+		pinctrl-names = "default";
-+		pinctrl-0 = <&eth_phy_rst>;
-+		reset-assert-us = <20000>;
-+		reset-deassert-us = <100000>;
-+		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
-+	};
-+};
-+
-+&pinctrl {
-+	ethernet {
-+		eth_phy_rst: eth_phy_rst {
-+			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	leds {
-+		led_user_en: led_user_en {
-+			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+
-+	pmic {
-+		pmic_int: pmic_int {
-+			rockchip,pins =
-+				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
-+		};
-+	};
-+
-+	usb {
-+		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
-+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+		vcc5v0_usb_hub_en: vcc5v0_usb_hub_en {
-+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
-+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
-+		};
-+	};
-+};
-+
-+&pmu_io_domains {
-+	pmuio1-supply = <&vcc3v3_pmu>;
-+	pmuio2-supply = <&vcc3v3_pmu>;
-+	vccio1-supply = <&vccio_acodec>;
-+	vccio2-supply = <&vcc_1v8>;
-+	vccio3-supply = <&vccio_sd>;
-+	vccio4-supply = <&vcc_1v8>;
-+	vccio5-supply = <&vcc_3v3>;
-+	vccio6-supply = <&vcc_1v8>;
-+	vccio7-supply = <&vcc_3v3>;
-+	status = "okay";
-+};
-+
-+&saradc {
-+	vref-supply = <&vcca_1v8>;
-+	status = "okay";
-+};
-+
-+&sdhci {
-+	bus-width = <8>;
-+	max-frequency = <200000000>;
-+	non-removable;
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
-+	vmmc-supply = <&vcc_3v3>;
-+	vqmmc-supply = <&vcc_1v8>;
-+	status = "okay";
-+};
-+
-+&sdmmc0 {
-+	bus-width = <4>;
-+	cap-sd-highspeed;
-+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
-+	disable-wp;
-+	pinctrl-names = "default";
-+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
-+	sd-uhs-sdr104;
-+	vmmc-supply = <&vcc3v3_sd>;
-+	vqmmc-supply = <&vccio_sd>;
-+	status = "okay";
-+};
-+
-+&tsadc {
-+	rockchip,hw-tshut-mode = <1>;
-+	rockchip,hw-tshut-polarity = <0>;
-+	status = "okay";
-+};
-+
-+&uart2 {
-+	status = "okay";
-+};
-+
-+&usb_host0_ehci {
-+	status = "okay";
-+};
-+
-+&usb_host0_ohci {
-+	status = "okay";
-+};
-+
-+&usb_host1_ehci {
-+	status = "okay";
-+};
-+
-+&usb_host1_ohci {
-+	status = "okay";
-+};
---- /dev/null
-+++ b/configs/rock-3a-rk3568_defconfig
-@@ -0,0 +1,98 @@
-+CONFIG_ARM=y
-+CONFIG_SKIP_LOWLEVEL_INIT=y
-+CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
-+CONFIG_SPL_LIBCOMMON_SUPPORT=y
-+CONFIG_SPL_LIBGENERIC_SUPPORT=y
-+CONFIG_NR_DRAM_BANKS=2
-+CONFIG_DEFAULT_DEVICE_TREE="rk3568-rock-3a"
-+CONFIG_ROCKCHIP_RK3568=y
-+CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
-+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
-+CONFIG_SPL_MMC=y
-+CONFIG_SPL_SERIAL=y
-+CONFIG_SPL_STACK_R_ADDR=0x600000
-+CONFIG_TARGET_EVB_RK3568=y
-+CONFIG_DEBUG_UART_BASE=0xFE660000
-+CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
-+CONFIG_SYS_LOAD_ADDR=0xc00800
-+CONFIG_API=y
-+CONFIG_FIT=y
-+CONFIG_FIT_VERBOSE=y
-+CONFIG_SPL_LOAD_FIT=y
-+CONFIG_OF_SYSTEM_SETUP=y
-+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-rock-3a.dtb"
-+# CONFIG_SYS_DEVICE_NULLDEV is not set
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=2
-+# CONFIG_DISPLAY_CPUINFO is not set
-+CONFIG_DISPLAY_BOARDINFO_LATE=y
-+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-+CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
-+CONFIG_SPL_ATF=y
-+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
-+CONFIG_CMD_BIND=y
-+CONFIG_CMD_CLK=y
-+CONFIG_CMD_GPIO=y
-+CONFIG_CMD_GPT=y
-+CONFIG_CMD_I2C=y
-+CONFIG_CMD_MMC=y
-+CONFIG_CMD_USB=y
-+# CONFIG_CMD_SETEXPR is not set
-+CONFIG_CMD_PMIC=y
-+CONFIG_CMD_REGULATOR=y
-+# CONFIG_SPL_DOS_PARTITION is not set
-+CONFIG_SPL_OF_CONTROL=y
-+CONFIG_OF_LIVE=y
-+CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_DM_WARN=y
-+CONFIG_SPL_REGMAP=y
-+CONFIG_SPL_SYSCON=y
-+CONFIG_SPL_CLK=y
-+CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_ROCKCHIP_GPIO_V2=y
-+CONFIG_SYS_I2C_ROCKCHIP=y
-+CONFIG_MISC=y
-+CONFIG_MMC_HS200_SUPPORT=y
-+CONFIG_SPL_MMC_HS200_SUPPORT=y
-+CONFIG_MMC_DW=y
-+CONFIG_MMC_DW_ROCKCHIP=y
-+CONFIG_MMC_SDHCI=y
-+CONFIG_MMC_SDHCI_SDMA=y
-+CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
-+CONFIG_ETH_DESIGNWARE=y
-+CONFIG_GMAC_ROCKCHIP=y
-+CONFIG_POWER_DOMAIN=y
-+CONFIG_DM_PMIC=y
-+CONFIG_PMIC_RK8XX=y
-+CONFIG_SPL_PMIC_RK8XX=y
-+CONFIG_REGULATOR_PWM=y
-+CONFIG_DM_REGULATOR_FIXED=y
-+CONFIG_SPL_DM_REGULATOR_FIXED=y
-+CONFIG_DM_REGULATOR_GPIO=y
-+CONFIG_REGULATOR_RK8XX=y
-+CONFIG_PWM_ROCKCHIP=y
-+CONFIG_SPL_RAM=y
-+CONFIG_DM_RESET=y
-+CONFIG_BAUDRATE=1500000
-+CONFIG_DEBUG_UART_SHIFT=2
-+CONFIG_SYSRESET=y
-+CONFIG_SYSRESET_PSCI=y
-+CONFIG_USB=y
-+CONFIG_USB_XHCI_HCD=y
-+CONFIG_USB_XHCI_DWC3=y
-+CONFIG_USB_EHCI_HCD=y
-+CONFIG_USB_EHCI_GENERIC=y
-+CONFIG_USB_OHCI_HCD=y
-+CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_USB_DWC3=y
-+CONFIG_USB_DWC3_GENERIC=y
-+CONFIG_ROCKCHIP_USB2_PHY=y
-+CONFIG_USB_KEYBOARD=y
-+CONFIG_USB_HOST_ETHER=y
-+CONFIG_USB_ETHER_LAN75XX=y
-+CONFIG_USB_ETHER_LAN78XX=y
-+CONFIG_USB_ETHER_SMSC95XX=y
-+CONFIG_ERRNO_STR=y
diff --git a/package/boot/uboot-rockchip/patches/015-uboot-add-NanoPi-R5S-board.patch b/package/boot/uboot-rockchip/patches/015-uboot-add-NanoPi-R5S-board.patch
index b527a261e9ce..f85455cba7ab 100644
--- a/package/boot/uboot-rockchip/patches/015-uboot-add-NanoPi-R5S-board.patch
+++ b/package/boot/uboot-rockchip/patches/015-uboot-add-NanoPi-R5S-board.patch
@@ -26,11 +26,11 @@ Signed-off-by: Marty Jones <mj8263788@gmail.com>
 --- a/arch/arm/dts/Makefile
 +++ b/arch/arm/dts/Makefile
 @@ -166,6 +166,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3399) += \
+ 
  dtb-$(CONFIG_ROCKCHIP_RK3568) += \
- 	rk3568-bpi-r2-pro.dtb \
  	rk3568-evb.dtb \
 +	rk3568-nanopi-r5s.dtb \
- 	rk3566-quartz64-a.dtb \
+ 	rk3566-radxa-cm3-io.dtb \
  	rk3568-rock-3a.dtb
  
 --- /dev/null
@@ -41,7 +41,7 @@ Signed-off-by: Marty Jones <mj8263788@gmail.com>
 + * (C) Copyright 2021 Rockchip Electronics Co., Ltd
 + */
 +
-+#include "rk3568-u-boot.dtsi"
++#include "rk356x-u-boot.dtsi"
 +
 +/ {
 +	chosen {
@@ -73,175 +73,97 @@ Signed-off-by: Marty Jones <mj8263788@gmail.com>
 +	model = "FriendlyElec NanoPi R5S";
 +	compatible = "friendlyelec,nanopi-r5s", "rockchip,rk3568";
 +};
---- a/arch/arm/mach-rockchip/rk3568/Kconfig
-+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
-@@ -13,6 +13,11 @@ config TARGET_EVB_RK3568
- 	help
- 	  RK3568 EVB is a evaluation board for Rockchp RK3568.
- 
-+config TARGET_NANOPI_R5S_RK3568
-+	bool "NanoPi R5S board"
-+	help
-+	  NanoPi R5S FriendlyElec is a board for Rockchp RK3568.
-+
- config TARGET_QUARTZ64_A_RK3566
- 	bool "Quartz64 Model A RK3566 development board"
- 	help
-@@ -39,6 +44,7 @@ config SYS_MALLOC_F_LEN
- 
- source "board/rockchip/bpi-r2-pro-rk3568/Kconfig"
- source "board/rockchip/evb_rk3568/Kconfig"
-+source "board/friendlyelec/nanopi-r5s-rk3568/Kconfig"
- source "board/pine64/quartz64-a-rk3566/Kconfig"
- source "board/radxa/rock-3a-rk3568/Kconfig"
- 
---- /dev/null
-+++ b/board/friendlyelec/nanopi-r5s-rk3568/Kconfig
-@@ -0,0 +1,15 @@
-+if TARGET_NANOPI_R5S_RK3568
-+
-+config SYS_BOARD
-+	default "nanopi-r5s-rk3568"
-+
-+config SYS_VENDOR
-+	default "friendlyelec"
-+
-+config SYS_CONFIG_NAME
-+	default "nanopi-r5s-rk3568"
-+
-+config BOARD_SPECIFIC_OPTIONS # dummy
-+	def_bool y
-+
-+endif
---- /dev/null
-+++ b/board/friendlyelec/nanopi-r5s-rk3568/Makefile
-@@ -0,0 +1,4 @@
-+# SPDX-License-Identifier:     GPL-2.0+
-+#
-+
-+obj-y	+= nanopi-r5s-rk3568.o
---- /dev/null
-+++ b/board/friendlyelec/nanopi-r5s-rk3568/nanopi-r5s-rk3568.c
-@@ -0,0 +1,4 @@
-+ // SPDX-License-Identifier: GPL-2.0+
-+/*
-+ *
-+ */
 --- /dev/null
 +++ b/configs/nanopi-r5s-rk3568_defconfig
-@@ -0,0 +1,98 @@
+@@ -0,0 +1,91 @@
 +CONFIG_ARM=y
 +CONFIG_SKIP_LOWLEVEL_INIT=y
++CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
++CONFIG_TEXT_BASE=0x00a00000
 +CONFIG_SPL_LIBCOMMON_SUPPORT=y
 +CONFIG_SPL_LIBGENERIC_SUPPORT=y
 +CONFIG_NR_DRAM_BANKS=2
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3568-nanopi-r5s"
 +CONFIG_ROCKCHIP_RK3568=y
 +CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
++CONFIG_SPL_BOARD_INIT=y
 +CONFIG_SPL_MMC=y
 +CONFIG_SPL_SERIAL=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
-+CONFIG_TARGET_NANOPI_R5S_RK3568=y
++CONFIG_TARGET_EVB_RK3568=y
++CONFIG_SPL_STACK=0x400000
 +CONFIG_DEBUG_UART_BASE=0xFE660000
 +CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
 +CONFIG_SYS_LOAD_ADDR=0xc00800
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=2
-+CONFIG_API=y
++CONFIG_DEBUG_UART=y
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
 +CONFIG_SPL_LOAD_FIT=y
-+CONFIG_OF_SYSTEM_SETUP=y
 +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-nanopi-r5s.dtb"
-+# CONFIG_SYS_DEVICE_NULLDEV is not set
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x4000000
++CONFIG_SPL_BSS_MAX_SIZE=0x4000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
++CONFIG_SPL_ADC=y
 +CONFIG_SPL_ATF=y
-+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
-+CONFIG_CMD_BIND=y
-+CONFIG_CMD_CLK=y
++CONFIG_CMD_ADC=y
 +CONFIG_CMD_GPIO=y
 +CONFIG_CMD_GPT=y
 +CONFIG_CMD_I2C=y
 +CONFIG_CMD_MMC=y
 +CONFIG_CMD_USB=y
-+# CONFIG_CMD_SETEXPR is not set
-+CONFIG_CMD_PMIC=y
 +CONFIG_CMD_REGULATOR=y
++# CONFIG_CMD_SETEXPR is not set
 +# CONFIG_SPL_DOS_PARTITION is not set
 +CONFIG_SPL_OF_CONTROL=y
 +CONFIG_OF_LIVE=y
 +CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_DM_WARN=y
 +CONFIG_SPL_REGMAP=y
 +CONFIG_SPL_SYSCON=y
 +CONFIG_SPL_CLK=y
++CONFIG_CLK_SCMI=y
++CONFIG_RESET_SCMI=y
 +CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_ROCKCHIP_GPIO_V2=y
 +CONFIG_SYS_I2C_ROCKCHIP=y
 +CONFIG_MISC=y
-+CONFIG_MMC_HS200_SUPPORT=y
-+CONFIG_SPL_MMC_HS200_SUPPORT=y
++CONFIG_SUPPORT_EMMC_RPMB=y
 +CONFIG_MMC_DW=y
 +CONFIG_MMC_DW_ROCKCHIP=y
 +CONFIG_MMC_SDHCI=y
 +CONFIG_MMC_SDHCI_SDMA=y
 +CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
-+CONFIG_POWER_DOMAIN=y
 +CONFIG_DM_PMIC=y
 +CONFIG_PMIC_RK8XX=y
 +CONFIG_SPL_PMIC_RK8XX=y
++CONFIG_PHY_ROCKCHIP_INNO_USB2=y
++CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 +CONFIG_REGULATOR_PWM=y
 +CONFIG_DM_REGULATOR_FIXED=y
 +CONFIG_SPL_DM_REGULATOR_FIXED=y
-+CONFIG_DM_REGULATOR_GPIO=y
 +CONFIG_REGULATOR_RK8XX=y
 +CONFIG_PWM_ROCKCHIP=y
 +CONFIG_SPL_RAM=y
-+CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSRESET=y
-+CONFIG_SYSRESET_PSCI=y
 +CONFIG_USB=y
 +CONFIG_USB_XHCI_HCD=y
 +CONFIG_USB_XHCI_DWC3=y
 +CONFIG_USB_EHCI_HCD=y
 +CONFIG_USB_EHCI_GENERIC=y
-+CONFIG_USB_OHCI_HCD=y
-+CONFIG_USB_OHCI_GENERIC=y
 +CONFIG_USB_DWC3=y
 +CONFIG_USB_DWC3_GENERIC=y
-+CONFIG_ROCKCHIP_USB2_PHY=y
-+CONFIG_USB_KEYBOARD=y
-+CONFIG_USB_HOST_ETHER=y
-+CONFIG_USB_ETHER_LAN75XX=y
-+CONFIG_USB_ETHER_LAN78XX=y
-+CONFIG_USB_ETHER_SMSC95XX=y
 +CONFIG_ERRNO_STR=y
---- /dev/null
-+++ b/include/configs/nanopi-r5s-rk3568.h
-@@ -0,0 +1,14 @@
-+/* SPDX-License-Identifier: GPL-2.0+ */
-+
-+#ifndef __NANOPI_R5S_RK3568_H
-+#define __NANOPI_R5S_RK3568_H
-+
-+#include <configs/rk3568_common.h>
-+
-+#define CONFIG_SUPPORT_EMMC_RPMB
-+
-+#define ROCKCHIP_DEVICE_SETTINGS \
-+			"stdout=serial,vidconsole\0" \
-+			"stderr=serial,vidconsole\0"
-+
-+#endif
diff --git a/package/boot/uboot-rockchip/patches/016-rk356x-ddr-fix-dbw-detect-bug.patch b/package/boot/uboot-rockchip/patches/016-rk356x-ddr-fix-dbw-detect-bug.patch
deleted file mode 100644
index 563c6c29ac17..000000000000
--- a/package/boot/uboot-rockchip/patches/016-rk356x-ddr-fix-dbw-detect-bug.patch
+++ /dev/null
@@ -1,42 +0,0 @@
-From c9a8a3b5fb4ae210c5a5acb1538b0e961c5d1421 Mon Sep 17 00:00:00 2001
-From: Tang Yun ping <typ@rock-chips.com>
-Date: Wed, 23 Jun 2021 19:48:59 +0800
-Subject: [PATCH] rk356x: ddr: fix dbw detect bug
-
-Signed-off-by: Tang Yun ping <typ@rock-chips.com>
-Change-Id: Ifadad00853eb0ad43a68f12335fd243e6a1bc04b
----
- drivers/ram/rockchip/sdram_common.c | 12 ++++++------
- 1 file changed, 6 insertions(+), 6 deletions(-)
-
---- a/drivers/ram/rockchip/sdram_common.c
-+++ b/drivers/ram/rockchip/sdram_common.c
-@@ -299,22 +299,22 @@ int sdram_detect_dbw(struct sdram_cap_info *cap_info, u32 dram_type)
- 		bw = cap_info->bw;
- 		cs_cap = (1 << (row + col + bk + bw - 20));
- 		if (bw == 2) {
--			if (cs_cap <= 0x2000000) /* 256Mb */
-+			if (cs_cap <= 0x20) /* 256Mb */
- 				die_bw_0 = (col < 9) ? 2 : 1;
--			else if (cs_cap <= 0x10000000) /* 2Gb */
-+			else if (cs_cap <= 0x100) /* 2Gb */
- 				die_bw_0 = (col < 10) ? 2 : 1;
--			else if (cs_cap <= 0x40000000) /* 8Gb */
-+			else if (cs_cap <= 0x400) /* 8Gb */
- 				die_bw_0 = (col < 11) ? 2 : 1;
- 			else
- 				die_bw_0 = (col < 12) ? 2 : 1;
- 			if (cs > 1) {
- 				row = cap_info->cs1_row;
- 				cs_cap = (1 << (row + col + bk + bw - 20));
--				if (cs_cap <= 0x2000000) /* 256Mb */
-+				if (cs_cap <= 0x20) /* 256Mb */
- 					die_bw_0 = (col < 9) ? 2 : 1;
--				else if (cs_cap <= 0x10000000) /* 2Gb */
-+				else if (cs_cap <= 0x100) /* 2Gb */
- 					die_bw_0 = (col < 10) ? 2 : 1;
--				else if (cs_cap <= 0x40000000) /* 8Gb */
-+				else if (cs_cap <= 0x400) /* 8Gb */
- 					die_bw_0 = (col < 11) ? 2 : 1;
- 				else
- 					die_bw_0 = (col < 12) ? 2 : 1;
diff --git a/package/boot/uboot-rockchip/patches/017-gpio-rockchip-fix-building-for-spl.patch b/package/boot/uboot-rockchip/patches/017-gpio-rockchip-fix-building-for-spl.patch
deleted file mode 100644
index 9632bbf5a73b..000000000000
--- a/package/boot/uboot-rockchip/patches/017-gpio-rockchip-fix-building-for-spl.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From c7496009386dbac8f8d18a94258031f30683d7c6 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Sun, 20 Feb 2022 07:59:02 -0500
-Subject: [PATCH] gpio: rockchip: fix building for spl
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- drivers/gpio/rk_gpio.c | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
---- a/common/spl/Kconfig
-+++ b/common/spl/Kconfig
-@@ -454,6 +454,11 @@ config SPL_FIT_IMAGE_TINY
- 	  ensure this information is available to the next image
- 	  invoked).
- 
-+config SPL_ADC
-+	bool "Support ADC drivers in SPL"
-+	help
-+	  Enable ADC drivers in SPL.
-+
- config SPL_CACHE
- 	bool "Support CACHE drivers"
- 	help
---- a/drivers/Makefile
-+++ b/drivers/Makefile
-@@ -1,5 +1,6 @@
- # SPDX-License-Identifier: GPL-2.0+
- 
-+obj-$(CONFIG_$(SPL_)ADC) += adc/
- obj-$(CONFIG_$(SPL_TPL_)BOOTCOUNT_LIMIT) += bootcount/
- obj-$(CONFIG_$(SPL_TPL_)BUTTON) += button/
- obj-$(CONFIG_$(SPL_TPL_)CACHE) += cache/
---- a/drivers/gpio/rk_gpio.c
-+++ b/drivers/gpio/rk_gpio.c
-@@ -118,7 +118,7 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
- }
- 
- /* Simple SPL interface to GPIOs */
--#ifdef CONFIG_SPL_BUILD
-+#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_ROCKCHIP_GPIO_V2)
- 
- enum {
- 	PULL_NONE_1V8 = 0,
diff --git a/package/boot/uboot-rockchip/patches/018-clk-rockchip-rk3568-fix-reset-handler.patch b/package/boot/uboot-rockchip/patches/018-clk-rockchip-rk3568-fix-reset-handler.patch
deleted file mode 100644
index 632394a89868..000000000000
--- a/package/boot/uboot-rockchip/patches/018-clk-rockchip-rk3568-fix-reset-handler.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From 5011ceb0da47f7c3d54d20b45b7df884e6e92ac5 Mon Sep 17 00:00:00 2001
-From: Peter Geis <pgwipeout@gmail.com>
-Date: Sun, 20 Feb 2022 07:58:38 -0500
-Subject: [PATCH] clk: rockchip: rk3568: fix reset handler
-
-Signed-off-by: Peter Geis <pgwipeout@gmail.com>
----
- drivers/clk/rockchip/clk_rk3568.c | 2 ++
- 1 file changed, 2 insertions(+)
-
---- a/drivers/clk/rockchip/clk_rk3568.c
-+++ b/drivers/clk/rockchip/clk_rk3568.c
-@@ -14,6 +14,7 @@
- #include <asm/arch-rockchip/clock.h>
- #include <asm/arch-rockchip/hardware.h>
- #include <asm/io.h>
-+#include <dm/device-internal.h>
- #include <dm/lists.h>
- #include <dt-bindings/clock/rk3568-cru.h>
- 
-@@ -2934,6 +2935,7 @@ static int rk3568_clk_bind(struct udevice *dev)
- 						    glb_srst_fst);
- 		priv->glb_srst_snd_value = offsetof(struct rk3568_cru,
- 						    glb_srsr_snd);
-+		dev_set_priv(sys_child, priv);
- 	}
- 
- #if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
diff --git a/package/boot/uboot-rockchip/patches/018-driver-Makefile-support-adc-in-SPL.patch b/package/boot/uboot-rockchip/patches/018-driver-Makefile-support-adc-in-SPL.patch
new file mode 100644
index 000000000000..072abfc2e0df
--- /dev/null
+++ b/package/boot/uboot-rockchip/patches/018-driver-Makefile-support-adc-in-SPL.patch
@@ -0,0 +1,35 @@
+From 2d7c904f271ffd19086cafe7cd6548ec5b1a5a83 Mon Sep 17 00:00:00 2001
+From: Jason Zhu <jason.zhu@rock-chips.com>
+Date: Thu, 12 Mar 2020 15:04:51 +0800
+Subject: [PATCH] driver: Makefile: support adc in SPL
+
+Signed-off-by: Jason Zhu <jason.zhu@rock-chips.com>
+Change-Id: I915becbf9597aa070001d3368d8daf9079565fc9
+---
+ common/spl/Kconfig | 6 ++++++
+ drivers/Makefile   | 2 +-
+ 2 files changed, 7 insertions(+), 1 deletion(-)
+
+--- a/common/spl/Kconfig
++++ b/common/spl/Kconfig
+@@ -587,6 +587,11 @@ config SPL_FIT_IMAGE_TINY
+ 	  ensure this information is available to the next image
+ 	  invoked).
+ 
++config SPL_ADC
++	bool "Support ADC drivers in SPL"
++	help
++	  Enable ADC drivers in SPL.
++
+ config SPL_CACHE
+ 	bool "Support CACHE drivers"
+ 	help
+--- a/drivers/Makefile
++++ b/drivers/Makefile
+@@ -1,5 +1,6 @@
+ # SPDX-License-Identifier: GPL-2.0+
+ 
++obj-$(CONFIG_$(SPL_)ADC) += adc/
+ obj-$(CONFIG_$(SPL_TPL_)BLK) += block/
+ obj-$(CONFIG_$(SPL_TPL_)BOOTCOUNT_LIMIT) += bootcount/
+ obj-$(CONFIG_$(SPL_TPL_)BUTTON) += button/
diff --git a/package/boot/uboot-rockchip/patches/019-rockchip-handle-bootrom-mode-in-spl.patch b/package/boot/uboot-rockchip/patches/019-rockchip-handle-bootrom-mode-in-spl.patch
index df7acc398149..54a452d7bc3e 100644
--- a/package/boot/uboot-rockchip/patches/019-rockchip-handle-bootrom-mode-in-spl.patch
+++ b/package/boot/uboot-rockchip/patches/019-rockchip-handle-bootrom-mode-in-spl.patch
@@ -19,7 +19,7 @@ Signed-off-by: Peter Geis <pgwipeout@gmail.com>
 -ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
 -
  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
- # inside of boot_mode.c when CONFIG_BOOT_MODE_REG is 0.  This way,
+ # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
  # we can have the preprocessor correctly recognise both 0x0 and 0
  # meaning "turn it off".
 -obj-y += boot_mode.o
@@ -116,9 +116,9 @@ Signed-off-by: Peter Geis <pgwipeout@gmail.com>
  	return 0;
  }
 @@ -164,3 +193,26 @@ int ft_system_setup(void *blob, struct bd_info *bd)
- 	return 0;
- };
  #endif
+ 	return 0;
+ }
 +
 +#ifdef CONFIG_SPL_BUILD
 +
diff --git a/package/boot/uboot-rockchip/patches/100-Convert-CONFIG_USB_OHCI_NEW-et-al-to-Kconfig.patch b/package/boot/uboot-rockchip/patches/100-Convert-CONFIG_USB_OHCI_NEW-et-al-to-Kconfig.patch
deleted file mode 100644
index ff5a97f33215..000000000000
--- a/package/boot/uboot-rockchip/patches/100-Convert-CONFIG_USB_OHCI_NEW-et-al-to-Kconfig.patch
+++ /dev/null
@@ -1,282 +0,0 @@
-From cd6a45a41fb2c19884ac87afade87b4d53601929 Mon Sep 17 00:00:00 2001
-From: Tom Rini <trini@konsulko.com>
-Date: Sat, 25 Jun 2022 11:02:31 -0400
-Subject: [PATCH] Convert CONFIG_USB_OHCI_NEW et al to Kconfig
-
-This converts the following to Kconfig:
-    CONFIG_SYS_OHCI_SWAP_REG_ACCESS
-    CONFIG_SYS_USB_OHCI_CPU_INIT
-    CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS
-    CONFIG_SYS_USB_OHCI_SLOT_NAME
-    CONFIG_USB_ATMEL
-    CONFIG_USB_ATMEL_CLK_SEL_PLLB
-    CONFIG_USB_ATMEL_CLK_SEL_UPLL
-    CONFIG_USB_OHCI_LPC32XX
-    CONFIG_USB_OHCI_NEW
-
-Signed-off-by: Tom Rini <trini@konsulko.com>
----
-
-diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
-index 4d6d235cb125..c81437300c74 100644
---- a/configs/evb-rk3328_defconfig
-+++ b/configs/evb-rk3328_defconfig
-@@ -99,6 +99,7 @@ CONFIG_USB_EHCI_HCD=y
- CONFIG_USB_EHCI_GENERIC=y
- CONFIG_USB_OHCI_HCD=y
- CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=1
- CONFIG_USB_DWC2=y
- CONFIG_USB_DWC3=y
- # CONFIG_USB_DWC3_GADGET is not set
-diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
-index 41793ca7e486..15c2e1698c20 100644
---- a/configs/nanopi-r2s-rk3328_defconfig
-+++ b/configs/nanopi-r2s-rk3328_defconfig
-@@ -102,6 +102,7 @@ CONFIG_USB_EHCI_HCD=y
- CONFIG_USB_EHCI_GENERIC=y
- CONFIG_USB_OHCI_HCD=y
- CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=1
- CONFIG_USB_DWC2=y
- CONFIG_USB_DWC3=y
- # CONFIG_USB_DWC3_GADGET is not set
-diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
-index ab25abc1a031..43b90c7879b7 100644
---- a/configs/roc-cc-rk3328_defconfig
-+++ b/configs/roc-cc-rk3328_defconfig
-@@ -108,6 +108,7 @@ CONFIG_USB_EHCI_HCD=y
- CONFIG_USB_EHCI_GENERIC=y
- CONFIG_USB_OHCI_HCD=y
- CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=1
- CONFIG_USB_DWC2=y
- CONFIG_USB_DWC3=y
- # CONFIG_USB_DWC3_GADGET is not set
-diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
-index 1d51a267b93a..7d95e171f7f4 100644
---- a/configs/rock-pi-e-rk3328_defconfig
-+++ b/configs/rock-pi-e-rk3328_defconfig
-@@ -109,6 +109,7 @@ CONFIG_USB_EHCI_HCD=y
- CONFIG_USB_EHCI_GENERIC=y
- CONFIG_USB_OHCI_HCD=y
- CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=1
- CONFIG_USB_DWC2=y
- CONFIG_USB_DWC3=y
- # CONFIG_USB_DWC3_GADGET is not set
-diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
-index 640fe558d414..bc333a5e2a6a 100644
---- a/configs/rock64-rk3328_defconfig
-+++ b/configs/rock64-rk3328_defconfig
-@@ -106,6 +106,7 @@ CONFIG_USB_EHCI_HCD=y
- CONFIG_USB_EHCI_GENERIC=y
- CONFIG_USB_OHCI_HCD=y
- CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=1
- CONFIG_USB_DWC2=y
- CONFIG_USB_DWC3=y
- # CONFIG_USB_DWC3_GADGET is not set
-diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
-index 78e50dbfbcb7..bb5b2143691d 100644
---- a/configs/rock960-rk3399_defconfig
-+++ b/configs/rock960-rk3399_defconfig
-@@ -74,6 +74,7 @@ CONFIG_USB_EHCI_HCD=y
- CONFIG_USB_EHCI_GENERIC=y
- CONFIG_USB_OHCI_HCD=y
- CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=2
- CONFIG_USB_DWC3=y
- CONFIG_USB_KEYBOARD=y
- CONFIG_USB_HOST_ETHER=y
-diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
-index 4d2a5b32e31c..ef28fe6a937a 100644
---- a/configs/rockpro64-rk3399_defconfig
-+++ b/configs/rockpro64-rk3399_defconfig
-@@ -87,6 +87,7 @@ CONFIG_USB_EHCI_HCD=y
- CONFIG_USB_EHCI_GENERIC=y
- CONFIG_USB_OHCI_HCD=y
- CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=2
- CONFIG_USB_DWC3=y
- CONFIG_USB_DWC3_GENERIC=y
- CONFIG_USB_KEYBOARD=y
-diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
-index 0b82c2fdaf71..31ae9f74e7ac 100644
---- a/drivers/usb/host/Kconfig
-+++ b/drivers/usb/host/Kconfig
-@@ -297,10 +297,17 @@ config USB_EHCI_TXFIFO_THRESH
-	  Enables support for the on-chip EHCI controller on FSL chips.
- endif # USB_EHCI_HCD
- 
-+config USB_OHCI_NEW
-+	bool
-+
-+config SYS_USB_OHCI_CPU_INIT
-+	bool
-+
- config USB_OHCI_HCD
- 	bool "OHCI HCD (USB 1.1) support"
- 	depends on DM && OF_CONTROL
- 	select USB_HOST
-+	select USB_OHCI_NEW
- 	---help---
- 	  The Open Host Controller Interface (OHCI) is a standard for accessing
- 	  USB 1.1 host controller hardware.  It does more in hardware than Intel's
-@@ -332,6 +339,19 @@ config USB_OHCI_DA8XX
- 
- endif # USB_OHCI_HCD
- 
-+config SYS_USB_OHCI_SLOT_NAME
-+	string "Display name for the OHCI controller"
-+	depends on USB_OHCI_NEW && !DM_USB
-+
-+config SYS_USB_OHCI_MAX_ROOT_PORTS
-+	int "Maximal number of ports of the root hub"
-+	depends on USB_OHCI_NEW
-+	default 1 if ARCH_SUNXI
-+
-+config SYS_OHCI_SWAP_REG_ACCESS
-+	bool "Perform byte swapping on OHCI controller register accesses"
-+	depends on USB_OHCI_NEW
-+
- config USB_UHCI_HCD
- 	bool "UHCI HCD (most Intel and VIA) support"
- 	select USB_HOST
-@@ -381,3 +401,27 @@ config USB_R8A66597_HCD
- 	---help---
- 	  This enables support for the on-chip Renesas R8A66597 USB 2.0
- 	  controller, present in various RZ and SH SoCs.
-+
-+config USB_ATMEL
-+	bool "AT91 OHCI USB support"
-+	depends on ARCH_AT91
-+	select SYS_USB_OHCI_CPU_INIT
-+	select USB_OHCI_NEW
-+
-+choice
-+	prompt "Clock for OHCI"
-+	depends on USB_ATMEL
-+
-+config USB_ATMEL_CLK_SEL_PLLB
-+	bool "PLLB"
-+
-+config USB_ATMEL_CLK_SEL_UPLL
-+	bool "UPLL"
-+
-+endchoice
-+
-+config USB_OHCI_LPC32XX
-+	bool "LPC32xx USB OHCI support"
-+	depends on ARCH_LPC32XX
-+	select SYS_USB_OHCI_CPU_INIT
-+	select USB_OHCI_NEW
-diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
-index 8ceabaf45c1b..9b955c1bd678 100644
---- a/drivers/usb/host/ohci-at91.c
-+++ b/drivers/usb/host/ohci-at91.c
-@@ -5,9 +5,6 @@
-  */
- 
- #include <common.h>
--
--#if defined(CONFIG_USB_OHCI_NEW) && defined(CONFIG_SYS_USB_OHCI_CPU_INIT)
--
- #include <asm/arch/clk.h>
- 
- int usb_cpu_init(void)
-@@ -65,5 +62,3 @@ int usb_cpu_init_fail(void)
- {
- 	return usb_cpu_stop();
- }
--
--#endif /* defined(CONFIG_USB_OHCI) && defined(CONFIG_SYS_USB_OHCI_CPU_INIT) */
-diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
-index 163f0ef17b11..5d23058aaf6a 100644
---- a/drivers/usb/host/ohci-generic.c
-+++ b/drivers/usb/host/ohci-generic.c
-@@ -14,10 +14,6 @@
- #include <reset.h>
- #include "ohci.h"
- 
--#if !defined(CONFIG_USB_OHCI_NEW)
--# error "Generic OHCI driver requires CONFIG_USB_OHCI_NEW"
--#endif
--
- struct generic_ohci {
- 	ohci_t ohci;
- 	struct clk *clocks;	/* clock list */
-diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
-index a38cd25eb85f..7699f2e6b15a 100644
---- a/drivers/usb/host/ohci.h
-+++ b/drivers/usb/host/ohci.h
-@@ -151,7 +151,7 @@ struct ohci_hcca {
-  * Maximum number of root hub ports.
-  */
- #ifndef CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS
--# error "CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS undefined!"
-+#define CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS 1
- #endif
- 
- /*
-diff --git a/include/configs/evb_rk3399.h b/include/configs/evb_rk3399.h
-index 492b7b4df128..b7e850370b31 100644
---- a/include/configs/evb_rk3399.h
-+++ b/include/configs/evb_rk3399.h
-@@ -15,7 +15,4 @@
- 
- #define SDRAM_BANK_SIZE			(2UL << 30)
- 
--#define CONFIG_USB_OHCI_NEW
--#define CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS     2
--
- #endif
-diff --git a/include/configs/gru.h b/include/configs/gru.h
-index b1084bb21d4d..be2dc79968c0 100644
---- a/include/configs/gru.h
-+++ b/include/configs/gru.h
-@@ -13,7 +13,4 @@
- 
- #include <configs/rk3399_common.h>
- 
--#define CONFIG_USB_OHCI_NEW
--#define CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS	2
--
- #endif
-diff --git a/include/configs/rk3328_common.h b/include/configs/rk3328_common.h
-index 90183579202d..165b78ff3309 100644
---- a/include/configs/rk3328_common.h
-+++ b/include/configs/rk3328_common.h
-@@ -30,8 +30,4 @@
- 	"partitions=" PARTS_DEFAULT \
- 	BOOTENV
- 
--/* rockchip ohci host driver */
--#define CONFIG_USB_OHCI_NEW
--#define CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS	1
--
- #endif
-diff --git a/include/configs/rock960_rk3399.h b/include/configs/rock960_rk3399.h
-index 2edad710284f..6099d2fa55a6 100644
---- a/include/configs/rock960_rk3399.h
-+++ b/include/configs/rock960_rk3399.h
-@@ -14,7 +14,4 @@
- #include <configs/rk3399_common.h>
- 
- #define SDRAM_BANK_SIZE			(2UL << 30)
--
--#define CONFIG_USB_OHCI_NEW
--#define CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS     2
- #endif
-diff --git a/include/configs/rockpro64_rk3399.h b/include/configs/rockpro64_rk3399.h
-index 903e9df527c1..9195b9b99e41 100644
---- a/include/configs/rockpro64_rk3399.h
-+++ b/include/configs/rockpro64_rk3399.h
-@@ -14,7 +14,4 @@
- #include <configs/rk3399_common.h>
- 
- #define SDRAM_BANK_SIZE			(2UL << 30)
--
--#define CONFIG_USB_OHCI_NEW
--#define CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS     2
- #endif
diff --git a/package/boot/uboot-rockchip/patches/104-mkimage-add-public-key-for-image.patch b/package/boot/uboot-rockchip/patches/104-mkimage-add-public-key-for-image.patch
deleted file mode 100644
index 8c8e79cf17ff..000000000000
--- a/package/boot/uboot-rockchip/patches/104-mkimage-add-public-key-for-image.patch
+++ /dev/null
@@ -1,166 +0,0 @@
---- a/include/image.h
-+++ b/include/image.h
-@@ -1020,21 +1020,6 @@ int fit_image_hash_get_value(const void
- 
- int fit_set_timestamp(void *fit, int noffset, time_t timestamp);
- 
--/**
-- * fit_pre_load_data() - add public key to fdt blob
-- *
-- * Adds public key to the node pre load.
-- *
-- * @keydir:	Directory containing keys
-- * @keydest:	FDT blob to write public key
-- * @fit:	Pointer to the FIT format image header
-- *
-- * returns:
-- *	0, on success
-- *	< 0, on failure
-- */
--int fit_pre_load_data(const char *keydir, void *keydest, void *fit);
--
- int fit_cipher_data(const char *keydir, void *keydest, void *fit,
- 		    const char *comment, int require_keys,
- 		    const char *engine_id, const char *cmdname);
---- a/tools/fit_image.c
-+++ b/tools/fit_image.c
-@@ -59,9 +59,6 @@ static int fit_add_file_data(struct imag
- 		ret = fit_set_timestamp(ptr, 0, time);
- 	}
- 
--	if (!ret)
--		ret = fit_pre_load_data(params->keydir, dest_blob, ptr);
--
- 	if (!ret) {
- 		ret = fit_cipher_data(params->keydir, dest_blob, ptr,
- 				      params->comment,
---- a/tools/image-host.c
-+++ b/tools/image-host.c
-@@ -14,11 +14,6 @@
- #include <image.h>
- #include <version.h>
- 
--#include <openssl/pem.h>
--#include <openssl/evp.h>
--
--#define IMAGE_PRE_LOAD_PATH                             "/image/pre-load/sig"
--
- /**
-  * fit_set_hash_value - set hash value in requested has node
-  * @fit: pointer to the FIT format image header
-@@ -1116,115 +1111,6 @@ static int fit_config_add_verification_d
- 	return 0;
- }
- 
--/*
-- * 0) open file (open)
-- * 1) read certificate (PEM_read_X509)
-- * 2) get public key (X509_get_pubkey)
-- * 3) provide der format (d2i_RSAPublicKey)
-- */
--static int read_pub_key(const char *keydir, const void *name,
--			unsigned char **pubkey, int *pubkey_len)
--{
--	char path[1024];
--	EVP_PKEY *key = NULL;
--	X509 *cert;
--	FILE *f;
--	int ret;
--
--	memset(path, 0, 1024);
--	snprintf(path, sizeof(path), "%s/%s.crt", keydir, (char *)name);
--
--	/* Open certificate file */
--	f = fopen(path, "r");
--	if (!f) {
--		fprintf(stderr, "Couldn't open RSA certificate: '%s': %s\n",
--			path, strerror(errno));
--		return -EACCES;
--	}
--
--	/* Read the certificate */
--	cert = NULL;
--	if (!PEM_read_X509(f, &cert, NULL, NULL)) {
--		printf("Couldn't read certificate");
--		ret = -EINVAL;
--		goto err_cert;
--	}
--
--	/* Get the public key from the certificate. */
--	key = X509_get_pubkey(cert);
--	if (!key) {
--		printf("Couldn't read public key\n");
--		ret = -EINVAL;
--		goto err_pubkey;
--	}
--
--	/* Get DER form */
--	ret = i2d_PublicKey(key, pubkey);
--	if (ret < 0) {
--		printf("Couldn't get DER form\n");
--		ret = -EINVAL;
--		goto err_pubkey;
--	}
--
--	*pubkey_len = ret;
--	ret = 0;
--
--err_pubkey:
--	X509_free(cert);
--err_cert:
--	fclose(f);
--	return ret;
--}
--
--int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
--{
--	int pre_load_noffset;
--	const void *algo_name;
--	const void *key_name;
--	unsigned char *pubkey = NULL;
--	int ret, pubkey_len;
--
--	if (!keydir || !keydest || !fit)
--		return 0;
--
--	/* Search node pre-load sig */
--	pre_load_noffset = fdt_path_offset(keydest, IMAGE_PRE_LOAD_PATH);
--	if (pre_load_noffset < 0) {
--		ret = 0;
--		goto out;
--	}
--
--	algo_name = fdt_getprop(keydest, pre_load_noffset, "algo-name", NULL);
--	key_name  = fdt_getprop(keydest, pre_load_noffset, "key-name", NULL);
--
--	/* Check that all mandatory properties are present */
--	if (!algo_name || !key_name) {
--		if (!algo_name)
--			printf("The property algo-name is missing in the node %s\n",
--			       IMAGE_PRE_LOAD_PATH);
--		if (!key_name)
--			printf("The property key-name is missing in the node %s\n",
--			       IMAGE_PRE_LOAD_PATH);
--		ret = -EINVAL;
--		goto out;
--	}
--
--	/* Read public key */
--	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
--	if (ret < 0)
--		goto out;
--
--	/* Add the public key to the device tree */
--	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
--			  pubkey, pubkey_len);
--	if (ret)
--		printf("Can't set public-key in node %s (ret = %d)\n",
--		       IMAGE_PRE_LOAD_PATH, ret);
--
-- out:
--	return ret;
--}
--
- int fit_cipher_data(const char *keydir, void *keydest, void *fit,
- 		    const char *comment, int require_keys,
- 		    const char *engine_id, const char *cmdname)
diff --git a/package/boot/uboot-rockchip/patches/105-Only-build-dtc-if-needed.patch b/package/boot/uboot-rockchip/patches/105-Only-build-dtc-if-needed.patch
deleted file mode 100644
index ad0407708d85..000000000000
--- a/package/boot/uboot-rockchip/patches/105-Only-build-dtc-if-needed.patch
+++ /dev/null
@@ -1,125 +0,0 @@
---- a/Makefile
-+++ b/Makefile
-@@ -413,13 +413,7 @@ PERL		= perl
- PYTHON		?= python
- PYTHON2		= python2
- PYTHON3		?= python3
--
--# The devicetree compiler and pylibfdt are automatically built unless DTC is
--# provided. If DTC is provided, it is assumed the pylibfdt is available too.
--DTC_INTREE	:= $(objtree)/scripts/dtc/dtc
--DTC		?= $(DTC_INTREE)
--DTC_MIN_VERSION	:= 010406
--
-+DTC		?= $(objtree)/scripts/dtc/dtc
- CHECK		= sparse
- 
- CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
-@@ -2070,29 +2064,9 @@ endif
- 
- endif
- 
--# Check dtc and pylibfdt, if DTC is provided, else build them
- PHONY += scripts_dtc
- scripts_dtc: scripts_basic
--	$(Q)if test "$(DTC)" = "$(DTC_INTREE)"; then \
--		$(MAKE) $(build)=scripts/dtc; \
--	else \
--		if ! $(DTC) -v >/dev/null; then \
--			echo '*** Failed to check dtc version: $(DTC)'; \
--			false; \
--		else \
--			if test "$(call dtc-version)" -lt $(DTC_MIN_VERSION); then \
--				echo '*** Your dtc is too old, please upgrade to dtc $(DTC_MIN_VERSION) or newer'; \
--				false; \
--			else \
--				if [ -n "$(CONFIG_PYLIBFDT)" ]; then \
--					if ! echo "import libfdt" | $(PYTHON3) 2>/dev/null; then \
--						echo '*** pylibfdt does not seem to be available with $(PYTHON3)'; \
--						false; \
--					fi; \
--				fi; \
--			fi; \
--		fi; \
--	fi
-+	$(Q)$(MAKE) $(build)=scripts/dtc
- 
- # ---------------------------------------------------------------------------
- quiet_cmd_cpp_lds = LDS     $@
---- a/doc/build/gcc.rst
-+++ b/doc/build/gcc.rst
-@@ -131,27 +131,6 @@ Further important build parameters are
- * O=<dir> - generate all output files in directory <dir>, including .config
- * V=1 - verbose build
- 
--Devicetree compiler
--~~~~~~~~~~~~~~~~~~~
--
--Boards that use `CONFIG_OF_CONTROL` (i.e. almost all of them) need the
--devicetree compiler (dtc). Those with `CONFIG_PYLIBFDT` need pylibfdt, a Python
--library for accessing devicetree data. Suitable versions of these are included
--in the U-Boot tree in `scripts/dtc` and built automatically as needed.
--
--To use the system versions of these, use the DTC parameter, for example
--
--.. code-block:: bash
--
--    DTC=/usr/bin/dtc make
--
--In this case, dtc and pylibfdt are not built. The build checks that the version
--of dtc is new enough. It also makes sure that pylibfdt is present, if needed
--(see `scripts_dtc` in the Makefile).
--
--Note that the :doc:`tools` are always built with the included version of libfdt
--so it is not possible to build U-Boot tools with a system libfdt, at present.
--
- Other build targets
- ~~~~~~~~~~~~~~~~~~~
- 
---- a/dts/Kconfig
-+++ b/dts/Kconfig
-@@ -5,6 +5,9 @@
- config SUPPORT_OF_CONTROL
- 	bool
- 
-+config DTC
-+	bool
-+
- config PYLIBFDT
- 	bool
- 
-@@ -21,6 +24,7 @@ menu "Device Tree Control"
- 
- config OF_CONTROL
- 	bool "Run-time configuration via Device Tree"
-+	select DTC
- 	select OF_LIBFDT if !OF_PLATDATA
- 	select OF_REAL if !OF_PLATDATA
- 	help
---- a/scripts/Makefile
-+++ b/scripts/Makefile
-@@ -10,3 +10,4 @@ always		:= $(hostprogs-y)
- 
- # Let clean descend into subdirs
- subdir-	+= basic kconfig dtc
-+subdir-$(CONFIG_DTC)	+= dtc
---- a/scripts/dtc-version.sh
-+++ b/scripts/dtc-version.sh
-@@ -10,16 +10,11 @@
- dtc="$*"
- 
- if [ ${#dtc} -eq 0 ]; then
--	echo "Error: No dtc command specified"
-+	echo "Error: No dtc command specified."
- 	printf "Usage:\n\t$0 <dtc-command>\n"
- 	exit 1
- fi
- 
--if ! which $dtc >/dev/null ; then
--	echo "Error: Cannot find dtc: $dtc"
--	exit 1
--fi
--
- MAJOR=$($dtc -v | head -1 | awk '{print $NF}' | cut -d . -f 1)
- MINOR=$($dtc -v | head -1 | awk '{print $NF}' | cut -d . -f 2)
- PATCH=$($dtc -v | head -1 | awk '{print $NF}' | cut -d . -f 3 | cut -d - -f 1)
diff --git a/package/boot/uboot-rockchip/patches/106-no-kwbimage.patch b/package/boot/uboot-rockchip/patches/106-no-kwbimage.patch
index 65d14f5bece8..224c14af9165 100644
--- a/package/boot/uboot-rockchip/patches/106-no-kwbimage.patch
+++ b/package/boot/uboot-rockchip/patches/106-no-kwbimage.patch
@@ -1,6 +1,6 @@
 --- a/tools/Makefile
 +++ b/tools/Makefile
-@@ -119,7 +119,6 @@ dumpimage-mkimage-objs := aisimage.o \
+@@ -113,7 +113,6 @@ dumpimage-mkimage-objs := aisimage.o \
  			imximage.o \
  			imx8image.o \
  			imx8mimage.o \
diff --git a/package/boot/uboot-rockchip/patches/110-force-pylibfdt-build.patch b/package/boot/uboot-rockchip/patches/110-force-pylibfdt-build.patch
new file mode 100644
index 000000000000..d34ed6f2ae55
--- /dev/null
+++ b/package/boot/uboot-rockchip/patches/110-force-pylibfdt-build.patch
@@ -0,0 +1,30 @@
+--- a/Makefile
++++ b/Makefile
+@@ -2000,26 +2000,7 @@ endif
+ # Check dtc and pylibfdt, if DTC is provided, else build them
+ PHONY += scripts_dtc
+ scripts_dtc: scripts_basic
+-	$(Q)if test "$(DTC)" = "$(DTC_INTREE)"; then \
+-		$(MAKE) $(build)=scripts/dtc; \
+-	else \
+-		if ! $(DTC) -v >/dev/null; then \
+-			echo '*** Failed to check dtc version: $(DTC)'; \
+-			false; \
+-		else \
+-			if test "$(call dtc-version)" -lt $(DTC_MIN_VERSION); then \
+-				echo '*** Your dtc is too old, please upgrade to dtc $(DTC_MIN_VERSION) or newer'; \
+-				false; \
+-			else \
+-				if [ -n "$(CONFIG_PYLIBFDT)" ]; then \
+-					if ! echo "import libfdt" | $(PYTHON3) 2>/dev/null; then \
+-						echo '*** pylibfdt does not seem to be available with $(PYTHON3)'; \
+-						false; \
+-					fi; \
+-				fi; \
+-			fi; \
+-		fi; \
+-	fi
++	$(MAKE) $(build)=scripts/dtc
+ 
+ # ---------------------------------------------------------------------------
+ quiet_cmd_cpp_lds = LDS     $@
diff --git a/package/boot/uboot-rockchip/patches/111-fix-mkimage-host-build.patch b/package/boot/uboot-rockchip/patches/111-fix-mkimage-host-build.patch
new file mode 100644
index 000000000000..cd65c1321fc3
--- /dev/null
+++ b/package/boot/uboot-rockchip/patches/111-fix-mkimage-host-build.patch
@@ -0,0 +1,24 @@
+--- a/tools/image-host.c
++++ b/tools/image-host.c
+@@ -1125,6 +1125,7 @@ static int fit_config_add_verification_d
+  * 2) get public key (X509_get_pubkey)
+  * 3) provide der format (d2i_RSAPublicKey)
+  */
++#ifdef CONFIG_TOOLS_LIBCRYPTO
+ static int read_pub_key(const char *keydir, const void *name,
+ 			unsigned char **pubkey, int *pubkey_len)
+ {
+@@ -1178,6 +1179,13 @@ err_cert:
+ 	fclose(f);
+ 	return ret;
+ }
++#else
++static int read_pub_key(const char *keydir, const void *name,
++			unsigned char **pubkey, int *pubkey_len)
++{
++	return -ENOSYS;
++}
++#endif
+ 
+ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
+ {
diff --git a/package/boot/uboot-rockchip/patches/120-clk-scmi-Add-Kconfig-option-for-SPL.patch b/package/boot/uboot-rockchip/patches/120-clk-scmi-Add-Kconfig-option-for-SPL.patch
new file mode 100644
index 000000000000..bb6d96515c2f
--- /dev/null
+++ b/package/boot/uboot-rockchip/patches/120-clk-scmi-Add-Kconfig-option-for-SPL.patch
@@ -0,0 +1,72 @@
+From 734b9d9e33919efbec63b1bfe48f25ce16dbd59a Mon Sep 17 00:00:00 2001
+From: Jonas Karlman <jonas@kwiboo.se>
+Date: Fri, 17 Mar 2023 19:16:45 +0000
+Subject: [PATCH] clk: scmi: Add Kconfig option for SPL
+
+Building U-Boot SPL with CLK_SCMI and SCMI_FIRMWARE Kconfig options
+enabled and SPL_FIRMWARE disabled result in the following error.
+
+  drivers/clk/clk_scmi.o: in function `scmi_clk_gate':
+  drivers/clk/clk_scmi.c:84: undefined reference to `devm_scmi_process_msg'
+  drivers/clk/clk_scmi.c:88: undefined reference to `scmi_to_linux_errno'
+  drivers/clk/clk_scmi.o: in function `scmi_clk_get_rate':
+  drivers/clk/clk_scmi.c:113: undefined reference to `devm_scmi_process_msg'
+  drivers/clk/clk_scmi.c:117: undefined reference to `scmi_to_linux_errno'
+  drivers/clk/clk_scmi.o: in function `scmi_clk_set_rate':
+  drivers/clk/clk_scmi.c:139: undefined reference to `devm_scmi_process_msg'
+  drivers/clk/clk_scmi.c:143: undefined reference to `scmi_to_linux_errno'
+  drivers/clk/clk_scmi.o: in function `scmi_clk_probe':
+  drivers/clk/clk_scmi.c:157: undefined reference to `devm_scmi_of_get_channel'
+  make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
+  make: *** [Makefile:2043: spl/u-boot-spl] Error 2
+
+Add Kconfig option so that CLK_SCMI can be disabled in SPL to fix this.
+
+Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
+Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
+Link: https://patchwork.ozlabs.org/project/uboot/patch/20230317191638.2558279-2-jonas@kwiboo.se/
+---
+ drivers/clk/Kconfig                       | 8 ++++++++
+ drivers/clk/Makefile                      | 2 +-
+ drivers/firmware/scmi/scmi_agent-uclass.c | 2 +-
+ 3 files changed, 10 insertions(+), 2 deletions(-)
+
+--- a/drivers/clk/Kconfig
++++ b/drivers/clk/Kconfig
+@@ -166,6 +166,14 @@ config CLK_SCMI
+ 	  by a SCMI agent based on SCMI clock protocol communication
+ 	  with a SCMI server.
+ 
++config SPL_CLK_SCMI
++	bool "Enable SCMI clock driver in SPL"
++	depends on SCMI_FIRMWARE && SPL_FIRMWARE
++	help
++	  Enable this option if you want to support clock devices exposed
++	  by a SCMI agent based on SCMI clock protocol communication
++	  with a SCMI server in SPL.
++
+ config CLK_HSDK
+ 	bool "Enable cgu clock driver for HSDK boards"
+ 	depends on CLK && TARGET_HSDK
+--- a/drivers/clk/Makefile
++++ b/drivers/clk/Makefile
+@@ -39,7 +39,7 @@ obj-$(CONFIG_CLK_MVEBU) += mvebu/
+ obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
+ obj-$(CONFIG_CLK_OWL) += owl/
+ obj-$(CONFIG_CLK_RENESAS) += renesas/
+-obj-$(CONFIG_CLK_SCMI) += clk_scmi.o
++obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
+ obj-$(CONFIG_CLK_SIFIVE) += sifive/
+ obj-$(CONFIG_CLK_UNIPHIER) += uniphier/
+ obj-$(CONFIG_CLK_VERSACLOCK) += clk_versaclock.o
+--- a/drivers/firmware/scmi/scmi_agent-uclass.c
++++ b/drivers/firmware/scmi/scmi_agent-uclass.c
+@@ -75,7 +75,7 @@ static int scmi_bind_protocols(struct udevice *dev)
+ 		name = ofnode_get_name(node);
+ 		switch (protocol_id) {
+ 		case SCMI_PROTOCOL_ID_CLOCK:
+-			if (IS_ENABLED(CONFIG_CLK_SCMI))
++			if (CONFIG_IS_ENABLED(CLK_SCMI))
+ 				drv = DM_DRIVER_GET(scmi_clock);
+ 			break;
+ 		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
diff --git a/package/boot/uboot-rockchip/patches/121-pinctrl-rockchip-Fix-IO-mux-selection-on.patch b/package/boot/uboot-rockchip/patches/121-pinctrl-rockchip-Fix-IO-mux-selection-on.patch
new file mode 100644
index 000000000000..e6a15ce3c9b0
--- /dev/null
+++ b/package/boot/uboot-rockchip/patches/121-pinctrl-rockchip-Fix-IO-mux-selection-on.patch
@@ -0,0 +1,126 @@
+From 7db635cf638dfad08a50e26a6d02e1b6e7a9d7c5 Mon Sep 17 00:00:00 2001
+From: Jonas Karlman <jonas@kwiboo.se>
+Date: Sat, 18 Mar 2023 23:30:42 +0000
+Subject: [PATCH] pinctrl: rockchip: Fix IO mux selection on RK3568
+
+IO mux selection is not working correctly for all pins. Sync mux route
+data from linux to add any missing and update wrong trigger pins to fix
+this. Also apply the pull-up fix needed for GPIO0 D3-D6.
+
+Fixes: 1977d746aa54 ("rockchip: rk3568: add rk3568 pinctrl driver")
+Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
+Link: https://patchwork.ozlabs.org/project/uboot/patch/20230318233039.799975-1-jonas@kwiboo.se/
+---
+ drivers/pinctrl/rockchip/pinctrl-rk3568.c | 66 +++++++++++++----------
+ 1 file changed, 38 insertions(+), 28 deletions(-)
+
+--- a/drivers/pinctrl/rockchip/pinctrl-rk3568.c
++++ b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
+@@ -13,6 +13,12 @@
+ #include "pinctrl-rockchip.h"
+ 
+ static struct rockchip_mux_route_data rk3568_mux_route_data[] = {
++	MR_PMUGRF(RK_GPIO0, RK_PB7, RK_FUNC_1, 0x0110, RK_GENMASK_VAL(1, 0, 0)), /* PWM0 IO mux selection M0 */
++	MR_PMUGRF(RK_GPIO0, RK_PC7, RK_FUNC_2, 0x0110, RK_GENMASK_VAL(1, 0, 1)), /* PWM0 IO mux selection M1 */
++	MR_PMUGRF(RK_GPIO0, RK_PC0, RK_FUNC_1, 0x0110, RK_GENMASK_VAL(3, 2, 0)), /* PWM1 IO mux selection M0 */
++	MR_PMUGRF(RK_GPIO0, RK_PB5, RK_FUNC_4, 0x0110, RK_GENMASK_VAL(3, 2, 1)), /* PWM1 IO mux selection M1 */
++	MR_PMUGRF(RK_GPIO0, RK_PC1, RK_FUNC_1, 0x0110, RK_GENMASK_VAL(5, 4, 0)), /* PWM2 IO mux selection M0 */
++	MR_PMUGRF(RK_GPIO0, RK_PB6, RK_FUNC_4, 0x0110, RK_GENMASK_VAL(5, 4, 1)), /* PWM2 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO0, RK_PB3, RK_FUNC_2, 0x0300, RK_GENMASK_VAL(0, 0, 0)), /* CAN0 IO mux selection M0 */
+ 	MR_TOPGRF(RK_GPIO2, RK_PA1, RK_FUNC_4, 0x0300, RK_GENMASK_VAL(0, 0, 1)), /* CAN0 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO1, RK_PA1, RK_FUNC_3, 0x0300, RK_GENMASK_VAL(2, 2, 0)), /* CAN1 IO mux selection M0 */
+@@ -33,30 +39,22 @@ static struct rockchip_mux_route_data rk3568_mux_route_data[] = {
+ 	MR_TOPGRF(RK_GPIO2, RK_PB1, RK_FUNC_2, 0x0304, RK_GENMASK_VAL(2, 2, 1)), /* I2C4 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO3, RK_PB4, RK_FUNC_4, 0x0304, RK_GENMASK_VAL(4, 4, 0)), /* I2C5 IO mux selection M0 */
+ 	MR_TOPGRF(RK_GPIO4, RK_PD0, RK_FUNC_2, 0x0304, RK_GENMASK_VAL(4, 4, 1)), /* I2C5 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(6, 6, 0)), /* PWM4 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(6, 6, 1)), /* PWM4 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(8, 8, 0)), /* PWM5 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(8, 8, 1)), /* PWM5 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(10, 10, 0)), /* PWM6 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(10, 10, 1)), /* PWM6 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(12, 12, 0)), /* PWM7 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(12, 12, 1)), /* PWM7 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(14, 14, 0)), /* PWM8 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0304, RK_GENMASK_VAL(14, 14, 1)), /* PWM8 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(0, 0, 0)), /* PWM9 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(0, 0, 1)), /* PWM9 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(2, 2, 0)), /* PWM10 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(2, 2, 1)), /* PWM10 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(4, 4, 0)), /* PWM11 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(4, 4, 1)), /* PWM11 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(6, 6, 0)), /* PWM12 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(6, 6, 1)), /* PWM12 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(8, 8, 0)), /* PWM13 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(8, 8, 1)), /* PWM13 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(10, 10, 0)), /* PWM14 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(10, 10, 1)), /* PWM14 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(12, 12, 0)), /* PWM15 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(12, 12, 1)), /* PWM15 IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PB1, RK_FUNC_5, 0x0304, RK_GENMASK_VAL(14, 14, 0)), /* PWM8 IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO1, RK_PD5, RK_FUNC_4, 0x0304, RK_GENMASK_VAL(14, 14, 1)), /* PWM8 IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PB2, RK_FUNC_5, 0x0308, RK_GENMASK_VAL(0, 0, 0)), /* PWM9 IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO1, RK_PD6, RK_FUNC_4, 0x0308, RK_GENMASK_VAL(0, 0, 1)), /* PWM9 IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PB5, RK_FUNC_5, 0x0308, RK_GENMASK_VAL(2, 2, 0)), /* PWM10 IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO2, RK_PA1, RK_FUNC_2, 0x0308, RK_GENMASK_VAL(2, 2, 1)), /* PWM10 IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PB6, RK_FUNC_5, 0x0308, RK_GENMASK_VAL(4, 4, 0)), /* PWM11 IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO4, RK_PC0, RK_FUNC_3, 0x0308, RK_GENMASK_VAL(4, 4, 1)), /* PWM11 IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PB7, RK_FUNC_2, 0x0308, RK_GENMASK_VAL(6, 6, 0)), /* PWM12 IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO4, RK_PC5, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(6, 6, 1)), /* PWM12 IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PC0, RK_FUNC_2, 0x0308, RK_GENMASK_VAL(8, 8, 0)), /* PWM13 IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO4, RK_PC6, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(8, 8, 1)), /* PWM13 IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PC4, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(10, 10, 0)), /* PWM14 IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(10, 10, 1)), /* PWM14 IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PC5, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(12, 12, 0)), /* PWM15 IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO4, RK_PC3, RK_FUNC_1, 0x0308, RK_GENMASK_VAL(12, 12, 1)), /* PWM15 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_3, 0x0308, RK_GENMASK_VAL(14, 14, 0)), /* SDMMC2 IO mux selection M0 */
+ 	MR_TOPGRF(RK_GPIO3, RK_PA5, RK_FUNC_5, 0x0308, RK_GENMASK_VAL(14, 14, 1)), /* SDMMC2 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO0, RK_PB5, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(0, 0, 0)), /* SPI0 IO mux selection M0 */
+@@ -68,7 +66,7 @@ static struct rockchip_mux_route_data rk3568_mux_route_data[] = {
+ 	MR_TOPGRF(RK_GPIO4, RK_PB3, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(6, 6, 0)), /* SPI3 IO mux selection M0 */
+ 	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(6, 6, 1)), /* SPI3 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO2, RK_PB4, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(8, 8, 0)), /* UART1 IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO0, RK_PD1, RK_FUNC_1, 0x030c, RK_GENMASK_VAL(8, 8, 1)), /* UART1 IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PD6, RK_FUNC_4, 0x030c, RK_GENMASK_VAL(8, 8, 1)), /* UART1 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO0, RK_PD1, RK_FUNC_1, 0x030c, RK_GENMASK_VAL(10, 10, 0)), /* UART2 IO mux selection M0 */
+ 	MR_TOPGRF(RK_GPIO1, RK_PD5, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(10, 10, 1)), /* UART2 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO1, RK_PA1, RK_FUNC_2, 0x030c, RK_GENMASK_VAL(12, 12, 0)), /* UART3 IO mux selection M0 */
+@@ -81,7 +79,7 @@ static struct rockchip_mux_route_data rk3568_mux_route_data[] = {
+ 	MR_TOPGRF(RK_GPIO1, RK_PD5, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(2, 2, 1)), /* UART6 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO2, RK_PA6, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(5, 4, 0)), /* UART7 IO mux selection M0 */
+ 	MR_TOPGRF(RK_GPIO3, RK_PC4, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(5, 4, 1)), /* UART7 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD2, RK_FUNC_1, 0x0310, RK_GENMASK_VAL(5, 4, 2)), /* UART7 IO mux selection M2 */
++	MR_TOPGRF(RK_GPIO4, RK_PA2, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(5, 4, 2)), /* UART7 IO mux selection M2 */
+ 	MR_TOPGRF(RK_GPIO2, RK_PC5, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(6, 6, 0)), /* UART8 IO mux selection M0 */
+ 	MR_TOPGRF(RK_GPIO2, RK_PD7, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(6, 6, 1)), /* UART8 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO2, RK_PB0, RK_FUNC_3, 0x0310, RK_GENMASK_VAL(9, 8, 0)), /* UART9 IO mux selection M0 */
+@@ -94,8 +92,11 @@ static struct rockchip_mux_route_data rk3568_mux_route_data[] = {
+ 	MR_TOPGRF(RK_GPIO4, RK_PB6, RK_FUNC_5, 0x0310, RK_GENMASK_VAL(12, 12, 1)), /* I2S2 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO3, RK_PA2, RK_FUNC_4, 0x0310, RK_GENMASK_VAL(14, 14, 0)), /* I2S3 IO mux selection M0 */
+ 	MR_TOPGRF(RK_GPIO4, RK_PC2, RK_FUNC_5, 0x0310, RK_GENMASK_VAL(14, 14, 1)), /* I2S3 IO mux selection M1 */
+-	MR_TOPGRF(RK_GPIO1, RK_PA6, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(0, 0, 0)), /* PDM IO mux selection M0 */
+-	MR_TOPGRF(RK_GPIO3, RK_PD6, RK_FUNC_5, 0x0314, RK_GENMASK_VAL(0, 0, 1)), /* PDM IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO1, RK_PA4, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO1, RK_PA6, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(1, 0, 0)), /* PDM IO mux selection M0 */
++	MR_TOPGRF(RK_GPIO3, RK_PD6, RK_FUNC_5, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO4, RK_PA0, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(1, 0, 1)), /* PDM IO mux selection M1 */
++	MR_TOPGRF(RK_GPIO3, RK_PC4, RK_FUNC_5, 0x0314, RK_GENMASK_VAL(1, 0, 2)), /* PDM IO mux selection M2 */
+ 	MR_TOPGRF(RK_GPIO0, RK_PA5, RK_FUNC_3, 0x0314, RK_GENMASK_VAL(3, 2, 0)), /* PCIE20 IO mux selection M0 */
+ 	MR_TOPGRF(RK_GPIO2, RK_PD0, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(3, 2, 1)), /* PCIE20 IO mux selection M1 */
+ 	MR_TOPGRF(RK_GPIO1, RK_PB0, RK_FUNC_4, 0x0314, RK_GENMASK_VAL(3, 2, 2)), /* PCIE20 IO mux selection M2 */
+@@ -237,6 +238,15 @@ static int rk3568_set_pull(struct rockchip_pin_bank *bank,
+ 		return ret;
+ 	}
+ 
++	/*
++	 * In the TRM, pull-up being 1 for everything except the GPIO0_D3-D6,
++	 * where that pull up value becomes 3.
++	 */
++	if (bank->bank_num == 0 && pin_num >= 27 && pin_num <= 30) {
++		if (ret == 1)
++			ret = 3;
++	}
++
+ 	/* enable the write to the equivalent lower bits */
+ 	data = ((1 << ROCKCHIP_PULL_BITS_PER_PIN) - 1) << (bit + 16);
+ 
diff --git a/package/boot/uboot-rockchip/patches/203-rock64pro-disable-CONFIG_USE_PREBOOT.patch b/package/boot/uboot-rockchip/patches/203-rock64pro-disable-CONFIG_USE_PREBOOT.patch
index f630818358d2..37e50d175c00 100644
--- a/package/boot/uboot-rockchip/patches/203-rock64pro-disable-CONFIG_USE_PREBOOT.patch
+++ b/package/boot/uboot-rockchip/patches/203-rock64pro-disable-CONFIG_USE_PREBOOT.patch
@@ -17,10 +17,10 @@ Signed-off-by: Marty Jones <mj8263788@gmail.com>
 
 --- a/configs/rockpro64-rk3399_defconfig
 +++ b/configs/rockpro64-rk3399_defconfig
-@@ -12,7 +12,6 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
- CONFIG_SPL_SPI_SUPPORT=y
- CONFIG_DEFAULT_DEVICE_TREE="rk3399-rockpro64"
+@@ -21,7 +21,6 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
  CONFIG_DEBUG_UART=y
+ CONFIG_BOOTSTAGE=y
+ CONFIG_BOOTSTAGE_REPORT=y
 -CONFIG_USE_PREBOOT=y
  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rockpro64.dtb"
  CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/package/boot/uboot-rockchip/patches/301-arm64-dts-rockchip-Add-GuangMiao-G4C-support.patch b/package/boot/uboot-rockchip/patches/301-arm64-dts-rockchip-Add-GuangMiao-G4C-support.patch
index fae269b7149f..57d5b0f8d9be 100644
--- a/package/boot/uboot-rockchip/patches/301-arm64-dts-rockchip-Add-GuangMiao-G4C-support.patch
+++ b/package/boot/uboot-rockchip/patches/301-arm64-dts-rockchip-Add-GuangMiao-G4C-support.patch
@@ -13,7 +13,7 @@
 @@ -0,0 +1,57 @@
 +CONFIG_ARM=y
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00200000
++CONFIG_TEXT_BASE=0x00200000
 +CONFIG_ENV_OFFSET=0x3F8000
 +CONFIG_ROCKCHIP_RK3399=y
 +CONFIG_TARGET_EVB_RK3399=y
diff --git a/package/boot/uboot-rockchip/patches/302-rockchip-rk3328-Add-support-for-Orangepi-R1-Plus.patch b/package/boot/uboot-rockchip/patches/302-rockchip-rk3328-Add-support-for-Orangepi-R1-Plus.patch
index 18b0734277d3..60c2ec7a8d1f 100644
--- a/package/boot/uboot-rockchip/patches/302-rockchip-rk3328-Add-support-for-Orangepi-R1-Plus.patch
+++ b/package/boot/uboot-rockchip/patches/302-rockchip-rk3328-Add-support-for-Orangepi-R1-Plus.patch
@@ -42,27 +42,31 @@
 +};
 --- /dev/null
 +++ b/configs/orangepi-r1-plus-rk3328_defconfig
-@@ -0,0 +1,104 @@
+@@ -0,0 +1,112 @@
 +CONFIG_ARM=y
 +CONFIG_SKIP_LOWLEVEL_INIT=y
 +CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00200000
++CONFIG_TEXT_BASE=0x00200000
 +CONFIG_SPL_GPIO=y
 +CONFIG_NR_DRAM_BANKS=1
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 +CONFIG_ENV_OFFSET=0x3F8000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus"
++CONFIG_DM_RESET=y
 +CONFIG_ROCKCHIP_RK3328=y
 +CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 +CONFIG_TPL_LIBCOMMON_SUPPORT=y
 +CONFIG_TPL_LIBGENERIC_SUPPORT=y
 +CONFIG_SPL_DRIVERS_MISC=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
++CONFIG_SPL_STACK=0x400000
++CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 +CONFIG_DEBUG_UART_BASE=0xFF130000
 +CONFIG_DEBUG_UART_CLOCK=24000000
 +CONFIG_SYS_LOAD_ADDR=0x800800
 +CONFIG_DEBUG_UART=y
-+CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 +# CONFIG_ANDROID_BOOT_IMAGE is not set
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
@@ -71,13 +75,19 @@
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
 +CONFIG_MISC_INIT_R=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x2000000
++CONFIG_SPL_BSS_MAX_SIZE=0x2000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-+CONFIG_TPL_SYS_MALLOC_SIMPLE=y
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
 +CONFIG_SPL_I2C=y
 +CONFIG_SPL_POWER=y
 +CONFIG_SPL_ATF=y
 +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
++CONFIG_TPL_SYS_MALLOC_SIMPLE=y
 +CONFIG_CMD_BOOTZ=y
 +CONFIG_CMD_GPT=y
 +CONFIG_CMD_MMC=y
@@ -108,7 +118,6 @@
 +CONFIG_MMC_DW=y
 +CONFIG_MMC_DW_ROCKCHIP=y
 +CONFIG_SF_DEFAULT_SPEED=20000000
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
 +CONFIG_PINCTRL=y
@@ -125,9 +134,9 @@
 +CONFIG_RAM=y
 +CONFIG_SPL_RAM=y
 +CONFIG_TPL_RAM=y
-+CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSINFO=y
 +CONFIG_SYSRESET=y
 +# CONFIG_TPL_SYSRESET is not set
@@ -138,7 +147,6 @@
 +CONFIG_USB_EHCI_GENERIC=y
 +CONFIG_USB_OHCI_HCD=y
 +CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=1
 +CONFIG_USB_DWC2=y
 +CONFIG_USB_DWC3=y
 +# CONFIG_USB_DWC3_GADGET is not set
diff --git a/package/boot/uboot-rockchip/patches/303-rockchip-rk3328-Add-support-for-Orangepi-R1-Plus-LTS.patch b/package/boot/uboot-rockchip/patches/303-rockchip-rk3328-Add-support-for-Orangepi-R1-Plus-LTS.patch
index 953d531bdef6..5cbbffa07b96 100644
--- a/package/boot/uboot-rockchip/patches/303-rockchip-rk3328-Add-support-for-Orangepi-R1-Plus-LTS.patch
+++ b/package/boot/uboot-rockchip/patches/303-rockchip-rk3328-Add-support-for-Orangepi-R1-Plus-LTS.patch
@@ -37,27 +37,31 @@ Subject: [PATCH] Add support for Orangepi R1 Plus LTS
 +};
 --- /dev/null
 +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
-@@ -0,0 +1,104 @@
+@@ -0,0 +1,112 @@
 +CONFIG_ARM=y
 +CONFIG_SKIP_LOWLEVEL_INIT=y
 +CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00200000
++CONFIG_TEXT_BASE=0x00200000
 +CONFIG_SPL_GPIO=y
 +CONFIG_NR_DRAM_BANKS=1
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 +CONFIG_ENV_OFFSET=0x3F8000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus-lts"
++CONFIG_DM_RESET=y
 +CONFIG_ROCKCHIP_RK3328=y
 +CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 +CONFIG_TPL_LIBCOMMON_SUPPORT=y
 +CONFIG_TPL_LIBGENERIC_SUPPORT=y
 +CONFIG_SPL_DRIVERS_MISC=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
++CONFIG_SPL_STACK=0x400000
++CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 +CONFIG_DEBUG_UART_BASE=0xFF130000
 +CONFIG_DEBUG_UART_CLOCK=24000000
 +CONFIG_SYS_LOAD_ADDR=0x800800
 +CONFIG_DEBUG_UART=y
-+CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 +# CONFIG_ANDROID_BOOT_IMAGE is not set
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
@@ -66,13 +70,19 @@ Subject: [PATCH] Add support for Orangepi R1 Plus LTS
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
 +CONFIG_MISC_INIT_R=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x2000000
++CONFIG_SPL_BSS_MAX_SIZE=0x2000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-+CONFIG_TPL_SYS_MALLOC_SIMPLE=y
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
 +CONFIG_SPL_I2C=y
 +CONFIG_SPL_POWER=y
 +CONFIG_SPL_ATF=y
 +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
++CONFIG_TPL_SYS_MALLOC_SIMPLE=y
 +CONFIG_CMD_BOOTZ=y
 +CONFIG_CMD_GPT=y
 +CONFIG_CMD_MMC=y
@@ -103,7 +113,6 @@ Subject: [PATCH] Add support for Orangepi R1 Plus LTS
 +CONFIG_MMC_DW=y
 +CONFIG_MMC_DW_ROCKCHIP=y
 +CONFIG_SF_DEFAULT_SPEED=20000000
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
 +CONFIG_PINCTRL=y
@@ -120,9 +129,9 @@ Subject: [PATCH] Add support for Orangepi R1 Plus LTS
 +CONFIG_RAM=y
 +CONFIG_SPL_RAM=y
 +CONFIG_TPL_RAM=y
-+CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSINFO=y
 +CONFIG_SYSRESET=y
 +# CONFIG_TPL_SYSRESET is not set
@@ -133,7 +142,6 @@ Subject: [PATCH] Add support for Orangepi R1 Plus LTS
 +CONFIG_USB_EHCI_GENERIC=y
 +CONFIG_USB_OHCI_HCD=y
 +CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=1
 +CONFIG_USB_DWC2=y
 +CONFIG_USB_DWC3=y
 +# CONFIG_USB_DWC3_GADGET is not set
@@ -142,5 +150,3 @@ Subject: [PATCH] Add support for Orangepi R1 Plus LTS
 +CONFIG_SPL_TINY_MEMSET=y
 +CONFIG_TPL_TINY_MEMSET=y
 +CONFIG_ERRNO_STR=y
--- 
-2.25.1
diff --git a/package/boot/uboot-rockchip/patches/304-rockchip-rk3328-Add-support-for-FriendlyARM-NanoPi-R.patch b/package/boot/uboot-rockchip/patches/304-rockchip-rk3328-Add-support-for-FriendlyARM-NanoPi-R.patch
index 39022fddfb15..02291e29bf29 100644
--- a/package/boot/uboot-rockchip/patches/304-rockchip-rk3328-Add-support-for-FriendlyARM-NanoPi-R.patch
+++ b/package/boot/uboot-rockchip/patches/304-rockchip-rk3328-Add-support-for-FriendlyARM-NanoPi-R.patch
@@ -81,25 +81,31 @@ new file mode 100644
 index 0000000000..7bc7a3274f
 --- /dev/null
 +++ b/configs/nanopi-r2c-rk3328_defconfig
-@@ -0,0 +1,100 @@
+@@ -0,0 +1,112 @@
 +CONFIG_ARM=y
++CONFIG_SKIP_LOWLEVEL_INIT=y
++CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00200000
-+CONFIG_SPL_GPIO_SUPPORT=y
++CONFIG_TEXT_BASE=0x00200000
++CONFIG_SPL_GPIO=y
 +CONFIG_NR_DRAM_BANKS=1
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 +CONFIG_ENV_OFFSET=0x3F8000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2c"
++CONFIG_DM_RESET=y
 +CONFIG_ROCKCHIP_RK3328=y
 +CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 +CONFIG_TPL_LIBCOMMON_SUPPORT=y
 +CONFIG_TPL_LIBGENERIC_SUPPORT=y
-+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
++CONFIG_SPL_DRIVERS_MISC=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
++CONFIG_SPL_STACK=0x400000
++CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 +CONFIG_DEBUG_UART_BASE=0xFF130000
 +CONFIG_DEBUG_UART_CLOCK=24000000
 +CONFIG_SYS_LOAD_ADDR=0x800800
 +CONFIG_DEBUG_UART=y
-+CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
 +# CONFIG_ANDROID_BOOT_IMAGE is not set
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
@@ -108,13 +114,19 @@ index 0000000000..7bc7a3274f
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
 +CONFIG_MISC_INIT_R=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x2000000
++CONFIG_SPL_BSS_MAX_SIZE=0x2000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-+CONFIG_TPL_SYS_MALLOC_SIMPLE=y
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_I2C_SUPPORT=y
-+CONFIG_SPL_POWER_SUPPORT=y
++CONFIG_SPL_I2C=y
++CONFIG_SPL_POWER=y
 +CONFIG_SPL_ATF=y
 +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
++CONFIG_TPL_SYS_MALLOC_SIMPLE=y
 +CONFIG_CMD_BOOTZ=y
 +CONFIG_CMD_GPT=y
 +CONFIG_CMD_MMC=y
@@ -127,6 +139,7 @@ index 0000000000..7bc7a3274f
 +CONFIG_TPL_OF_PLATDATA=y
 +CONFIG_ENV_IS_IN_MMC=y
 +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
++CONFIG_SYS_MMC_ENV_DEV=1
 +CONFIG_NET_RANDOM_ETHADDR=y
 +CONFIG_TPL_DM=y
 +CONFIG_REGMAP=y
@@ -144,13 +157,13 @@ index 0000000000..7bc7a3274f
 +CONFIG_MMC_DW=y
 +CONFIG_MMC_DW_ROCKCHIP=y
 +CONFIG_SF_DEFAULT_SPEED=20000000
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
 +CONFIG_PINCTRL=y
 +CONFIG_SPL_PINCTRL=y
 +CONFIG_DM_PMIC=y
 +CONFIG_PMIC_RK8XX=y
++CONFIG_SPL_PMIC_RK8XX=y
 +CONFIG_SPL_DM_REGULATOR=y
 +CONFIG_REGULATOR_PWM=y
 +CONFIG_DM_REGULATOR_FIXED=y
@@ -160,9 +173,9 @@ index 0000000000..7bc7a3274f
 +CONFIG_RAM=y
 +CONFIG_SPL_RAM=y
 +CONFIG_TPL_RAM=y
-+CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSINFO=y
 +CONFIG_SYSRESET=y
 +# CONFIG_TPL_SYSRESET is not set
@@ -173,7 +186,6 @@ index 0000000000..7bc7a3274f
 +CONFIG_USB_EHCI_GENERIC=y
 +CONFIG_USB_OHCI_HCD=y
 +CONFIG_USB_OHCI_GENERIC=y
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=1
 +CONFIG_USB_DWC2=y
 +CONFIG_USB_DWC3=y
 +# CONFIG_USB_DWC3_GADGET is not set
diff --git a/package/boot/uboot-rockchip/patches/305-rockchip-rk3399-Add-support-for-FriendlyARM-NanoPi-R.patch b/package/boot/uboot-rockchip/patches/305-rockchip-rk3399-Add-support-for-FriendlyARM-NanoPi-R.patch
index ca6f80958ff2..d9dc149af00f 100644
--- a/package/boot/uboot-rockchip/patches/305-rockchip-rk3399-Add-support-for-FriendlyARM-NanoPi-R.patch
+++ b/package/boot/uboot-rockchip/patches/305-rockchip-rk3399-Add-support-for-FriendlyARM-NanoPi-R.patch
@@ -50,7 +50,7 @@
 +CONFIG_SKIP_LOWLEVEL_INIT=y
 +CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00200000
++CONFIG_TEXT_BASE=0x00200000
 +CONFIG_NR_DRAM_BANKS=1
 +CONFIG_ENV_OFFSET=0x3F8000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-r4se"
diff --git a/package/boot/uboot-rockchip/patches/306-rockchip-rk3399-Add-support-for-Rongpin-king3399.patch b/package/boot/uboot-rockchip/patches/306-rockchip-rk3399-Add-support-for-Rongpin-king3399.patch
index 837f586491ac..9e6bd4e17e54 100755
--- a/package/boot/uboot-rockchip/patches/306-rockchip-rk3399-Add-support-for-Rongpin-king3399.patch
+++ b/package/boot/uboot-rockchip/patches/306-rockchip-rk3399-Add-support-for-Rongpin-king3399.patch
@@ -5,7 +5,7 @@
 +CONFIG_SKIP_LOWLEVEL_INIT=y
 +CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00200000
++CONFIG_TEXT_BASE=0x00200000
 +CONFIG_NR_DRAM_BANKS=1
 +CONFIG_ENV_OFFSET=0x3F8000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-r4se"
diff --git a/package/boot/uboot-rockchip/patches/307-rockchip-rk3399-Add-support-for-Rocktech-MPC1903.patch b/package/boot/uboot-rockchip/patches/307-rockchip-rk3399-Add-support-for-Rocktech-MPC1903.patch
index bdccbc01f151..040821367725 100644
--- a/package/boot/uboot-rockchip/patches/307-rockchip-rk3399-Add-support-for-Rocktech-MPC1903.patch
+++ b/package/boot/uboot-rockchip/patches/307-rockchip-rk3399-Add-support-for-Rocktech-MPC1903.patch
@@ -723,7 +723,7 @@
 +CONFIG_SKIP_LOWLEVEL_INIT=y
 +CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00200000
++CONFIG_TEXT_BASE=0x00200000
 +CONFIG_ENV_OFFSET=0x3F8000
 +CONFIG_ROCKCHIP_RK3399=y
 +CONFIG_TARGET_EVB_RK3399=y
diff --git a/package/boot/uboot-rockchip/patches/308-rockchip-rk3399-Add-support-for-sharevdi-h3399pc.patch b/package/boot/uboot-rockchip/patches/308-rockchip-rk3399-Add-support-for-sharevdi-h3399pc.patch
index b7db33ec0707..9d6cf894391f 100644
--- a/package/boot/uboot-rockchip/patches/308-rockchip-rk3399-Add-support-for-sharevdi-h3399pc.patch
+++ b/package/boot/uboot-rockchip/patches/308-rockchip-rk3399-Add-support-for-sharevdi-h3399pc.patch
@@ -863,7 +863,7 @@
 +CONFIG_SKIP_LOWLEVEL_INIT=y
 +CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00200000
++CONFIG_TEXT_BASE=0x00200000
 +CONFIG_ENV_OFFSET=0x3F8000
 +CONFIG_ROCKCHIP_RK3399=y
 +CONFIG_TARGET_EVB_RK3399=y
diff --git a/package/boot/uboot-rockchip/patches/311-rockchip-rk3568-Add-support-for-ezpro_mrkaio-m68s.patch b/package/boot/uboot-rockchip/patches/311-rockchip-rk3568-Add-support-for-ezpro_mrkaio-m68s.patch
index ff7ded5f8c85..7bba95d54f27 100644
--- a/package/boot/uboot-rockchip/patches/311-rockchip-rk3568-Add-support-for-ezpro_mrkaio-m68s.patch
+++ b/package/boot/uboot-rockchip/patches/311-rockchip-rk3568-Add-support-for-ezpro_mrkaio-m68s.patch
@@ -1,19 +1,19 @@
 --- a/arch/arm/dts/Makefile
 +++ b/arch/arm/dts/Makefile
 @@ -171,6 +171,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3399) += \
+ 
  dtb-$(CONFIG_ROCKCHIP_RK3568) += \
- 	rk3568-bpi-r2-pro.dtb \
  	rk3568-evb.dtb \
 +	rk3568-mrkaio-m68s.dtb \
  	rk3568-nanopi-r5s.dtb \
- 	rk3566-quartz64-a.dtb \
+ 	rk3566-radxa-cm3-io.dtb \
  	rk3568-rock-3a.dtb
 --- /dev/null
 +++ b/arch/arm/dts/rk3568-mrkaio-m68s-u-boot.dtsi
 @@ -0,0 +1,21 @@
 +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 +
-+#include "rk3568-u-boot.dtsi"
++#include "rk356x-u-boot.dtsi"
 +
 +/ {
 +	chosen {
@@ -305,103 +305,95 @@
 +};
 --- /dev/null
 +++ b/configs/mrkaio-m68s-rk3568_defconfig
-@@ -0,0 +1,99 @@
+@@ -0,0 +1,91 @@
 +CONFIG_ARM=y
 +CONFIG_SKIP_LOWLEVEL_INIT=y
++CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
++CONFIG_TEXT_BASE=0x00a00000
 +CONFIG_SPL_LIBCOMMON_SUPPORT=y
 +CONFIG_SPL_LIBGENERIC_SUPPORT=y
 +CONFIG_NR_DRAM_BANKS=2
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3568-mrkaio-m68s"
 +CONFIG_ROCKCHIP_RK3568=y
 +CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
++CONFIG_SPL_BOARD_INIT=y
 +CONFIG_SPL_MMC=y
 +CONFIG_SPL_SERIAL=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
 +CONFIG_TARGET_EVB_RK3568=y
++CONFIG_SPL_STACK=0x400000
 +CONFIG_DEBUG_UART_BASE=0xFE660000
 +CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
 +CONFIG_SYS_LOAD_ADDR=0xc00800
-+CONFIG_API=y
++CONFIG_DEBUG_UART=y
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
 +CONFIG_SPL_LOAD_FIT=y
-+CONFIG_OF_SYSTEM_SETUP=y
 +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-mrkaio-m68s.dtb"
-+# CONFIG_SYS_DEVICE_NULLDEV is not set
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=2
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x4000000
++CONFIG_SPL_BSS_MAX_SIZE=0x4000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
 +CONFIG_SPL_ADC=y
 +CONFIG_SPL_ATF=y
-+CONFIG_SPL_BOARD_INIT=y
 +CONFIG_CMD_ADC=y
-+CONFIG_CMD_BIND=y
-+CONFIG_CMD_CLK=y
 +CONFIG_CMD_GPIO=y
 +CONFIG_CMD_GPT=y
 +CONFIG_CMD_I2C=y
 +CONFIG_CMD_MMC=y
 +CONFIG_CMD_USB=y
-+# CONFIG_CMD_SETEXPR is not set
-+CONFIG_CMD_PMIC=y
 +CONFIG_CMD_REGULATOR=y
++# CONFIG_CMD_SETEXPR is not set
 +# CONFIG_SPL_DOS_PARTITION is not set
 +CONFIG_SPL_OF_CONTROL=y
 +CONFIG_OF_LIVE=y
 +CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_DM_WARN=y
 +CONFIG_SPL_REGMAP=y
 +CONFIG_SPL_SYSCON=y
 +CONFIG_SPL_CLK=y
++CONFIG_CLK_SCMI=y
++CONFIG_RESET_SCMI=y
 +CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_ROCKCHIP_GPIO_V2=y
 +CONFIG_SYS_I2C_ROCKCHIP=y
 +CONFIG_MISC=y
-+CONFIG_MMC_HS200_SUPPORT=y
-+CONFIG_SPL_MMC_HS200_SUPPORT=y
++CONFIG_SUPPORT_EMMC_RPMB=y
 +CONFIG_MMC_DW=y
 +CONFIG_MMC_DW_ROCKCHIP=y
 +CONFIG_MMC_SDHCI=y
 +CONFIG_MMC_SDHCI_SDMA=y
 +CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
-+CONFIG_POWER_DOMAIN=y
 +CONFIG_DM_PMIC=y
 +CONFIG_PMIC_RK8XX=y
 +CONFIG_SPL_PMIC_RK8XX=y
++CONFIG_PHY_ROCKCHIP_INNO_USB2=y
++CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 +CONFIG_REGULATOR_PWM=y
 +CONFIG_DM_REGULATOR_FIXED=y
 +CONFIG_SPL_DM_REGULATOR_FIXED=y
-+CONFIG_DM_REGULATOR_GPIO=y
 +CONFIG_REGULATOR_RK8XX=y
 +CONFIG_PWM_ROCKCHIP=y
 +CONFIG_SPL_RAM=y
-+CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSRESET=y
 +CONFIG_USB=y
 +CONFIG_USB_XHCI_HCD=y
 +CONFIG_USB_XHCI_DWC3=y
 +CONFIG_USB_EHCI_HCD=y
 +CONFIG_USB_EHCI_GENERIC=y
-+CONFIG_USB_OHCI_HCD=y
-+CONFIG_USB_OHCI_GENERIC=y
 +CONFIG_USB_DWC3=y
 +CONFIG_USB_DWC3_GENERIC=y
-+CONFIG_ROCKCHIP_USB2_PHY=y
-+CONFIG_USB_KEYBOARD=y
-+CONFIG_USB_HOST_ETHER=y
-+CONFIG_USB_ETHER_LAN75XX=y
-+CONFIG_USB_ETHER_LAN78XX=y
-+CONFIG_USB_ETHER_SMSC95XX=y
 +CONFIG_ERRNO_STR=y
diff --git a/package/boot/uboot-rockchip/patches/312-rockchip-rk3568-Add-support-for-hinlink-opc-h68k.patch b/package/boot/uboot-rockchip/patches/312-rockchip-rk3568-Add-support-for-hinlink-opc-h68k.patch
index 3d007271326d..04b06513e112 100644
--- a/package/boot/uboot-rockchip/patches/312-rockchip-rk3568-Add-support-for-hinlink-opc-h68k.patch
+++ b/package/boot/uboot-rockchip/patches/312-rockchip-rk3568-Add-support-for-hinlink-opc-h68k.patch
@@ -1,19 +1,19 @@
 --- a/arch/arm/dts/Makefile
 +++ b/arch/arm/dts/Makefile
 @@ -171,6 +171,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3399) += \
+ 
  dtb-$(CONFIG_ROCKCHIP_RK3568) += \
- 	rk3568-bpi-r2-pro.dtb \
  	rk3568-evb.dtb \
 +	rk3568-opc-h68k.dtb \
  	rk3568-mrkaio-m68s.dtb \
  	rk3568-nanopi-r5s.dtb \
- 	rk3566-quartz64-a.dtb \
+ 	rk3566-radxa-cm3-io.dtb \
 --- /dev/null
 +++ b/arch/arm/dts/rk3568-opc-h68k-u-boot.dtsi
 @@ -0,0 +1,21 @@
 +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 +
-+#include "rk3568-u-boot.dtsi"
++#include "rk356x-u-boot.dtsi"
 +
 +/ {
 +	chosen {
@@ -314,103 +314,95 @@
 +};
 --- /dev/null
 +++ b/configs/opc-h68k-rk3568_defconfig
-@@ -0,0 +1,99 @@
+@@ -0,0 +1,91 @@
 +CONFIG_ARM=y
 +CONFIG_SKIP_LOWLEVEL_INIT=y
++CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
++CONFIG_TEXT_BASE=0x00a00000
 +CONFIG_SPL_LIBCOMMON_SUPPORT=y
 +CONFIG_SPL_LIBGENERIC_SUPPORT=y
 +CONFIG_NR_DRAM_BANKS=2
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3568-opc-h68k"
 +CONFIG_ROCKCHIP_RK3568=y
 +CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
++CONFIG_SPL_BOARD_INIT=y
 +CONFIG_SPL_MMC=y
 +CONFIG_SPL_SERIAL=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
 +CONFIG_TARGET_EVB_RK3568=y
++CONFIG_SPL_STACK=0x400000
 +CONFIG_DEBUG_UART_BASE=0xFE660000
 +CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
 +CONFIG_SYS_LOAD_ADDR=0xc00800
-+CONFIG_API=y
++CONFIG_DEBUG_UART=y
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
 +CONFIG_SPL_LOAD_FIT=y
-+CONFIG_OF_SYSTEM_SETUP=y
 +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-opc-h68k.dtb"
-+# CONFIG_SYS_DEVICE_NULLDEV is not set
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=2
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x4000000
++CONFIG_SPL_BSS_MAX_SIZE=0x4000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
 +CONFIG_SPL_ADC=y
 +CONFIG_SPL_ATF=y
-+CONFIG_SPL_BOARD_INIT=y
 +CONFIG_CMD_ADC=y
-+CONFIG_CMD_BIND=y
-+CONFIG_CMD_CLK=y
 +CONFIG_CMD_GPIO=y
 +CONFIG_CMD_GPT=y
 +CONFIG_CMD_I2C=y
 +CONFIG_CMD_MMC=y
 +CONFIG_CMD_USB=y
-+# CONFIG_CMD_SETEXPR is not set
-+CONFIG_CMD_PMIC=y
 +CONFIG_CMD_REGULATOR=y
++# CONFIG_CMD_SETEXPR is not set
 +# CONFIG_SPL_DOS_PARTITION is not set
 +CONFIG_SPL_OF_CONTROL=y
 +CONFIG_OF_LIVE=y
 +CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_DM_WARN=y
 +CONFIG_SPL_REGMAP=y
 +CONFIG_SPL_SYSCON=y
 +CONFIG_SPL_CLK=y
++CONFIG_CLK_SCMI=y
++CONFIG_RESET_SCMI=y
 +CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_ROCKCHIP_GPIO_V2=y
 +CONFIG_SYS_I2C_ROCKCHIP=y
 +CONFIG_MISC=y
-+CONFIG_MMC_HS200_SUPPORT=y
-+CONFIG_SPL_MMC_HS200_SUPPORT=y
++CONFIG_SUPPORT_EMMC_RPMB=y
 +CONFIG_MMC_DW=y
 +CONFIG_MMC_DW_ROCKCHIP=y
 +CONFIG_MMC_SDHCI=y
 +CONFIG_MMC_SDHCI_SDMA=y
 +CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
-+CONFIG_POWER_DOMAIN=y
 +CONFIG_DM_PMIC=y
 +CONFIG_PMIC_RK8XX=y
 +CONFIG_SPL_PMIC_RK8XX=y
++CONFIG_PHY_ROCKCHIP_INNO_USB2=y
++CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 +CONFIG_REGULATOR_PWM=y
 +CONFIG_DM_REGULATOR_FIXED=y
 +CONFIG_SPL_DM_REGULATOR_FIXED=y
-+CONFIG_DM_REGULATOR_GPIO=y
 +CONFIG_REGULATOR_RK8XX=y
 +CONFIG_PWM_ROCKCHIP=y
 +CONFIG_SPL_RAM=y
-+CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSRESET=y
 +CONFIG_USB=y
 +CONFIG_USB_XHCI_HCD=y
 +CONFIG_USB_XHCI_DWC3=y
 +CONFIG_USB_EHCI_HCD=y
 +CONFIG_USB_EHCI_GENERIC=y
-+CONFIG_USB_OHCI_HCD=y
-+CONFIG_USB_OHCI_GENERIC=y
 +CONFIG_USB_DWC3=y
 +CONFIG_USB_DWC3_GENERIC=y
-+CONFIG_ROCKCHIP_USB2_PHY=y
-+CONFIG_USB_KEYBOARD=y
-+CONFIG_USB_HOST_ETHER=y
-+CONFIG_USB_ETHER_LAN75XX=y
-+CONFIG_USB_ETHER_LAN78XX=y
-+CONFIG_USB_ETHER_SMSC95XX=y
 +CONFIG_ERRNO_STR=y
diff --git a/package/boot/uboot-rockchip/patches/313-rockchip-rk3568-Add-support-for-fastrhino-r66s.patch b/package/boot/uboot-rockchip/patches/313-rockchip-rk3568-Add-support-for-fastrhino-r66s.patch
index c4b9e19b81e5..de01269e5e3e 100644
--- a/package/boot/uboot-rockchip/patches/313-rockchip-rk3568-Add-support-for-fastrhino-r66s.patch
+++ b/package/boot/uboot-rockchip/patches/313-rockchip-rk3568-Add-support-for-fastrhino-r66s.patch
@@ -1,8 +1,8 @@
 --- a/arch/arm/dts/Makefile
 +++ b/arch/arm/dts/Makefile
 @@ -171,6 +171,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3399) += \
+ 
  dtb-$(CONFIG_ROCKCHIP_RK3568) += \
- 	rk3568-bpi-r2-pro.dtb \
  	rk3568-evb.dtb \
 +	rk3568-r66s.dtb \
  	rk3568-opc-h68k.dtb \
@@ -13,7 +13,7 @@
 @@ -0,0 +1,21 @@
 +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 +
-+#include "rk3568-u-boot.dtsi"
++#include "rk356x-u-boot.dtsi"
 +
 +/ {
 +	chosen {
@@ -39,103 +39,95 @@
 +#include "rk3568-evb.dts"
 --- /dev/null
 +++ b/configs/r66s-rk3568_defconfig
-@@ -0,0 +1,99 @@
+@@ -0,0 +1,91 @@
 +CONFIG_ARM=y
 +CONFIG_SKIP_LOWLEVEL_INIT=y
++CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
++CONFIG_TEXT_BASE=0x00a00000
 +CONFIG_SPL_LIBCOMMON_SUPPORT=y
 +CONFIG_SPL_LIBGENERIC_SUPPORT=y
 +CONFIG_NR_DRAM_BANKS=2
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3568-r66s"
 +CONFIG_ROCKCHIP_RK3568=y
 +CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
++CONFIG_SPL_BOARD_INIT=y
 +CONFIG_SPL_MMC=y
 +CONFIG_SPL_SERIAL=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
 +CONFIG_TARGET_EVB_RK3568=y
++CONFIG_SPL_STACK=0x400000
 +CONFIG_DEBUG_UART_BASE=0xFE660000
 +CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
 +CONFIG_SYS_LOAD_ADDR=0xc00800
-+CONFIG_API=y
++CONFIG_DEBUG_UART=y
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
 +CONFIG_SPL_LOAD_FIT=y
-+CONFIG_OF_SYSTEM_SETUP=y
 +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-r66s.dtb"
-+# CONFIG_SYS_DEVICE_NULLDEV is not set
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=2
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x4000000
++CONFIG_SPL_BSS_MAX_SIZE=0x4000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
 +CONFIG_SPL_ADC=y
 +CONFIG_SPL_ATF=y
-+CONFIG_SPL_BOARD_INIT=y
 +CONFIG_CMD_ADC=y
-+CONFIG_CMD_BIND=y
-+CONFIG_CMD_CLK=y
 +CONFIG_CMD_GPIO=y
 +CONFIG_CMD_GPT=y
 +CONFIG_CMD_I2C=y
 +CONFIG_CMD_MMC=y
 +CONFIG_CMD_USB=y
-+# CONFIG_CMD_SETEXPR is not set
-+CONFIG_CMD_PMIC=y
 +CONFIG_CMD_REGULATOR=y
++# CONFIG_CMD_SETEXPR is not set
 +# CONFIG_SPL_DOS_PARTITION is not set
 +CONFIG_SPL_OF_CONTROL=y
 +CONFIG_OF_LIVE=y
 +CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_DM_WARN=y
 +CONFIG_SPL_REGMAP=y
 +CONFIG_SPL_SYSCON=y
 +CONFIG_SPL_CLK=y
++CONFIG_CLK_SCMI=y
++CONFIG_RESET_SCMI=y
 +CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_ROCKCHIP_GPIO_V2=y
 +CONFIG_SYS_I2C_ROCKCHIP=y
 +CONFIG_MISC=y
-+CONFIG_MMC_HS200_SUPPORT=y
-+CONFIG_SPL_MMC_HS200_SUPPORT=y
++CONFIG_SUPPORT_EMMC_RPMB=y
 +CONFIG_MMC_DW=y
 +CONFIG_MMC_DW_ROCKCHIP=y
 +CONFIG_MMC_SDHCI=y
 +CONFIG_MMC_SDHCI_SDMA=y
 +CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
-+CONFIG_POWER_DOMAIN=y
 +CONFIG_DM_PMIC=y
 +CONFIG_PMIC_RK8XX=y
 +CONFIG_SPL_PMIC_RK8XX=y
++CONFIG_PHY_ROCKCHIP_INNO_USB2=y
++CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 +CONFIG_REGULATOR_PWM=y
 +CONFIG_DM_REGULATOR_FIXED=y
 +CONFIG_SPL_DM_REGULATOR_FIXED=y
-+CONFIG_DM_REGULATOR_GPIO=y
 +CONFIG_REGULATOR_RK8XX=y
 +CONFIG_PWM_ROCKCHIP=y
 +CONFIG_SPL_RAM=y
-+CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSRESET=y
 +CONFIG_USB=y
 +CONFIG_USB_XHCI_HCD=y
 +CONFIG_USB_XHCI_DWC3=y
 +CONFIG_USB_EHCI_HCD=y
 +CONFIG_USB_EHCI_GENERIC=y
-+CONFIG_USB_OHCI_HCD=y
-+CONFIG_USB_OHCI_GENERIC=y
 +CONFIG_USB_DWC3=y
 +CONFIG_USB_DWC3_GENERIC=y
-+CONFIG_ROCKCHIP_USB2_PHY=y
-+CONFIG_USB_KEYBOARD=y
-+CONFIG_USB_HOST_ETHER=y
-+CONFIG_USB_ETHER_LAN75XX=y
-+CONFIG_USB_ETHER_LAN78XX=y
-+CONFIG_USB_ETHER_SMSC95XX=y
 +CONFIG_ERRNO_STR=y
diff --git a/package/boot/uboot-rockchip/patches/314-rockchip-rk3568-Add-support-for-Station-P2.patch b/package/boot/uboot-rockchip/patches/314-rockchip-rk3568-Add-support-for-Station-P2.patch
index 3df47445fb79..26531f3799d2 100644
--- a/package/boot/uboot-rockchip/patches/314-rockchip-rk3568-Add-support-for-Station-P2.patch
+++ b/package/boot/uboot-rockchip/patches/314-rockchip-rk3568-Add-support-for-Station-P2.patch
@@ -8,19 +8,19 @@ Subject: [PATCH] rockchip: rk3568: Add support for Station P2
  1 file changed, 59 insertions(+)
  create mode 100644 configs/station-p2-rk3568_defconfig
 
-diff --git a/configs/station-p2-rk3568_defconfig b/configs/station-p2-rk3568_defconfig
-new file mode 100644
-index 0000000000..435be99edf
 --- /dev/null
 +++ b/configs/station-p2-rk3568_defconfig
-@@ -0,0 +1,59 @@
+@@ -0,0 +1,87 @@
 +CONFIG_ARM=y
 +CONFIG_SKIP_LOWLEVEL_INIT=y
++CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
++CONFIG_TEXT_BASE=0x00a00000
 +CONFIG_SPL_LIBCOMMON_SUPPORT=y
 +CONFIG_SPL_LIBGENERIC_SUPPORT=y
 +CONFIG_NR_DRAM_BANKS=2
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3568-evb"
 +CONFIG_ROCKCHIP_RK3568=y
 +CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -29,22 +29,32 @@ index 0000000000..435be99edf
 +CONFIG_SPL_SERIAL=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
 +CONFIG_TARGET_EVB_RK3568=y
++CONFIG_SPL_STACK=0x400000
 +CONFIG_DEBUG_UART_BASE=0xFE660000
 +CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
 +CONFIG_SYS_LOAD_ADDR=0xc00800
++CONFIG_DEBUG_UART=y
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
 +CONFIG_SPL_LOAD_FIT=y
 +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-evb.dtb"
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x4000000
++CONFIG_SPL_BSS_MAX_SIZE=0x4000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
 +CONFIG_SPL_ATF=y
++CONFIG_CMD_GPIO=y
 +CONFIG_CMD_GPT=y
++CONFIG_CMD_I2C=y
 +CONFIG_CMD_MMC=y
++CONFIG_CMD_USB=y
++CONFIG_CMD_REGULATOR=y
 +# CONFIG_CMD_SETEXPR is not set
 +# CONFIG_SPL_DOS_PARTITION is not set
 +CONFIG_SPL_OF_CONTROL=y
@@ -53,6 +63,8 @@ index 0000000000..435be99edf
 +CONFIG_SPL_REGMAP=y
 +CONFIG_SPL_SYSCON=y
 +CONFIG_SPL_CLK=y
++CONFIG_CLK_SCMI=y
++CONFIG_RESET_SCMI=y
 +CONFIG_ROCKCHIP_GPIO=y
 +CONFIG_SYS_I2C_ROCKCHIP=y
 +CONFIG_MISC=y
@@ -62,16 +74,27 @@ index 0000000000..435be99edf
 +CONFIG_MMC_SDHCI=y
 +CONFIG_MMC_SDHCI_SDMA=y
 +CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
++CONFIG_DM_PMIC=y
++CONFIG_PMIC_RK8XX=y
++CONFIG_SPL_PMIC_RK8XX=y
++CONFIG_PHY_ROCKCHIP_INNO_USB2=y
++CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 +CONFIG_REGULATOR_PWM=y
++CONFIG_REGULATOR_RK8XX=y
 +CONFIG_PWM_ROCKCHIP=y
 +CONFIG_SPL_RAM=y
 +CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSRESET=y
++CONFIG_USB=y
++CONFIG_USB_XHCI_HCD=y
++CONFIG_USB_XHCI_DWC3=y
++CONFIG_USB_EHCI_HCD=y
++CONFIG_USB_EHCI_GENERIC=y
++CONFIG_USB_DWC3=y
++CONFIG_USB_DWC3_GENERIC=y
 +CONFIG_ERRNO_STR=y
--- 
-2.20.1
diff --git a/package/boot/uboot-rockchip/patches/314-rockchip-rk3568-Add-support-for-photonicat.patch b/package/boot/uboot-rockchip/patches/314-rockchip-rk3568-Add-support-for-photonicat.patch
index 216186289282..35dd32e67b71 100644
--- a/package/boot/uboot-rockchip/patches/314-rockchip-rk3568-Add-support-for-photonicat.patch
+++ b/package/boot/uboot-rockchip/patches/314-rockchip-rk3568-Add-support-for-photonicat.patch
@@ -5,15 +5,15 @@
  	rk3568-mrkaio-m68s.dtb \
  	rk3568-nanopi-r5s.dtb \
 +	rk3568-photonicat.dtb \
- 	rk3566-quartz64-a.dtb \
- 	rk3568-rock-3a.dtb \
- 	rk3568-rock-pi-e25.dtb
+ 	rk3566-radxa-cm3-io.dtb \
+ 	rk3568-rock-3a.dtb
+ 
 --- /dev/null
 +++ b/arch/arm/dts/rk3568-photonicat-u-boot.dtsi
 @@ -0,0 +1,33 @@
 +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 +
-+#include "rk3568-u-boot.dtsi"
++#include "rk356x-u-boot.dtsi"
 +
 +/ {
 +	chosen {
@@ -103,14 +103,17 @@
 +};
 --- /dev/null
 +++ b/configs/photonicat-rk3568_defconfig
-@@ -0,0 +1,101 @@
+@@ -0,0 +1,94 @@
 +CONFIG_ARM=y
 +CONFIG_SKIP_LOWLEVEL_INIT=y
++CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
++CONFIG_TEXT_BASE=0x00a00000
 +CONFIG_SPL_LIBCOMMON_SUPPORT=y
 +CONFIG_SPL_LIBGENERIC_SUPPORT=y
 +CONFIG_NR_DRAM_BANKS=2
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3568-photonicat"
 +CONFIG_ROCKCHIP_RK3568=y
 +CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -120,89 +123,78 @@
 +CONFIG_SPL_SERIAL=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
 +CONFIG_TARGET_EVB_RK3568=y
++CONFIG_SPL_STACK=0x400000
 +CONFIG_DEBUG_UART_BASE=0xFE660000
 +CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
 +CONFIG_SYS_LOAD_ADDR=0xc00800
-+CONFIG_API=y
++CONFIG_DEBUG_UART=y
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
 +CONFIG_SPL_LOAD_FIT=y
-+CONFIG_OF_SYSTEM_SETUP=y
 +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-photonicat.dtb"
-+# CONFIG_SYS_DEVICE_NULLDEV is not set
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=2
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x4000000
++CONFIG_SPL_BSS_MAX_SIZE=0x4000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
 +CONFIG_SPL_ADC=y
 +CONFIG_SPL_ATF=y
 +CONFIG_SPL_BOARD_INIT=y
 +CONFIG_CMD_ADC=y
-+CONFIG_CMD_BIND=y
-+CONFIG_CMD_CLK=y
 +CONFIG_CMD_GPIO=y
 +CONFIG_CMD_GPT=y
 +CONFIG_CMD_I2C=y
 +CONFIG_CMD_MMC=y
 +CONFIG_CMD_USB=y
-+# CONFIG_CMD_SETEXPR is not set
-+CONFIG_CMD_PMIC=y
 +CONFIG_CMD_REGULATOR=y
++# CONFIG_CMD_SETEXPR is not set
 +# CONFIG_SPL_DOS_PARTITION is not set
 +CONFIG_SPL_OF_CONTROL=y
 +CONFIG_OF_LIVE=y
 +CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_DM_WARN=y
 +CONFIG_SPL_REGMAP=y
 +CONFIG_SPL_SYSCON=y
 +CONFIG_SPL_CLK=y
++CONFIG_CLK_SCMI=y
++CONFIG_RESET_SCMI=y
 +CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_ROCKCHIP_GPIO_V2=y
 +CONFIG_SYS_I2C_ROCKCHIP=y
 +CONFIG_MISC=y
 +CONFIG_MMC_IO_VOLTAGE=y
 +CONFIG_SPL_MMC_IO_VOLTAGE=y
-+CONFIG_MMC_HS200_SUPPORT=y
-+CONFIG_SPL_MMC_HS200_SUPPORT=y
++CONFIG_SUPPORT_EMMC_RPMB=y
 +CONFIG_MMC_DW=y
 +CONFIG_MMC_DW_ROCKCHIP=y
 +CONFIG_MMC_SDHCI=y
 +CONFIG_MMC_SDHCI_SDMA=y
 +CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
-+CONFIG_POWER_DOMAIN=y
 +CONFIG_DM_PMIC=y
 +CONFIG_PMIC_RK8XX=y
 +CONFIG_SPL_PMIC_RK8XX=y
++CONFIG_PHY_ROCKCHIP_INNO_USB2=y
++CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 +CONFIG_REGULATOR_PWM=y
 +CONFIG_DM_REGULATOR_FIXED=y
 +CONFIG_SPL_DM_REGULATOR_FIXED=y
-+CONFIG_DM_REGULATOR_GPIO=y
 +CONFIG_REGULATOR_RK8XX=y
 +CONFIG_PWM_ROCKCHIP=y
 +CONFIG_SPL_RAM=y
-+CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSRESET=y
 +CONFIG_USB=y
 +CONFIG_USB_XHCI_HCD=y
 +CONFIG_USB_XHCI_DWC3=y
 +CONFIG_USB_EHCI_HCD=y
 +CONFIG_USB_EHCI_GENERIC=y
-+CONFIG_USB_OHCI_HCD=y
-+CONFIG_USB_OHCI_GENERIC=y
 +CONFIG_USB_DWC3=y
 +CONFIG_USB_DWC3_GENERIC=y
-+CONFIG_ROCKCHIP_USB2_PHY=y
-+CONFIG_USB_KEYBOARD=y
-+CONFIG_USB_HOST_ETHER=y
-+CONFIG_USB_ETHER_LAN75XX=y
-+CONFIG_USB_ETHER_LAN78XX=y
-+CONFIG_USB_ETHER_SMSC95XX=y
 +CONFIG_ERRNO_STR=y
diff --git a/package/boot/uboot-rockchip/patches/315-rockchip-rk3568-Add-support-for-radxa_e25.patch b/package/boot/uboot-rockchip/patches/315-rockchip-rk3568-Add-support-for-radxa_e25.patch
index 97db4c6722dd..f07e184af652 100644
--- a/package/boot/uboot-rockchip/patches/315-rockchip-rk3568-Add-support-for-radxa_e25.patch
+++ b/package/boot/uboot-rockchip/patches/315-rockchip-rk3568-Add-support-for-radxa_e25.patch
@@ -1,21 +1,21 @@
 --- a/arch/arm/dts/Makefile
 +++ b/arch/arm/dts/Makefile
 @@ -177,7 +177,8 @@ rk3568-evb.dtb \
- 	rk3568-mrkaio-m68s.dtb \
  	rk3568-nanopi-r5s.dtb \
- 	rk3566-quartz64-a.dtb \
+ 	rk3568-photonicat.dtb \
+ 	rk3566-radxa-cm3-io.dtb \
 -	rk3568-rock-3a.dtb
 +	rk3568-rock-3a.dtb \
 +	rk3568-radxa-e25.dtb
  
- dtb-$(CONFIG_ROCKCHIP_RV1108) += \
- 	rv1108-elgin-r1.dtb \
+ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
+ 	rk3588-edgeble-neu6a-io.dtb \
 --- /dev/null
 +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
 @@ -0,0 +1,21 @@
 +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 +
-+#include "rk3568-u-boot.dtsi"
++#include "rk356x-u-boot.dtsi"
 +
 +/ {
 +	chosen {
@@ -47,103 +47,93 @@
 +};
 --- /dev/null
 +++ b/configs/radxa-e25-rk3568_defconfig
-@@ -0,0 +1,99 @@
+@@ -0,0 +1,89 @@
 +CONFIG_ARM=y
 +CONFIG_SKIP_LOWLEVEL_INIT=y
++CONFIG_COUNTER_FREQUENCY=24000000
 +CONFIG_ARCH_ROCKCHIP=y
-+CONFIG_SYS_TEXT_BASE=0x00a00000
++CONFIG_TEXT_BASE=0x00a00000
 +CONFIG_SPL_LIBCOMMON_SUPPORT=y
 +CONFIG_SPL_LIBGENERIC_SUPPORT=y
 +CONFIG_NR_DRAM_BANKS=2
++CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
++CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 +CONFIG_DEFAULT_DEVICE_TREE="rk3568-radxa-e25"
 +CONFIG_ROCKCHIP_RK3568=y
 +CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
++CONFIG_SPL_BOARD_INIT=y
 +CONFIG_SPL_MMC=y
 +CONFIG_SPL_SERIAL=y
 +CONFIG_SPL_STACK_R_ADDR=0x600000
 +CONFIG_TARGET_EVB_RK3568=y
++CONFIG_SPL_STACK=0x400000
 +CONFIG_DEBUG_UART_BASE=0xFE660000
 +CONFIG_DEBUG_UART_CLOCK=24000000
-+CONFIG_DEBUG_UART=y
 +CONFIG_SYS_LOAD_ADDR=0xc00800
-+CONFIG_API=y
++CONFIG_DEBUG_UART=y
 +CONFIG_FIT=y
 +CONFIG_FIT_VERBOSE=y
 +CONFIG_SPL_LOAD_FIT=y
-+CONFIG_OF_SYSTEM_SETUP=y
 +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-radxa-e25.dtb"
-+# CONFIG_SYS_DEVICE_NULLDEV is not set
-+CONFIG_SYS_USB_OHCI_MAX_ROOT_PORTS=1
 +# CONFIG_DISPLAY_CPUINFO is not set
 +CONFIG_DISPLAY_BOARDINFO_LATE=y
++CONFIG_SPL_MAX_SIZE=0x40000
++CONFIG_SPL_PAD_TO=0x7f8000
++CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
++CONFIG_SPL_BSS_START_ADDR=0x4000000
++CONFIG_SPL_BSS_MAX_SIZE=0x4000
 +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
++# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 +CONFIG_SPL_STACK_R=y
-+CONFIG_SPL_SEPARATE_BSS=y
 +CONFIG_SPL_ADC=y
 +CONFIG_SPL_ATF=y
-+CONFIG_SPL_BOARD_INIT=y
 +CONFIG_CMD_ADC=y
-+CONFIG_CMD_BIND=y
-+CONFIG_CMD_CLK=y
 +CONFIG_CMD_GPIO=y
 +CONFIG_CMD_GPT=y
 +CONFIG_CMD_I2C=y
 +CONFIG_CMD_MMC=y
 +CONFIG_CMD_USB=y
-+# CONFIG_CMD_SETEXPR is not set
-+CONFIG_CMD_PMIC=y
 +CONFIG_CMD_REGULATOR=y
++# CONFIG_CMD_SETEXPR is not set
 +# CONFIG_SPL_DOS_PARTITION is not set
 +CONFIG_SPL_OF_CONTROL=y
 +CONFIG_OF_LIVE=y
 +CONFIG_NET_RANDOM_ETHADDR=y
-+CONFIG_SPL_DM_WARN=y
 +CONFIG_SPL_REGMAP=y
 +CONFIG_SPL_SYSCON=y
 +CONFIG_SPL_CLK=y
++CONFIG_CLK_SCMI=y
++CONFIG_RESET_SCMI=y
 +CONFIG_ROCKCHIP_GPIO=y
-+CONFIG_ROCKCHIP_GPIO_V2=y
 +CONFIG_SYS_I2C_ROCKCHIP=y
 +CONFIG_MISC=y
-+CONFIG_MMC_HS200_SUPPORT=y
-+CONFIG_SPL_MMC_HS200_SUPPORT=y
++CONFIG_SUPPORT_EMMC_RPMB=y
 +CONFIG_MMC_DW=y
 +CONFIG_MMC_DW_ROCKCHIP=y
 +CONFIG_MMC_SDHCI=y
 +CONFIG_MMC_SDHCI_SDMA=y
 +CONFIG_MMC_SDHCI_ROCKCHIP=y
-+CONFIG_DM_ETH=y
 +CONFIG_ETH_DESIGNWARE=y
 +CONFIG_GMAC_ROCKCHIP=y
-+CONFIG_POWER_DOMAIN=y
 +CONFIG_DM_PMIC=y
 +CONFIG_PMIC_RK8XX=y
 +CONFIG_SPL_PMIC_RK8XX=y
++CONFIG_PHY_ROCKCHIP_INNO_USB2=y
++CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 +CONFIG_REGULATOR_PWM=y
-+CONFIG_DM_REGULATOR_FIXED=y
-+CONFIG_SPL_DM_REGULATOR_FIXED=y
-+CONFIG_DM_REGULATOR_GPIO=y
 +CONFIG_REGULATOR_RK8XX=y
 +CONFIG_PWM_ROCKCHIP=y
 +CONFIG_SPL_RAM=y
-+CONFIG_DM_RESET=y
 +CONFIG_BAUDRATE=1500000
 +CONFIG_DEBUG_UART_SHIFT=2
++CONFIG_SYS_NS16550_MEM32=y
 +CONFIG_SYSRESET=y
 +CONFIG_USB=y
 +CONFIG_USB_XHCI_HCD=y
 +CONFIG_USB_XHCI_DWC3=y
 +CONFIG_USB_EHCI_HCD=y
 +CONFIG_USB_EHCI_GENERIC=y
-+CONFIG_USB_OHCI_HCD=y
-+CONFIG_USB_OHCI_GENERIC=y
 +CONFIG_USB_DWC3=y
 +CONFIG_USB_DWC3_GENERIC=y
-+CONFIG_ROCKCHIP_USB2_PHY=y
-+CONFIG_USB_KEYBOARD=y
-+CONFIG_USB_HOST_ETHER=y
-+CONFIG_USB_ETHER_LAN75XX=y
-+CONFIG_USB_ETHER_LAN78XX=y
-+CONFIG_USB_ETHER_SMSC95XX=y
 +CONFIG_ERRNO_STR=y
