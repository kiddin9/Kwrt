diff --git a/package/boot/arm-trusted-firmware-sunxi/Makefile b/package/boot/arm-trusted-firmware-sunxi/Makefile
index 0abfbae750142..9608ce39a1d2a 100644
--- a/package/boot/arm-trusted-firmware-sunxi/Makefile
+++ b/package/boot/arm-trusted-firmware-sunxi/Makefile
@@ -12,9 +12,9 @@ PKG_RELEASE:=1
 
 PKG_SOURCE_PROTO:=git
 PKG_SOURCE_URL=https://github.com/ARM-software/arm-trusted-firmware
-PKG_SOURCE_DATE:=2020-11-17
-PKG_SOURCE_VERSION:=e2c509a39c6cc4dda8734e6509cdbe6e3603cdfc
-PKG_MIRROR_HASH:=b212d369a5286ebbf6a5616486efa05fa54d4294fd6e9ba2e54fdfae9eda918d
+PKG_SOURCE_DATE:=2022-06-01
+PKG_SOURCE_VERSION:=35f4c7295bafeb32c8bcbdfb6a3f2e74a57e732b
+PKG_MIRROR_HASH:=88a282242ca5c921ce43eb913112e964ae87ddf85a87f2d4d6d192d1fe943370
 
 PKG_LICENSE:=BSD-3-Clause
 PKG_LICENSE_FILES:=license.md
@@ -42,6 +42,11 @@ define Package/arm-trusted-firmware-sunxi-h6
     VARIANT:=sun50i_h6
 endef
 
+define Package/arm-trusted-firmware-sunxi-h616
+    $(call Package/arm-trusted-firmware-sunxi/Default)
+    VARIANT:=sun50i_h616
+endef
+
 export GCC_HONOUR_COPTS=s
 
 MAKE_VARS = \
@@ -61,3 +66,4 @@ endef
 
 $(eval $(call BuildPackage,arm-trusted-firmware-sunxi-a64))
 $(eval $(call BuildPackage,arm-trusted-firmware-sunxi-h6))
+$(eval $(call BuildPackage,arm-trusted-firmware-sunxi-h616))
diff --git a/package/boot/uboot-sunxi/Makefile b/package/boot/uboot-sunxi/Makefile
index 5c27407d15511..1e3c8ea4da0e4 100644
--- a/package/boot/uboot-sunxi/Makefile
+++ b/package/boot/uboot-sunxi/Makefile
@@ -322,6 +322,15 @@ define U-Boot/orangepi_pc2
   ATF:=a64
 endef
 
+define U-Boot/orangepi_zero2
+  BUILD_SUBTARGET:=cortexa53
+  NAME:=Xunlong Orange Pi Zero2
+  BUILD_DEVICES:=xunlong_orangepi-zero2
+  DEPENDS:=+PACKAGE_u-boot-orangepi_zero2:arm-trusted-firmware-sunxi-h616
+  UENV:=h616
+  ATF:=h616
+endef
+
 define U-Boot/Bananapi_M2_Ultra
   BUILD_SUBTARGET:=cortexa7
   NAME:=Bananapi M2 Ultra
@@ -376,6 +385,7 @@ UBOOT_TARGETS := \
 	orangepi_plus \
 	orangepi_2 \
 	orangepi_pc2 \
+	orangepi_zero2 \
 	pangolin \
 	pine64_plus \
 	sopine_baseboard \
diff --git a/package/boot/uboot-sunxi/uEnv-h616.txt b/package/boot/uboot-sunxi/uEnv-h616.txt
new file mode 100644
index 0000000000000..78810ff223cce
--- /dev/null
+++ b/package/boot/uboot-sunxi/uEnv-h616.txt
@@ -0,0 +1,7 @@
+setenv mmc_rootpart 2
+part uuid mmc ${mmc_bootdev}:${mmc_rootpart} uuid
+setenv loadkernel fatload mmc \$mmc_bootdev \$kernel_addr_r uImage
+setenv loaddtb fatload mmc \$mmc_bootdev \$fdt_addr_r dtb
+setenv bootargs console=ttyS0,115200 earlyprintk root=PARTUUID=${uuid} rootwait
+setenv uenvcmd run loadkernel \&\& run loaddtb \&\& booti \$kernel_addr_r - \$fdt_addr_r
+run uenvcmd

diff --git a/target/linux/sunxi/image/cortexa53.mk b/target/linux/sunxi/image/cortexa53.mk
index a00bac2c81c76..ba36f75533b99 100644
--- a/target/linux/sunxi/image/cortexa53.mk
+++ b/target/linux/sunxi/image/cortexa53.mk
@@ -24,6 +24,11 @@ define Device/sun50i-h6
   $(Device/sun50i)
 endef
 
+define Device/sun50i-h616
+  SOC := sun50i-h616
+  $(Device/sun50i)
+endef
+
 define Device/friendlyarm_nanopi-neo-plus2
   DEVICE_VENDOR := FriendlyARM
   DEVICE_MODEL := NanoPi NEO Plus2
@@ -101,6 +106,14 @@ define Device/xunlong_orangepi-one-plus
 endef
 TARGET_DEVICES += xunlong_orangepi-one-plus
 
+define Device/xunlong_orangepi-zero2
+  $(Device/sun50i-h616)
+  DEVICE_VENDOR := Xunlong
+  DEVICE_MODEL := Orange Pi Zero2
+  SUNXI_DTS_DIR := allwinner/
+endef
+TARGET_DEVICES += xunlong_orangepi-zero2
+
 define Device/xunlong_orangepi-pc2
   DEVICE_VENDOR := Xunlong
   DEVICE_MODEL := Orange Pi PC 2
diff --git a/target/linux/sunxi/patches-5.10/502-Add-support-for-the-Allwinner-H616-pin-controller.patch b/target/linux/sunxi/patches-5.10/502-Add-support-for-the-Allwinner-H616-pin-controller.patch
new file mode 100644
index 0000000000000..1759077ff33fd
--- /dev/null
+++ b/target/linux/sunxi/patches-5.10/502-Add-support-for-the-Allwinner-H616-pin-controller.patch
@@ -0,0 +1,580 @@
+diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
+index 593293584ecc..73e88ce71a48 100644
+--- a/drivers/pinctrl/sunxi/Kconfig
++++ b/drivers/pinctrl/sunxi/Kconfig
+@@ -119,4 +119,9 @@  config PINCTRL_SUN50I_H6_R
+ 	default ARM64 && ARCH_SUNXI
+ 	select PINCTRL_SUNXI
+ 
++config PINCTRL_SUN50I_H616
++	bool "Support for the Allwinner H616 PIO"
++	default ARM64 && ARCH_SUNXI
++	select PINCTRL_SUNXI
++
+ endif
+diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
+index 8b7ff0dc3bdf..5359327a3c8f 100644
+--- a/drivers/pinctrl/sunxi/Makefile
++++ b/drivers/pinctrl/sunxi/Makefile
+@@ -23,5 +23,6 @@  obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
+ obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
+ obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
+ obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
++obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
+ obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
+ obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
+diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
+new file mode 100644
+index 000000000000..734f63eb08dd
+--- /dev/null
++++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
+@@ -0,0 +1,549 @@ 
++// SPDX-License-Identifier: GPL-2.0
++/*
++ * Allwinner H616 SoC pinctrl driver.
++ *
++ * Copyright (C) 2020 Arm Ltd.
++ * based on the H6 pinctrl driver
++ *   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
++ */
++
++#include <linux/module.h>
++#include <linux/platform_device.h>
++#include <linux/of.h>
++#include <linux/of_device.h>
++#include <linux/pinctrl/pinctrl.h>
++
++#include "pinctrl-sunxi.h"
++
++static const struct sunxi_desc_pin h616_pins[] = {
++	/* Internal connection to the AC200 part */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* ERXD1 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* ERXD0 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* ECRS_DV */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* ERXERR */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* ETXD1 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* ETXD0 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* ETXCK */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* ETXEN */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* EMDC */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
++		SUNXI_FUNCTION(0x2, "emac1")),		/* EMDIO */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 10),
++		SUNXI_FUNCTION(0x2, "i2c3")),		/* SCK */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 11),
++		SUNXI_FUNCTION(0x2, "i2c3")),		/* SDA */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 12),
++		SUNXI_FUNCTION(0x2, "pwm5")),
++	/* Hole */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* WE */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* DS */
++		  SUNXI_FUNCTION(0x4, "spi0"),		/* CLK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PC_EINT0 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* ALE */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* RST */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PC_EINT1 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* CLE */
++		  SUNXI_FUNCTION(0x4, "spi0"),		/* MOSI */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PC_EINT2 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* CE1 */
++		  SUNXI_FUNCTION(0x4, "spi0"),		/* CS0 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PC_EINT3 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 4),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* CE0 */
++		  SUNXI_FUNCTION(0x4, "spi0"),		/* MISO */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PC_EINT4 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* RE */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* CLK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PC_EINT5 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* RB0 */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* CMD */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PC_EINT6 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 7),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* RB1 */
++		  SUNXI_FUNCTION(0x4, "spi0"),		/* CS1 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PC_EINT7 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 8),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ7 */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D3 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PC_EINT8 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 9),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ6 */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D4 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PC_EINT9 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 10),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ5 */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D0 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PC_EINT10 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 11),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ4 */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D5 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),	/* PC_EINT11 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 12),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQS */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),	/* PC_EINT12 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 13),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ3 */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D1 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 13)),	/* PC_EINT13 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ2 */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D6 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),	/* PC_EINT14 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ1 */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D2 */
++		  SUNXI_FUNCTION(0x4, "spi0"),		/* WP */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),	/* PC_EINT15 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 16),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ0 */
++		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D7 */
++		  SUNXI_FUNCTION(0x4, "spi0"),		/* HOLD */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),	/* PC_EINT16 */
++	/* Hole */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D1 */
++		  SUNXI_FUNCTION(0x3, "jtag"),		/* MS */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PF_EINT0 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D0 */
++		  SUNXI_FUNCTION(0x3, "jtag"),		/* DI */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PF_EINT1 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CLK */
++		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PF_EINT2 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CMD */
++		  SUNXI_FUNCTION(0x3, "jtag"),		/* DO */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PF_EINT3 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D3 */
++		  SUNXI_FUNCTION(0x3, "uart0"),		/* RX */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PF_EINT4 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D2 */
++		  SUNXI_FUNCTION(0x3, "jtag"),		/* CK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PF_EINT5 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 6),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PF_EINT6 */
++	/* Hole */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc1"),		/* CLK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PG_EINT0 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc1"),		/* CMD */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PG_EINT1 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D0 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PG_EINT2 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D1 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PG_EINT3 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D2 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PG_EINT4 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D3 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PG_EINT5 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart1"),		/* TX */
++		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PG_EINT6 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart1"),		/* RX */
++		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PG_EINT7 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
++		  SUNXI_FUNCTION(0x3, "clock"),		/* PLL_LOCK_DEBUG */
++		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PG_EINT8 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PG_EINT9 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "h_i2s2"),	/* MCLK */
++		  SUNXI_FUNCTION(0x3, "clock"),		/* X32KFOUT */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PG_EINT10 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "h_i2s2"),	/* BCLK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PG_EINT11 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "h_i2s2"),	/* SYNC */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PG_EINT12 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 13),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "h_i2s2"),	/* DOUT */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PG_EINT13 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 14),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "h_i2s2"),	/* DIN */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PG_EINT14 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 15),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
++		  SUNXI_FUNCTION(0x5, "i2c4"),		/* SCK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 15)),	/* PG_EINT15 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 16),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
++		  SUNXI_FUNCTION(0x5, "i2c4"),		/* SDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 16)),	/* PG_EINT16 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 17),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart2"),		/* RTS */
++		  SUNXI_FUNCTION(0x5, "i2c3"),		/* SCK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 17)),	/* PG_EINT17 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 18),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart2"),		/* CTS */
++		  SUNXI_FUNCTION(0x5, "i2c3"),		/* SDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 18)),	/* PG_EINT18 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 19),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x4, "pwm1"),
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 19)),	/* PG_EINT19 */
++	/* Hole */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 0),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
++		  SUNXI_FUNCTION(0x4, "pwm3"),
++		  SUNXI_FUNCTION(0x5, "i2c1"),		/* SCK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/* PH_EINT0 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 1),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart0"),		/* RX */
++		  SUNXI_FUNCTION(0x4, "pwm4"),
++		  SUNXI_FUNCTION(0x5, "i2c1"),		/* SDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/* PH_EINT1 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 2),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart5"),		/* TX */
++		  SUNXI_FUNCTION(0x3, "spdif"),		/* MCLK */
++		  SUNXI_FUNCTION(0x4, "pwm2"),
++		  SUNXI_FUNCTION(0x5, "i2c2"),		/* SCK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/* PH_EINT2 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 3),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart5"),		/* RX */
++		  SUNXI_FUNCTION(0x4, "pwm1"),
++		  SUNXI_FUNCTION(0x5, "i2c2"),		/* SDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/* PH_EINT3 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 4),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x3, "spdif"),		/* OUT */
++		  SUNXI_FUNCTION(0x5, "i2c3"),		/* SCK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/* PH_EINT4 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 5),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
++		  SUNXI_FUNCTION(0x3, "h_i2s3"),	/* MCLK */
++		  SUNXI_FUNCTION(0x4, "spi1"),		/* CS0 */
++		  SUNXI_FUNCTION(0x5, "i2c3"),		/* SDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/* PH_EINT5 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 6),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart2"),		/* RX */
++		  SUNXI_FUNCTION(0x3, "h_i2s3"),	/* BCLK */
++		  SUNXI_FUNCTION(0x4, "spi1"),		/* CLK */
++		  SUNXI_FUNCTION(0x5, "i2c4"),		/* SCK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/* PH_EINT6 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart2"),		/* RTS */
++		  SUNXI_FUNCTION(0x3, "h_i2s3"),	/* SYNC */
++		  SUNXI_FUNCTION(0x4, "spi1"),		/* MOSI */
++		  SUNXI_FUNCTION(0x5, "i2c4"),		/* SDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/* PH_EINT7 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "uart2"),		/* CTS */
++		  SUNXI_FUNCTION(0x3, "h_i2s3"),	/* DO0 */
++		  SUNXI_FUNCTION(0x4, "spi1"),		/* MISO */
++		  SUNXI_FUNCTION(0x5, "h_i2s3"),	/* DI1 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/* PH_EINT8 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x3, "h_i2s3"),	/* DI0 */
++		  SUNXI_FUNCTION(0x4, "spi1"),		/* CS1 */
++		  SUNXI_FUNCTION(0x3, "h_i2s3"),	/* DO1 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/* PH_EINT9 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 10),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x3, "ir_rx"),
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 10)),	/* PH_EINT10 */
++	/* Hole */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 0),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ERXD3 */
++		  SUNXI_FUNCTION(0x3, "dmic"),		/* CLK */
++		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* MCLK */
++		  SUNXI_FUNCTION(0x5, "hdmi"),		/* HSCL */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 0)),	/* PI_EINT0 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 1),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ERXD2 */
++		  SUNXI_FUNCTION(0x3, "dmic"),		/* DATA0 */
++		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* BCLK */
++		  SUNXI_FUNCTION(0x5, "hdmi"),		/* HSDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 1)),	/* PI_EINT1 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 2),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ERXD1 */
++		  SUNXI_FUNCTION(0x3, "dmic"),		/* DATA1 */
++		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* SYNC */
++		  SUNXI_FUNCTION(0x5, "hdmi"),		/* HCEC */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 2)),	/* PI_EINT2 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 3),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ERXD0 */
++		  SUNXI_FUNCTION(0x3, "dmic"),		/* DATA2 */
++		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* DO0 */
++		  SUNXI_FUNCTION(0x5, "h_i2s0"),	/* DI1 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 3)),	/* PI_EINT3 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 4),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ERXCK */
++		  SUNXI_FUNCTION(0x3, "dmic"),		/* DATA3 */
++		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* DI0 */
++		  SUNXI_FUNCTION(0x5, "h_i2s0"),	/* DO1 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 4)),	/* PI_EINT4 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 5),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ERXCTL */
++		  SUNXI_FUNCTION(0x3, "uart2"),		/* TX */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* CLK */
++		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SCK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 5)),	/* PI_EINT5 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 6),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ENULL */
++		  SUNXI_FUNCTION(0x3, "uart2"),		/* RX */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* ERR */
++		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 6)),	/* PI_EINT6 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 7),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ETXD3 */
++		  SUNXI_FUNCTION(0x3, "uart2"),		/* RTS */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* SYNC */
++		  SUNXI_FUNCTION(0x5, "i2c1"),		/* SCK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 7)),	/* PI_EINT7 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 8),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ETXD2 */
++		  SUNXI_FUNCTION(0x3, "uart2"),		/* CTS */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* DVLD */
++		  SUNXI_FUNCTION(0x5, "i2c1"),		/* SDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 8)),	/* PI_EINT8 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 9),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ETXD1 */
++		  SUNXI_FUNCTION(0x3, "uart3"),		/* TX */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* D0 */
++		  SUNXI_FUNCTION(0x5, "i2c2"),		/* SCK */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 9)),	/* PI_EINT9 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 10),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ETXD0 */
++		  SUNXI_FUNCTION(0x3, "uart3"),		/* RX */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* D1 */
++		  SUNXI_FUNCTION(0x5, "i2c2"),		/* SDA */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 10)),	/* PI_EINT10 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 11),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ETXCK */
++		  SUNXI_FUNCTION(0x3, "uart3"),		/* RTS */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* D2 */
++		  SUNXI_FUNCTION(0x5, "pwm1"),
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 11)),	/* PI_EINT11 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 12),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ETXCTL */
++		  SUNXI_FUNCTION(0x3, "uart3"),		/* CTS */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* D3 */
++		  SUNXI_FUNCTION(0x5, "pwm2"),
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 12)),	/* PI_EINT12 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 13),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* ECLKIN */
++		  SUNXI_FUNCTION(0x3, "uart4"),		/* TX */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* D4 */
++		  SUNXI_FUNCTION(0x5, "pwm3"),
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 13)),	/* PI_EINT13 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 14),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* MDC */
++		  SUNXI_FUNCTION(0x3, "uart4"),		/* RX */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* D5 */
++		  SUNXI_FUNCTION(0x5, "pwm4"),
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 14)),	/* PI_EINT14 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 15),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* MDIO */
++		  SUNXI_FUNCTION(0x3, "uart4"),		/* RTS */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* D6 */
++		  SUNXI_FUNCTION(0x5, "clock"),		/* CLK_FANOUT0 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 15)),	/* PI_EINT15 */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(I, 16),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x2, "emac0"),		/* EPHY_CLK */
++		  SUNXI_FUNCTION(0x3, "uart4"),		/* CTS */
++		  SUNXI_FUNCTION(0x4, "ts0"),		/* D7 */
++		  SUNXI_FUNCTION(0x5, "clock"),		/* CLK_FANOUT1 */
++		  SUNXI_FUNCTION_IRQ_BANK(0x6, 4, 16)),	/* PI_EINT16 */
++};
++static const unsigned int h616_irq_bank_map[] = { 2, 5, 6, 7, 8 };
++
++static const struct sunxi_pinctrl_desc h616_pinctrl_data = {
++	.pins = h616_pins,
++	.npins = ARRAY_SIZE(h616_pins),
++	.irq_banks = 5,
++	.irq_bank_map = h616_irq_bank_map,
++	.irq_read_needs_mux = true,
++	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
++};
++
++static int h616_pinctrl_probe(struct platform_device *pdev)
++{
++	return sunxi_pinctrl_init(pdev,
++				  &h616_pinctrl_data);
++}
++
++static const struct of_device_id h616_pinctrl_match[] = {
++	{ .compatible = "allwinner,sun50i-h616-pinctrl", },
++	{}
++};
++
++static struct platform_driver h616_pinctrl_driver = {
++	.probe	= h616_pinctrl_probe,
++	.driver	= {
++		.name		= "sun50i-h616-pinctrl",
++		.of_match_table	= h616_pinctrl_match,
++	},
++};
++builtin_platform_driver(h616_pinctrl_driver);
diff --git a/target/linux/sunxi/patches-5.10/503-Add-support-for-the-Allwinner-H616-R-pin-controller.patch b/target/linux/sunxi/patches-5.10/503-Add-support-for-the-Allwinner-H616-R-pin-controller.patch
new file mode 100644
index 0000000000000..b876452508a27
--- /dev/null
+++ b/target/linux/sunxi/patches-5.10/503-Add-support-for-the-Allwinner-H616-R-pin-controller.patch
@@ -0,0 +1,89 @@
+diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
+index 73e88ce71a48..33751a6a0757 100644
+--- a/drivers/pinctrl/sunxi/Kconfig
++++ b/drivers/pinctrl/sunxi/Kconfig
+@@ -124,4 +124,9 @@  config PINCTRL_SUN50I_H616
+ 	default ARM64 && ARCH_SUNXI
+ 	select PINCTRL_SUNXI
+ 
++config PINCTRL_SUN50I_H616_R
++	bool "Support for the Allwinner H616 R-PIO"
++	default ARM64 && ARCH_SUNXI
++	select PINCTRL_SUNXI
++
+ endif
+diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
+index 5359327a3c8f..d3440c42b9d6 100644
+--- a/drivers/pinctrl/sunxi/Makefile
++++ b/drivers/pinctrl/sunxi/Makefile
+@@ -24,5 +24,6 @@  obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
+ obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
+ obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
+ obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
++obj-$(CONFIG_PINCTRL_SUN50I_H616_R)	+= pinctrl-sun50i-h616-r.o
+ obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
+ obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
+diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
+new file mode 100644
+index 000000000000..eb76c009bf24
+--- /dev/null
++++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
+@@ -0,0 +1,58 @@ 
++// SPDX-License-Identifier: GPL-2.0
++/*
++ * Allwinner H616 R_PIO pin controller driver
++ *
++ * Copyright (C) 2020 Arm Ltd.
++ * Based on former work, which is:
++ *   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
++ *   Copyright (C) 2014 Boris Brezillon
++ *   Boris Brezillon <boris.brezillon@free-electrons.com>
++ *   Copyright (C) 2014 Maxime Ripard
++ *   Maxime Ripard <maxime.ripard@free-electrons.com>
++ */
++
++#include <linux/init.h>
++#include <linux/platform_device.h>
++#include <linux/of.h>
++#include <linux/of_device.h>
++#include <linux/pinctrl/pinctrl.h>
++#include <linux/reset.h>
++
++#include "pinctrl-sunxi.h"
++
++static const struct sunxi_desc_pin sun50i_h616_r_pins[] = {
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x3, "s_i2c")),	/* SCK */
++	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
++		  SUNXI_FUNCTION(0x0, "gpio_in"),
++		  SUNXI_FUNCTION(0x1, "gpio_out"),
++		  SUNXI_FUNCTION(0x3, "s_i2c")),	/* SDA */
++};
++
++static const struct sunxi_pinctrl_desc sun50i_h616_r_pinctrl_data = {
++	.pins = sun50i_h616_r_pins,
++	.npins = ARRAY_SIZE(sun50i_h616_r_pins),
++	.pin_base = PL_BASE,
++};
++
++static int sun50i_h616_r_pinctrl_probe(struct platform_device *pdev)
++{
++	return sunxi_pinctrl_init(pdev,
++				  &sun50i_h616_r_pinctrl_data);
++}
++
++static const struct of_device_id sun50i_h616_r_pinctrl_match[] = {
++	{ .compatible = "allwinner,sun50i-h616-r-pinctrl", },
++	{}
++};
++
++static struct platform_driver sun50i_h616_r_pinctrl_driver = {
++	.probe	= sun50i_h616_r_pinctrl_probe,
++	.driver	= {
++		.name		= "sun50i-h616-r-pinctrl",
++		.of_match_table	= sun50i_h616_r_pinctrl_match,
++	},
++};
++builtin_platform_driver(sun50i_h616_r_pinctrl_driver);
diff --git a/target/linux/sunxi/patches-5.10/504-Add-support-for-the-Allwinner-H616-R-CCU.patch b/target/linux/sunxi/patches-5.10/504-Add-support-for-the-Allwinner-H616-R-CCU.patch
new file mode 100644
index 0000000000000..f7bfe45706a90
--- /dev/null
+++ b/target/linux/sunxi/patches-5.10/504-Add-support-for-the-Allwinner-H616-R-CCU.patch
@@ -0,0 +1,96 @@
+diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+index 50f8d1bc7046..119d1797f501 100644
+--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
++++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+@@ -136,6 +136,15 @@  static struct ccu_common *sun50i_h6_r_ccu_clks[] = {
+ 	&w1_clk.common,
+ };
+ 
++static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
++	&r_apb1_clk.common,
++	&r_apb2_clk.common,
++	&r_apb1_twd_clk.common,
++	&r_apb2_i2c_clk.common,
++	&r_apb1_ir_clk.common,
++	&ir_clk.common,
++};
++
+ static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
+ 	.hws	= {
+ 		[CLK_AR100]		= &ar100_clk.common.hw,
+@@ -152,7 +161,20 @@  static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
+ 		[CLK_IR]		= &ir_clk.common.hw,
+ 		[CLK_W1]		= &w1_clk.common.hw,
+ 	},
+-	.num	= CLK_NUMBER,
++	.num	= CLK_NUMBER_H616,
++};
++
++static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
++	.hws	= {
++		[CLK_R_AHB]		= &r_ahb_clk.hw,
++		[CLK_R_APB1]		= &r_apb1_clk.common.hw,
++		[CLK_R_APB2]		= &r_apb2_clk.common.hw,
++		[CLK_R_APB1_TWD]	= &r_apb1_twd_clk.common.hw,
++		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
++		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
++		[CLK_IR]		= &ir_clk.common.hw,
++	},
++	.num	= CLK_NUMBER_H616,
+ };
+ 
+ static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
+@@ -165,6 +187,12 @@  static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
+ 	[RST_R_APB1_W1]		=  { 0x1ec, BIT(16) },
+ };
+ 
++static struct ccu_reset_map sun50i_h616_r_ccu_resets[] = {
++	[RST_R_APB1_TWD]	=  { 0x12c, BIT(16) },
++	[RST_R_APB2_I2C]	=  { 0x19c, BIT(16) },
++	[RST_R_APB1_IR]		=  { 0x1cc, BIT(16) },
++};
++
+ static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc = {
+ 	.ccu_clks	= sun50i_h6_r_ccu_clks,
+ 	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_r_ccu_clks),
+@@ -175,6 +203,16 @@  static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc = {
+ 	.num_resets	= ARRAY_SIZE(sun50i_h6_r_ccu_resets),
+ };
+ 
++static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
++	.ccu_clks	= sun50i_h616_r_ccu_clks,
++	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_r_ccu_clks),
++
++	.hw_clks	= &sun50i_h616_r_hw_clks,
++
++	.resets		= sun50i_h616_r_ccu_resets,
++	.num_resets	= ARRAY_SIZE(sun50i_h616_r_ccu_resets),
++};
++
+ static void __init sunxi_r_ccu_init(struct device_node *node,
+ 				    const struct sunxi_ccu_desc *desc)
+ {
+@@ -195,3 +233,10 @@  static void __init sun50i_h6_r_ccu_setup(struct device_node *node)
+ }
+ CLK_OF_DECLARE(sun50i_h6_r_ccu, "allwinner,sun50i-h6-r-ccu",
+ 	       sun50i_h6_r_ccu_setup);
++
++static void __init sun50i_h616_r_ccu_setup(struct device_node *node)
++{
++	sunxi_r_ccu_init(node, &sun50i_h616_r_ccu_desc);
++}
++CLK_OF_DECLARE(sun50i_h616_r_ccu, "allwinner,sun50i-h616-r-ccu",
++	       sun50i_h616_r_ccu_setup);
+diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
+index 782117dc0b28..128302696ca1 100644
+--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
++++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
+@@ -14,6 +14,7 @@ 
+ 
+ #define CLK_R_APB2	3
+ 
+-#define CLK_NUMBER	(CLK_W1 + 1)
++#define CLK_NUMBER_H6	(CLK_W1 + 1)
++#define CLK_NUMBER_H616	(CLK_IR + 1)
+ 
+ #endif /* _CCU_SUN50I_H6_R_H */
diff --git a/target/linux/sunxi/patches-5.10/505-Add-support-for-the-Allwinner-H616-CCU.patch b/target/linux/sunxi/patches-5.10/505-Add-support-for-the-Allwinner-H616-CCU.patch
new file mode 100644
index 0000000000000..488d3cee3e02a
--- /dev/null
+++ b/target/linux/sunxi/patches-5.10/505-Add-support-for-the-Allwinner-H616-CCU.patch
@@ -0,0 +1,1424 @@
+diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
+index ce5f5847d5d3..cd46d8853876 100644
+--- a/drivers/clk/sunxi-ng/Kconfig
++++ b/drivers/clk/sunxi-ng/Kconfig
+@@ -32,8 +32,13 @@  config SUN50I_H6_CCU
+ 	default ARM64 && ARCH_SUNXI
+ 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+ 
++config SUN50I_H616_CCU
++	bool "Support for the Allwinner H616 CCU"
++	default ARM64 && ARCH_SUNXI
++	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
++
+ config SUN50I_H6_R_CCU
+-	bool "Support for the Allwinner H6 PRCM CCU"
++	bool "Support for the Allwinner H6 and H616 PRCM CCU"
+ 	default ARM64 && ARCH_SUNXI
+ 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+ 
+diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
+index 3eb5cff40eac..96c324306d97 100644
+--- a/drivers/clk/sunxi-ng/Makefile
++++ b/drivers/clk/sunxi-ng/Makefile
+@@ -26,6 +26,7 @@  obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
+ obj-$(CONFIG_SUN50I_A100_CCU)	+= ccu-sun50i-a100.o
+ obj-$(CONFIG_SUN50I_A100_R_CCU)	+= ccu-sun50i-a100-r.o
+ obj-$(CONFIG_SUN50I_H6_CCU)	+= ccu-sun50i-h6.o
++obj-$(CONFIG_SUN50I_H616_CCU)	+= ccu-sun50i-h616.o
+ obj-$(CONFIG_SUN50I_H6_R_CCU)	+= ccu-sun50i-h6-r.o
+ obj-$(CONFIG_SUN4I_A10_CCU)	+= ccu-sun4i-a10.o
+ obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
+diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+new file mode 100644
+index 000000000000..3fbb258f0354
+--- /dev/null
++++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+@@ -0,0 +1,1134 @@ 
++// SPDX-License-Identifier: GPL-2.0
++/*
++ * Copyright (c) 2020 Arm Ltd.
++ * Based on the H6 CCU driver, which is:
++ *   Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
++ */
++
++#include <linux/clk-provider.h>
++#include <linux/io.h>
++#include <linux/of_address.h>
++#include <linux/platform_device.h>
++
++#include "ccu_common.h"
++#include "ccu_reset.h"
++
++#include "ccu_div.h"
++#include "ccu_gate.h"
++#include "ccu_mp.h"
++#include "ccu_mult.h"
++#include "ccu_nk.h"
++#include "ccu_nkm.h"
++#include "ccu_nkmp.h"
++#include "ccu_nm.h"
++
++#include "ccu-sun50i-h616.h"
++
++/*
++ * The CPU PLL is actually NP clock, with P being /1, /2 or /4. However
++ * P should only be used for output frequencies lower than 288 MHz.
++ *
++ * For now we can just model it as a multiplier clock, and force P to /1.
++ *
++ * The M factor is present in the register's description, but not in the
++ * frequency formula, and it's documented as "M is only used for backdoor
++ * testing", so it's not modelled and then force to 0.
++ */
++#define SUN50I_H616_PLL_CPUX_REG	0x000
++static struct ccu_mult pll_cpux_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.mult		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.common		= {
++		.reg		= 0x000,
++		.hw.init	= CLK_HW_INIT("pll-cpux", "osc24M",
++					      &ccu_mult_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
++#define SUN50I_H616_PLL_DDR0_REG	0x010
++static struct ccu_nkmp pll_ddr0_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
++	.common		= {
++		.reg		= 0x010,
++		.hw.init	= CLK_HW_INIT("pll-ddr0", "osc24M",
++					      &ccu_nkmp_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++#define SUN50I_H616_PLL_DDR1_REG	0x018
++static struct ccu_nkmp pll_ddr1_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
++	.common		= {
++		.reg		= 0x018,
++		.hw.init	= CLK_HW_INIT("pll-ddr1", "osc24M",
++					      &ccu_nkmp_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++#define SUN50I_H616_PLL_PERIPH0_REG	0x020
++static struct ccu_nkmp pll_periph0_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
++	.fixed_post_div	= 4,
++	.common		= {
++		.reg		= 0x020,
++		.features	= CCU_FEATURE_FIXED_POSTDIV,
++		.hw.init	= CLK_HW_INIT("pll-periph0", "osc24M",
++					      &ccu_nkmp_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++#define SUN50I_H616_PLL_PERIPH1_REG	0x028
++static struct ccu_nkmp pll_periph1_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
++	.fixed_post_div	= 4,
++	.common		= {
++		.reg		= 0x028,
++		.features	= CCU_FEATURE_FIXED_POSTDIV,
++		.hw.init	= CLK_HW_INIT("pll-periph1", "osc24M",
++					      &ccu_nkmp_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++#define SUN50I_H616_PLL_GPU_REG		0x030
++static struct ccu_nkmp pll_gpu_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
++	.common		= {
++		.reg		= 0x030,
++		.hw.init	= CLK_HW_INIT("pll-gpu", "osc24M",
++					      &ccu_nkmp_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++/*
++ * For Video PLLs, the output divider is described as "used for testing"
++ * in the user manual. So it's not modelled and forced to 0.
++ */
++#define SUN50I_H616_PLL_VIDEO0_REG	0x040
++static struct ccu_nm pll_video0_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.fixed_post_div	= 4,
++	.min_rate	= 288000000,
++	.max_rate	= 2400000000UL,
++	.common		= {
++		.reg		= 0x040,
++		.features	= CCU_FEATURE_FIXED_POSTDIV,
++		.hw.init	= CLK_HW_INIT("pll-video0", "osc24M",
++					      &ccu_nm_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++#define SUN50I_H616_PLL_VIDEO1_REG	0x048
++static struct ccu_nm pll_video1_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.fixed_post_div	= 4,
++	.min_rate	= 288000000,
++	.max_rate	= 2400000000UL,
++	.common		= {
++		.reg		= 0x048,
++		.features	= CCU_FEATURE_FIXED_POSTDIV,
++		.hw.init	= CLK_HW_INIT("pll-video1", "osc24M",
++					      &ccu_nm_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++#define SUN50I_H616_PLL_VIDEO2_REG	0x050
++static struct ccu_nm pll_video2_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.fixed_post_div	= 4,
++	.min_rate	= 288000000,
++	.max_rate	= 2400000000UL,
++	.common		= {
++		.reg		= 0x050,
++		.features	= CCU_FEATURE_FIXED_POSTDIV,
++		.hw.init	= CLK_HW_INIT("pll-video2", "osc24M",
++					      &ccu_nm_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++#define SUN50I_H616_PLL_VE_REG		0x058
++static struct ccu_nkmp pll_ve_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
++	.common		= {
++		.reg		= 0x058,
++		.hw.init	= CLK_HW_INIT("pll-ve", "osc24M",
++					      &ccu_nkmp_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++#define SUN50I_H616_PLL_DE_REG		0x060
++static struct ccu_nkmp pll_de_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
++	.common		= {
++		.reg		= 0x060,
++		.hw.init	= CLK_HW_INIT("pll-de", "osc24M",
++					      &ccu_nkmp_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++/*
++ * TODO: Determine SDM settings for the audio PLL. The manual suggests
++ * PLL_FACTOR_N=16, PLL_POST_DIV_P=2, OUTPUT_DIV=2, pattern=0xe000c49b
++ * for 24.576 MHz, and PLL_FACTOR_N=22, PLL_POST_DIV_P=3, OUTPUT_DIV=2,
++ * pattern=0xe001288c for 22.5792 MHz.
++ * This clashes with our fixed PLL_POST_DIV_P.
++ */
++#define SUN50I_H616_PLL_AUDIO_REG	0x078
++static struct ccu_nm pll_audio_hs_clk = {
++	.enable		= BIT(31),
++	.lock		= BIT(28),
++	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
++	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
++	.common		= {
++		.reg		= 0x078,
++		.hw.init	= CLK_HW_INIT("pll-audio-hs", "osc24M",
++					      &ccu_nm_ops,
++					      CLK_SET_RATE_UNGATE),
++	},
++};
++
++static const char * const cpux_parents[] = { "osc24M", "osc32k",
++					"iosc", "pll-cpux", "pll-periph0" };
++static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
++		     0x500, 24, 3, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
++static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x500, 0, 2, 0);
++static SUNXI_CCU_M(cpux_apb_clk, "cpux-apb", "cpux", 0x500, 8, 2, 0);
++
++static const char * const psi_ahb1_ahb2_parents[] = { "osc24M", "osc32k",
++						      "iosc", "pll-periph0" };
++static SUNXI_CCU_MP_WITH_MUX(psi_ahb1_ahb2_clk, "psi-ahb1-ahb2",
++			     psi_ahb1_ahb2_parents,
++			     0x510,
++			     0, 2,	/* M */
++			     8, 2,	/* P */
++			     24, 2,	/* mux */
++			     0);
++
++static const char * const ahb3_apb1_apb2_parents[] = { "osc24M", "osc32k",
++						       "psi-ahb1-ahb2",
++						       "pll-periph0" };
++static SUNXI_CCU_MP_WITH_MUX(ahb3_clk, "ahb3", ahb3_apb1_apb2_parents, 0x51c,
++			     0, 2,	/* M */
++			     8, 2,	/* P */
++			     24, 2,	/* mux */
++			     0);
++
++static SUNXI_CCU_MP_WITH_MUX(apb1_clk, "apb1", ahb3_apb1_apb2_parents, 0x520,
++			     0, 2,	/* M */
++			     8, 2,	/* P */
++			     24, 2,	/* mux */
++			     0);
++
++static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", ahb3_apb1_apb2_parents, 0x524,
++			     0, 2,	/* M */
++			     8, 2,	/* P */
++			     24, 2,	/* mux */
++			     0);
++
++static const char * const mbus_parents[] = { "osc24M", "pll-periph0-2x",
++					     "pll-ddr0", "pll-ddr1" };
++static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents, 0x540,
++					0, 3,	/* M */
++					24, 2,	/* mux */
++					BIT(31),	/* gate */
++					CLK_IS_CRITICAL);
++
++static const char * const de_parents[] = { "pll-de", "pll-periph0-2x" };
++static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents, 0x600,
++				       0, 4,	/* M */
++				       24, 1,	/* mux */
++				       BIT(31),	/* gate */
++				       CLK_SET_RATE_PARENT);
++
++static SUNXI_CCU_GATE(bus_de_clk, "bus-de", "psi-ahb1-ahb2",
++		      0x60c, BIT(0), 0);
++
++static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk, "deinterlace",
++				       de_parents,
++				       0x620,
++				       0, 4,	/* M */
++				       24, 1,	/* mux */
++				       BIT(31),	/* gate */
++				       0);
++
++static SUNXI_CCU_GATE(bus_deinterlace_clk, "bus-deinterlace", "psi-ahb1-ahb2",
++		      0x62c, BIT(0), 0);
++
++static SUNXI_CCU_M_WITH_MUX_GATE(g2d_clk, "g2d", de_parents, 0x630,
++				       0, 4,	/* M */
++				       24, 1,	/* mux */
++				       BIT(31),	/* gate */
++				       0);
++
++static SUNXI_CCU_GATE(bus_g2d_clk, "bus-g2d", "psi-ahb1-ahb2",
++		      0x63c, BIT(0), 0);
++
++static const char * const gpu0_parents[] = { "pll-gpu", "gpu1" };
++static SUNXI_CCU_M_WITH_MUX_GATE(gpu0_clk, "gpu0", gpu0_parents, 0x670,
++				       0, 2,	/* M */
++				       24, 1,	/* mux */
++				       BIT(31),	/* gate */
++				       CLK_SET_RATE_PARENT);
++static SUNXI_CCU_M_WITH_GATE(gpu1_clk, "gpu1", "pll-periph0-2x", 0x674,
++					0, 3,	/* M */
++					BIT(31),/* gate */
++					0);
++
++static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
++		      0x67c, BIT(0), 0);
++
++static const char * const ce_parents[] = { "osc24M", "pll-periph0-2x" };
++static SUNXI_CCU_MP_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x680,
++					0, 4,	/* M */
++					8, 2,	/* N */
++					24, 1,	/* mux */
++					BIT(31),/* gate */
++					0);
++
++static SUNXI_CCU_GATE(bus_ce_clk, "bus-ce", "psi-ahb1-ahb2",
++		      0x68c, BIT(0), 0);
++
++static const char * const ve_parents[] = { "pll-ve" };
++static SUNXI_CCU_M_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
++				       0, 3,	/* M */
++				       24, 1,	/* mux */
++				       BIT(31),	/* gate */
++				       CLK_SET_RATE_PARENT);
++
++static SUNXI_CCU_GATE(bus_ve_clk, "bus-ve", "psi-ahb1-ahb2",
++		      0x69c, BIT(0), 0);
++
++static SUNXI_CCU_GATE(bus_dma_clk, "bus-dma", "psi-ahb1-ahb2",
++		      0x70c, BIT(0), 0);
++
++static SUNXI_CCU_GATE(bus_hstimer_clk, "bus-hstimer", "psi-ahb1-ahb2",
++		      0x73c, BIT(0), 0);
++
++static SUNXI_CCU_GATE(avs_clk, "avs", "osc24M", 0x740, BIT(31), 0);
++
++static SUNXI_CCU_GATE(bus_dbg_clk, "bus-dbg", "psi-ahb1-ahb2",
++		      0x78c, BIT(0), 0);
++
++static SUNXI_CCU_GATE(bus_psi_clk, "bus-psi", "psi-ahb1-ahb2",
++		      0x79c, BIT(0), 0);
++
++static SUNXI_CCU_GATE(bus_pwm_clk, "bus-pwm", "apb1", 0x7ac, BIT(0), 0);
++
++static SUNXI_CCU_GATE(bus_iommu_clk, "bus-iommu", "apb1", 0x7bc, BIT(0), 0);
++
++static const char * const dram_parents[] = { "pll-ddr0", "pll-ddr1" };
++static struct ccu_div dram_clk = {
++	.div		= _SUNXI_CCU_DIV(0, 2),
++	.mux		= _SUNXI_CCU_MUX(24, 2),
++	.common	= {
++		.reg		= 0x800,
++		.hw.init	= CLK_HW_INIT_PARENTS("dram",
++						      dram_parents,
++						      &ccu_div_ops,
++						      CLK_IS_CRITICAL),
++	},
++};
++
++static SUNXI_CCU_GATE(mbus_dma_clk, "mbus-dma", "mbus",
++		      0x804, BIT(0), 0);
++static SUNXI_CCU_GATE(mbus_ve_clk, "mbus-ve", "mbus",
++		      0x804, BIT(1), 0);
++static SUNXI_CCU_GATE(mbus_ce_clk, "mbus-ce", "mbus",
++		      0x804, BIT(2), 0);
++static SUNXI_CCU_GATE(mbus_ts_clk, "mbus-ts", "mbus",
++		      0x804, BIT(3), 0);
++static SUNXI_CCU_GATE(mbus_nand_clk, "mbus-nand", "mbus",
++		      0x804, BIT(5), 0);
++static SUNXI_CCU_GATE(mbus_g2d_clk, "mbus-g2d", "mbus",
++		      0x804, BIT(10), 0);
++
++static SUNXI_CCU_GATE(bus_dram_clk, "bus-dram", "psi-ahb1-ahb2",
++		      0x80c, BIT(0), CLK_IS_CRITICAL);
++
++static const char * const nand_spi_parents[] = { "osc24M", "pll-periph0",
++					     "pll-periph1", "pll-periph0-2x",
++					     "pll-periph1-2x" };
++static SUNXI_CCU_MP_WITH_MUX_GATE(nand0_clk, "nand0", nand_spi_parents, 0x810,
++					0, 4,	/* M */
++					8, 2,	/* N */
++					24, 3,	/* mux */
++					BIT(31),/* gate */
++					0);
++
++static SUNXI_CCU_MP_WITH_MUX_GATE(nand1_clk, "nand1", nand_spi_parents, 0x814,
++					0, 4,	/* M */
++					8, 2,	/* N */
++					24, 3,	/* mux */
++					BIT(31),/* gate */
++					0);
++
++static SUNXI_CCU_GATE(bus_nand_clk, "bus-nand", "ahb3", 0x82c, BIT(0), 0);
++
++static const char * const mmc_parents[] = { "osc24M", "pll-periph0-2x",
++					    "pll-periph1-2x" };
++static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
++					  0, 4,		/* M */
++					  8, 2,		/* N */
++					  24, 2,	/* mux */
++					  BIT(31),	/* gate */
++					  2,		/* post-div */
++					  0);
++
++static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
++					  0, 4,		/* M */
++					  8, 2,		/* N */
++					  24, 2,	/* mux */
++					  BIT(31),	/* gate */
++					  2,		/* post-div */
++					  0);
++
++static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
++					  0, 4,		/* M */
++					  8, 2,		/* N */
++					  24, 2,	/* mux */
++					  BIT(31),	/* gate */
++					  2,		/* post-div */
++					  0);
++
++static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0);
++static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0);
++static SUNXI_CCU_GATE(bus_mmc2_clk, "bus-mmc2", "ahb3", 0x84c, BIT(2), 0);
++
++static SUNXI_CCU_GATE(bus_uart0_clk, "bus-uart0", "apb2", 0x90c, BIT(0), 0);
++static SUNXI_CCU_GATE(bus_uart1_clk, "bus-uart1", "apb2", 0x90c, BIT(1), 0);
++static SUNXI_CCU_GATE(bus_uart2_clk, "bus-uart2", "apb2", 0x90c, BIT(2), 0);
++static SUNXI_CCU_GATE(bus_uart3_clk, "bus-uart3", "apb2", 0x90c, BIT(3), 0);
++static SUNXI_CCU_GATE(bus_uart4_clk, "bus-uart4", "apb2", 0x90c, BIT(4), 0);
++static SUNXI_CCU_GATE(bus_uart5_clk, "bus-uart5", "apb2", 0x90c, BIT(5), 0);
++
++static SUNXI_CCU_GATE(bus_i2c0_clk, "bus-i2c0", "apb2", 0x91c, BIT(0), 0);
++static SUNXI_CCU_GATE(bus_i2c1_clk, "bus-i2c1", "apb2", 0x91c, BIT(1), 0);
++static SUNXI_CCU_GATE(bus_i2c2_clk, "bus-i2c2", "apb2", 0x91c, BIT(2), 0);
++static SUNXI_CCU_GATE(bus_i2c3_clk, "bus-i2c3", "apb2", 0x91c, BIT(3), 0);
++static SUNXI_CCU_GATE(bus_i2c4_clk, "bus-i2c4", "apb2", 0x91c, BIT(4), 0);
++
++static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", nand_spi_parents, 0x940,
++					0, 4,	/* M */
++					8, 2,	/* N */
++					24, 3,	/* mux */
++					BIT(31),/* gate */
++					0);
++
++static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", nand_spi_parents, 0x944,
++					0, 4,	/* M */
++					8, 2,	/* N */
++					24, 3,	/* mux */
++					BIT(31),/* gate */
++					0);
++
++static SUNXI_CCU_GATE(bus_spi0_clk, "bus-spi0", "ahb3", 0x96c, BIT(0), 0);
++static SUNXI_CCU_GATE(bus_spi1_clk, "bus-spi1", "ahb3", 0x96c, BIT(1), 0);
++
++static SUNXI_CCU_GATE(emac_25m_clk, "emac-25m", "ahb3", 0x970,
++		      BIT(31) | BIT(30), 0);
++
++static SUNXI_CCU_GATE(bus_emac0_clk, "bus-emac0", "ahb3", 0x97c, BIT(0), 0);
++static SUNXI_CCU_GATE(bus_emac1_clk, "bus-emac1", "ahb3", 0x97c, BIT(1), 0);
++
++static const char * const ts_parents[] = { "osc24M", "pll-periph0" };
++static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_parents, 0x9b0,
++					0, 4,	/* M */
++					8, 2,	/* N */
++					24, 1,	/* mux */
++					BIT(31),/* gate */
++					0);
++
++static SUNXI_CCU_GATE(bus_ts_clk, "bus-ts", "ahb3", 0x9bc, BIT(0), 0);
++
++static SUNXI_CCU_GATE(bus_ths_clk, "bus-ths", "apb1", 0x9fc, BIT(0), 0);
++
++static const char * const audio_parents[] = { "pll-audio-1x", "pll-audio-2x",
++					      "pll-audio-4x", "pll-audio-hs" };
++static struct ccu_div spdif_clk = {
++	.enable		= BIT(31),
++	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
++	.mux		= _SUNXI_CCU_MUX(24, 2),
++	.common		= {
++		.reg		= 0xa20,
++		.hw.init	= CLK_HW_INIT_PARENTS("spdif",
++						      audio_parents,
++						      &ccu_div_ops,
++						      0),
++	},
++};
++
++static SUNXI_CCU_GATE(bus_spdif_clk, "bus-spdif", "apb1", 0xa2c, BIT(0), 0);
++
++static struct ccu_div dmic_clk = {
++	.enable		= BIT(31),
++	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
++	.mux		= _SUNXI_CCU_MUX(24, 2),
++	.common		= {
++		.reg		= 0xa40,
++		.hw.init	= CLK_HW_INIT_PARENTS("dmic",
++						      audio_parents,
++						      &ccu_div_ops,
++						      0),
++	},
++};
++
++static SUNXI_CCU_GATE(bus_dmic_clk, "bus-dmic", "apb1", 0xa4c, BIT(0), 0);
++
++static SUNXI_CCU_M_WITH_MUX_GATE(audio_codec_1x_clk, "audio-codec-1x",
++				 audio_parents, 0xa50,
++				 0, 4,	/* M */
++				 24, 2,	/* mux */
++				 BIT(31),	/* gate */
++				 CLK_SET_RATE_PARENT);
++static SUNXI_CCU_M_WITH_MUX_GATE(audio_codec_4x_clk, "audio-codec-4x",
++				 audio_parents, 0xa54,
++				 0, 4,	/* M */
++				 24, 2,	/* mux */
++				 BIT(31),	/* gate */
++				 CLK_SET_RATE_PARENT);
++
++static SUNXI_CCU_GATE(bus_audio_codec_clk, "bus-audio-codec", "apb1", 0xa5c,
++		BIT(0), 0);
++
++static struct ccu_div audio_hub_clk = {
++	.enable		= BIT(31),
++	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
++	.mux		= _SUNXI_CCU_MUX(24, 2),
++	.common		= {
++		.reg		= 0xa60,
++		.hw.init	= CLK_HW_INIT_PARENTS("audio-hub",
++						      audio_parents,
++						      &ccu_div_ops,
++						      0),
++	},
++};
++
++static SUNXI_CCU_GATE(bus_audio_hub_clk, "bus-audio-hub", "apb1", 0xa6c, BIT(0), 0);
++
++/*
++ * There are OHCI 12M clock source selection bits for 2 USB 2.0 ports.
++ * We will force them to 0 (12M divided from 48M).
++ */
++#define SUN50I_H616_USB0_CLK_REG		0xa70
++#define SUN50I_H616_USB1_CLK_REG		0xa74
++#define SUN50I_H616_USB2_CLK_REG		0xa78
++#define SUN50I_H616_USB3_CLK_REG		0xa7c
++
++static SUNXI_CCU_GATE(usb_ohci0_clk, "usb-ohci0", "osc12M", 0xa70, BIT(31), 0);
++static SUNXI_CCU_GATE(usb_phy0_clk, "usb-phy0", "osc24M", 0xa70, BIT(29), 0);
++
++static SUNXI_CCU_GATE(usb_ohci1_clk, "usb-ohci1", "osc12M", 0xa74, BIT(31), 0);
++static SUNXI_CCU_GATE(usb_phy1_clk, "usb-phy1", "osc24M", 0xa74, BIT(29), 0);
++
++static SUNXI_CCU_GATE(usb_ohci2_clk, "usb-ohci2", "osc12M", 0xa78, BIT(31), 0);
++static SUNXI_CCU_GATE(usb_phy2_clk, "usb-phy2", "osc24M", 0xa78, BIT(29), 0);
++
++static SUNXI_CCU_GATE(usb_ohci3_clk, "usb-ohci3", "osc12M", 0xa7c, BIT(31), 0);
++static SUNXI_CCU_GATE(usb_phy3_clk, "usb-phy3", "osc12M", 0xa7c, BIT(29), 0);
++
++static SUNXI_CCU_GATE(bus_ohci0_clk, "bus-ohci0", "ahb3", 0xa8c, BIT(0), 0);
++static SUNXI_CCU_GATE(bus_ohci1_clk, "bus-ohci1", "ahb3", 0xa8c, BIT(1), 0);
++static SUNXI_CCU_GATE(bus_ohci2_clk, "bus-ohci2", "ahb3", 0xa8c, BIT(2), 0);
++static SUNXI_CCU_GATE(bus_ohci3_clk, "bus-ohci3", "ahb3", 0xa8c, BIT(3), 0);
++static SUNXI_CCU_GATE(bus_ehci0_clk, "bus-ehci0", "ahb3", 0xa8c, BIT(4), 0);
++static SUNXI_CCU_GATE(bus_ehci1_clk, "bus-ehci1", "ahb3", 0xa8c, BIT(5), 0);
++static SUNXI_CCU_GATE(bus_ehci2_clk, "bus-ehci2", "ahb3", 0xa8c, BIT(6), 0);
++static SUNXI_CCU_GATE(bus_ehci3_clk, "bus-ehci3", "ahb3", 0xa8c, BIT(7), 0);
++static SUNXI_CCU_GATE(bus_otg_clk, "bus-otg", "ahb3", 0xa8c, BIT(8), 0);
++
++static SUNXI_CCU_GATE(bus_keyadc_clk, "bus-keyadc", "apb1", 0xa9c, BIT(0), 0);
++
++static struct clk_fixed_factor pll_periph0_4x_clk;
++
++static const char * const hdmi_parents[] = { "pll-video0", "pll-video0-4x",
++					     "pll-video2", "pll-video2-4x" };
++static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents, 0xb00,
++				 0, 4,		/* M */
++				 24, 2,		/* mux */
++				 BIT(31),	/* gate */
++				 0);
++
++static SUNXI_CCU_GATE(hdmi_slow_clk, "hdmi-slow", "osc24M", 0xb04, BIT(31), 0);
++
++static const char * const hdmi_cec_parents[] = { "osc32k", "pll-periph0-2x" };
++static const struct ccu_mux_fixed_prediv hdmi_cec_predivs[] = {
++	{ .index = 1, .div = 36621 },
++};
++
++#define SUN50I_H616_HDMI_CEC_CLK_REG		0xb10
++static struct ccu_mux hdmi_cec_clk = {
++	.enable		= BIT(31),
++
++	.mux		= {
++		.shift	= 24,
++		.width	= 2,
++
++		.fixed_predivs	= hdmi_cec_predivs,
++		.n_predivs	= ARRAY_SIZE(hdmi_cec_predivs),
++	},
++
++	.common		= {
++		.reg		= 0xb10,
++		.features	= CCU_FEATURE_VARIABLE_PREDIV,
++		.hw.init	= CLK_HW_INIT_PARENTS("hdmi-cec",
++						      hdmi_cec_parents,
++						      &ccu_mux_ops,
++						      0),
++	},
++};
++
++static SUNXI_CCU_GATE(bus_hdmi_clk, "bus-hdmi", "ahb3", 0xb1c, BIT(0), 0);
++
++static SUNXI_CCU_GATE(bus_tcon_top_clk, "bus-tcon-top", "ahb3",
++		      0xb5c, BIT(0), 0);
++
++static const char * const tcon_tv0_parents[] = { "pll-video0",
++						 "pll-video0-4x",
++						 "pll-video1",
++						 "pll-video1-4x" };
++static SUNXI_CCU_MP_WITH_MUX_GATE(tcon_tv0_clk, "tcon-tv0",
++				  tcon_tv0_parents, 0xb80,
++				  0, 4,		/* M */
++				  8, 2,		/* P */
++				  24, 3,	/* mux */
++				  BIT(31),	/* gate */
++				  CLK_SET_RATE_PARENT);
++
++static SUNXI_CCU_GATE(bus_tcon_tv0_clk, "bus-tcon-tv0", "ahb3",
++		      0xb9c, BIT(0), 0);
++
++static const char * const hdcp_parents[] = { "pll-periph0", "pll-periph1" };
++static SUNXI_CCU_M_WITH_MUX_GATE(hdcp_clk, "hdcp", hdcp_parents, 0xc40,
++				 0, 4,		/* M */
++				 24, 2,		/* mux */
++				 BIT(31),	/* gate */
++				 0);
++
++static SUNXI_CCU_GATE(bus_hdcp_clk, "bus-hdcp", "ahb3", 0xc4c, BIT(0), 0);
++
++/* Fixed factor clocks */
++static CLK_FIXED_FACTOR_FW_NAME(osc12M_clk, "osc12M", "hosc", 2, 1, 0);
++
++static const struct clk_hw *clk_parent_pll_audio[] = {
++	&pll_audio_hs_clk.common.hw
++};
++
++/*
++ * The divider of pll-audio is fixed to 24 for now, so 24576000 and 22579200
++ * rates can be set exactly in conjunction with sigma-delta modulation.
++ */
++static CLK_FIXED_FACTOR_HWS(pll_audio_1x_clk, "pll-audio-1x",
++			    clk_parent_pll_audio,
++			    96, 1, CLK_SET_RATE_PARENT);
++static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
++			    clk_parent_pll_audio,
++			    48, 1, CLK_SET_RATE_PARENT);
++static CLK_FIXED_FACTOR_HWS(pll_audio_4x_clk, "pll-audio-4x",
++			    clk_parent_pll_audio,
++			    24, 1, CLK_SET_RATE_PARENT);
++
++static const struct clk_hw *pll_periph0_parents[] = {
++	&pll_periph0_clk.common.hw
++};
++static CLK_FIXED_FACTOR_HWS(pll_periph0_4x_clk, "pll-periph0-4x",
++			    pll_periph0_parents,
++			    1, 4, 0);
++static CLK_FIXED_FACTOR_HWS(pll_periph0_2x_clk, "pll-periph0-2x",
++			    pll_periph0_parents,
++			    1, 2, 0);
++
++static const struct clk_hw *pll_periph1_parents[] = {
++	&pll_periph1_clk.common.hw
++};
++static CLK_FIXED_FACTOR_HWS(pll_periph1_4x_clk, "pll-periph1-4x",
++			    pll_periph1_parents,
++			    1, 4, 0);
++static CLK_FIXED_FACTOR_HWS(pll_periph1_2x_clk, "pll-periph1-2x",
++			    pll_periph1_parents,
++			    1, 2, 0);
++
++static CLK_FIXED_FACTOR_HW(pll_video0_4x_clk, "pll-video0-4x",
++			   &pll_video0_clk.common.hw,
++			   1, 4, CLK_SET_RATE_PARENT);
++static CLK_FIXED_FACTOR_HW(pll_video1_4x_clk, "pll-video1-4x",
++			   &pll_video1_clk.common.hw,
++			   1, 4, CLK_SET_RATE_PARENT);
++static CLK_FIXED_FACTOR_HW(pll_video2_4x_clk, "pll-video2-4x",
++			   &pll_video2_clk.common.hw,
++			   1, 4, CLK_SET_RATE_PARENT);
++
++static struct ccu_common *sun50i_h616_ccu_clks[] = {
++	&pll_cpux_clk.common,
++	&pll_ddr0_clk.common,
++	&pll_ddr1_clk.common,
++	&pll_periph0_clk.common,
++	&pll_periph1_clk.common,
++	&pll_gpu_clk.common,
++	&pll_video0_clk.common,
++	&pll_video1_clk.common,
++	&pll_video2_clk.common,
++	&pll_ve_clk.common,
++	&pll_de_clk.common,
++	&pll_audio_hs_clk.common,
++	&cpux_clk.common,
++	&axi_clk.common,
++	&cpux_apb_clk.common,
++	&psi_ahb1_ahb2_clk.common,
++	&ahb3_clk.common,
++	&apb1_clk.common,
++	&apb2_clk.common,
++	&mbus_clk.common,
++	&de_clk.common,
++	&bus_de_clk.common,
++	&deinterlace_clk.common,
++	&bus_deinterlace_clk.common,
++	&g2d_clk.common,
++	&bus_g2d_clk.common,
++	&gpu0_clk.common,
++	&bus_gpu_clk.common,
++	&gpu1_clk.common,
++	&ce_clk.common,
++	&bus_ce_clk.common,
++	&ve_clk.common,
++	&bus_ve_clk.common,
++	&bus_dma_clk.common,
++	&bus_hstimer_clk.common,
++	&avs_clk.common,
++	&bus_dbg_clk.common,
++	&bus_psi_clk.common,
++	&bus_pwm_clk.common,
++	&bus_iommu_clk.common,
++	&dram_clk.common,
++	&mbus_dma_clk.common,
++	&mbus_ve_clk.common,
++	&mbus_ce_clk.common,
++	&mbus_ts_clk.common,
++	&mbus_nand_clk.common,
++	&mbus_g2d_clk.common,
++	&bus_dram_clk.common,
++	&nand0_clk.common,
++	&nand1_clk.common,
++	&bus_nand_clk.common,
++	&mmc0_clk.common,
++	&mmc1_clk.common,
++	&mmc2_clk.common,
++	&bus_mmc0_clk.common,
++	&bus_mmc1_clk.common,
++	&bus_mmc2_clk.common,
++	&bus_uart0_clk.common,
++	&bus_uart1_clk.common,
++	&bus_uart2_clk.common,
++	&bus_uart3_clk.common,
++	&bus_uart4_clk.common,
++	&bus_uart5_clk.common,
++	&bus_i2c0_clk.common,
++	&bus_i2c1_clk.common,
++	&bus_i2c2_clk.common,
++	&bus_i2c3_clk.common,
++	&bus_i2c4_clk.common,
++	&spi0_clk.common,
++	&spi1_clk.common,
++	&bus_spi0_clk.common,
++	&bus_spi1_clk.common,
++	&emac_25m_clk.common,
++	&bus_emac0_clk.common,
++	&bus_emac1_clk.common,
++	&ts_clk.common,
++	&bus_ts_clk.common,
++	&bus_ths_clk.common,
++	&spdif_clk.common,
++	&bus_spdif_clk.common,
++	&dmic_clk.common,
++	&bus_dmic_clk.common,
++	&audio_codec_1x_clk.common,
++	&audio_codec_4x_clk.common,
++	&bus_audio_codec_clk.common,
++	&audio_hub_clk.common,
++	&bus_audio_hub_clk.common,
++	&usb_ohci0_clk.common,
++	&usb_phy0_clk.common,
++	&usb_ohci1_clk.common,
++	&usb_phy1_clk.common,
++	&usb_ohci2_clk.common,
++	&usb_phy2_clk.common,
++	&usb_ohci3_clk.common,
++	&usb_phy3_clk.common,
++	&bus_ohci0_clk.common,
++	&bus_ohci1_clk.common,
++	&bus_ohci2_clk.common,
++	&bus_ohci3_clk.common,
++	&bus_ehci0_clk.common,
++	&bus_ehci1_clk.common,
++	&bus_ehci2_clk.common,
++	&bus_ehci3_clk.common,
++	&bus_otg_clk.common,
++	&bus_keyadc_clk.common,
++	&hdmi_clk.common,
++	&hdmi_slow_clk.common,
++	&hdmi_cec_clk.common,
++	&bus_hdmi_clk.common,
++	&bus_tcon_top_clk.common,
++	&tcon_tv0_clk.common,
++	&bus_tcon_tv0_clk.common,
++	&hdcp_clk.common,
++	&bus_hdcp_clk.common,
++};
++
++static struct clk_hw_onecell_data sun50i_h616_hw_clks = {
++	.hws	= {
++		[CLK_OSC12M]		= &osc12M_clk.hw,
++		[CLK_PLL_CPUX]		= &pll_cpux_clk.common.hw,
++		[CLK_PLL_DDR0]		= &pll_ddr0_clk.common.hw,
++		[CLK_PLL_DDR1]		= &pll_ddr1_clk.common.hw,
++		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
++		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
++		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.hw,
++		[CLK_PLL_PERIPH1]	= &pll_periph1_clk.common.hw,
++		[CLK_PLL_PERIPH1_2X]	= &pll_periph1_2x_clk.hw,
++		[CLK_PLL_PERIPH1_4X]	= &pll_periph1_4x_clk.hw,
++		[CLK_PLL_GPU]		= &pll_gpu_clk.common.hw,
++		[CLK_PLL_VIDEO0]	= &pll_video0_clk.common.hw,
++		[CLK_PLL_VIDEO0_4X]	= &pll_video0_4x_clk.hw,
++		[CLK_PLL_VIDEO1]	= &pll_video1_clk.common.hw,
++		[CLK_PLL_VIDEO1_4X]	= &pll_video1_4x_clk.hw,
++		[CLK_PLL_VIDEO2]	= &pll_video2_clk.common.hw,
++		[CLK_PLL_VIDEO2_4X]	= &pll_video2_4x_clk.hw,
++		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
++		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
++		[CLK_PLL_AUDIO_HS]	= &pll_audio_hs_clk.common.hw,
++		[CLK_PLL_AUDIO_1X]	= &pll_audio_1x_clk.hw,
++		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
++		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
++		[CLK_CPUX]		= &cpux_clk.common.hw,
++		[CLK_AXI]		= &axi_clk.common.hw,
++		[CLK_CPUX_APB]		= &cpux_apb_clk.common.hw,
++		[CLK_PSI_AHB1_AHB2]	= &psi_ahb1_ahb2_clk.common.hw,
++		[CLK_AHB3]		= &ahb3_clk.common.hw,
++		[CLK_APB1]		= &apb1_clk.common.hw,
++		[CLK_APB2]		= &apb2_clk.common.hw,
++		[CLK_MBUS]		= &mbus_clk.common.hw,
++		[CLK_DE]		= &de_clk.common.hw,
++		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
++		[CLK_DEINTERLACE]	= &deinterlace_clk.common.hw,
++		[CLK_BUS_DEINTERLACE]	= &bus_deinterlace_clk.common.hw,
++		[CLK_G2D]		= &g2d_clk.common.hw,
++		[CLK_BUS_G2D]		= &bus_g2d_clk.common.hw,
++		[CLK_GPU0]		= &gpu0_clk.common.hw,
++		[CLK_BUS_GPU]		= &bus_gpu_clk.common.hw,
++		[CLK_GPU1]		= &gpu1_clk.common.hw,
++		[CLK_CE]		= &ce_clk.common.hw,
++		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
++		[CLK_VE]		= &ve_clk.common.hw,
++		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
++		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
++		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
++		[CLK_AVS]		= &avs_clk.common.hw,
++		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
++		[CLK_BUS_PSI]		= &bus_psi_clk.common.hw,
++		[CLK_BUS_PWM]		= &bus_pwm_clk.common.hw,
++		[CLK_BUS_IOMMU]		= &bus_iommu_clk.common.hw,
++		[CLK_DRAM]		= &dram_clk.common.hw,
++		[CLK_MBUS_DMA]		= &mbus_dma_clk.common.hw,
++		[CLK_MBUS_VE]		= &mbus_ve_clk.common.hw,
++		[CLK_MBUS_CE]		= &mbus_ce_clk.common.hw,
++		[CLK_MBUS_TS]		= &mbus_ts_clk.common.hw,
++		[CLK_MBUS_NAND]		= &mbus_nand_clk.common.hw,
++		[CLK_MBUS_G2D]		= &mbus_g2d_clk.common.hw,
++		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
++		[CLK_NAND0]		= &nand0_clk.common.hw,
++		[CLK_NAND1]		= &nand1_clk.common.hw,
++		[CLK_BUS_NAND]		= &bus_nand_clk.common.hw,
++		[CLK_MMC0]		= &mmc0_clk.common.hw,
++		[CLK_MMC1]		= &mmc1_clk.common.hw,
++		[CLK_MMC2]		= &mmc2_clk.common.hw,
++		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
++		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
++		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
++		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
++		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
++		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
++		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
++		[CLK_BUS_UART4]		= &bus_uart4_clk.common.hw,
++		[CLK_BUS_UART5]		= &bus_uart5_clk.common.hw,
++		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
++		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
++		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
++		[CLK_BUS_I2C3]		= &bus_i2c3_clk.common.hw,
++		[CLK_BUS_I2C4]		= &bus_i2c4_clk.common.hw,
++		[CLK_SPI0]		= &spi0_clk.common.hw,
++		[CLK_SPI1]		= &spi1_clk.common.hw,
++		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
++		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
++		[CLK_EMAC_25M]		= &emac_25m_clk.common.hw,
++		[CLK_BUS_EMAC0]		= &bus_emac0_clk.common.hw,
++		[CLK_BUS_EMAC1]		= &bus_emac1_clk.common.hw,
++		[CLK_TS]		= &ts_clk.common.hw,
++		[CLK_BUS_TS]		= &bus_ts_clk.common.hw,
++		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
++		[CLK_SPDIF]		= &spdif_clk.common.hw,
++		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
++		[CLK_DMIC]		= &dmic_clk.common.hw,
++		[CLK_BUS_DMIC]		= &bus_dmic_clk.common.hw,
++		[CLK_AUDIO_CODEC_1X]	= &audio_codec_1x_clk.common.hw,
++		[CLK_AUDIO_CODEC_4X]	= &audio_codec_4x_clk.common.hw,
++		[CLK_BUS_AUDIO_CODEC]	= &bus_audio_codec_clk.common.hw,
++		[CLK_AUDIO_HUB]		= &audio_hub_clk.common.hw,
++		[CLK_BUS_AUDIO_HUB]	= &bus_audio_hub_clk.common.hw,
++		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
++		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
++		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
++		[CLK_USB_PHY1]		= &usb_phy1_clk.common.hw,
++		[CLK_USB_OHCI2]		= &usb_ohci2_clk.common.hw,
++		[CLK_USB_PHY2]		= &usb_phy2_clk.common.hw,
++		[CLK_USB_OHCI3]		= &usb_ohci3_clk.common.hw,
++		[CLK_USB_PHY3]		= &usb_phy3_clk.common.hw,
++		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
++		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
++		[CLK_BUS_OHCI2]		= &bus_ohci2_clk.common.hw,
++		[CLK_BUS_OHCI3]		= &bus_ohci3_clk.common.hw,
++		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
++		[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common.hw,
++		[CLK_BUS_EHCI2]		= &bus_ehci2_clk.common.hw,
++		[CLK_BUS_EHCI3]		= &bus_ehci3_clk.common.hw,
++		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
++		[CLK_BUS_KEYADC]	= &bus_keyadc_clk.common.hw,
++		[CLK_HDMI]		= &hdmi_clk.common.hw,
++		[CLK_HDMI_SLOW]		= &hdmi_slow_clk.common.hw,
++		[CLK_HDMI_CEC]		= &hdmi_cec_clk.common.hw,
++		[CLK_BUS_HDMI]		= &bus_hdmi_clk.common.hw,
++		[CLK_BUS_TCON_TOP]	= &bus_tcon_top_clk.common.hw,
++		[CLK_TCON_TV0]		= &tcon_tv0_clk.common.hw,
++		[CLK_BUS_TCON_TV0]	= &bus_tcon_tv0_clk.common.hw,
++		[CLK_HDCP]		= &hdcp_clk.common.hw,
++		[CLK_BUS_HDCP]		= &bus_hdcp_clk.common.hw,
++	},
++	.num = CLK_NUMBER,
++};
++
++static struct ccu_reset_map sun50i_h616_ccu_resets[] = {
++	[RST_MBUS]		= { 0x540, BIT(30) },
++
++	[RST_BUS_DE]		= { 0x60c, BIT(16) },
++	[RST_BUS_DEINTERLACE]	= { 0x62c, BIT(16) },
++	[RST_BUS_GPU]		= { 0x67c, BIT(16) },
++	[RST_BUS_CE]		= { 0x68c, BIT(16) },
++	[RST_BUS_VE]		= { 0x69c, BIT(16) },
++	[RST_BUS_DMA]		= { 0x70c, BIT(16) },
++	[RST_BUS_HSTIMER]	= { 0x73c, BIT(16) },
++	[RST_BUS_DBG]		= { 0x78c, BIT(16) },
++	[RST_BUS_PSI]		= { 0x79c, BIT(16) },
++	[RST_BUS_PWM]		= { 0x7ac, BIT(16) },
++	[RST_BUS_IOMMU]		= { 0x7bc, BIT(16) },
++	[RST_BUS_DRAM]		= { 0x80c, BIT(16) },
++	[RST_BUS_NAND]		= { 0x82c, BIT(16) },
++	[RST_BUS_MMC0]		= { 0x84c, BIT(16) },
++	[RST_BUS_MMC1]		= { 0x84c, BIT(17) },
++	[RST_BUS_MMC2]		= { 0x84c, BIT(18) },
++	[RST_BUS_UART0]		= { 0x90c, BIT(16) },
++	[RST_BUS_UART1]		= { 0x90c, BIT(17) },
++	[RST_BUS_UART2]		= { 0x90c, BIT(18) },
++	[RST_BUS_UART3]		= { 0x90c, BIT(19) },
++	[RST_BUS_UART4]		= { 0x90c, BIT(20) },
++	[RST_BUS_UART5]		= { 0x90c, BIT(21) },
++	[RST_BUS_I2C0]		= { 0x91c, BIT(16) },
++	[RST_BUS_I2C1]		= { 0x91c, BIT(17) },
++	[RST_BUS_I2C2]		= { 0x91c, BIT(18) },
++	[RST_BUS_I2C3]		= { 0x91c, BIT(19) },
++	[RST_BUS_I2C4]		= { 0x91c, BIT(20) },
++	[RST_BUS_SPI0]		= { 0x96c, BIT(16) },
++	[RST_BUS_SPI1]		= { 0x96c, BIT(17) },
++	[RST_BUS_EMAC0]		= { 0x97c, BIT(16) },
++	[RST_BUS_EMAC1]		= { 0x97c, BIT(17) },
++	[RST_BUS_TS]		= { 0x9bc, BIT(16) },
++	[RST_BUS_THS]		= { 0x9fc, BIT(16) },
++	[RST_BUS_SPDIF]		= { 0xa2c, BIT(16) },
++	[RST_BUS_DMIC]		= { 0xa4c, BIT(16) },
++	[RST_BUS_AUDIO_CODEC]	= { 0xa5c, BIT(16) },
++	[RST_BUS_AUDIO_HUB]	= { 0xa6c, BIT(16) },
++
++	[RST_USB_PHY0]		= { 0xa70, BIT(30) },
++	[RST_USB_PHY1]		= { 0xa74, BIT(30) },
++	[RST_USB_PHY2]		= { 0xa78, BIT(30) },
++	[RST_USB_PHY3]		= { 0xa7c, BIT(30) },
++
++	[RST_BUS_OHCI0]		= { 0xa8c, BIT(16) },
++	[RST_BUS_OHCI1]		= { 0xa8c, BIT(17) },
++	[RST_BUS_OHCI2]		= { 0xa8c, BIT(18) },
++	[RST_BUS_OHCI3]		= { 0xa8c, BIT(19) },
++	[RST_BUS_EHCI0]		= { 0xa8c, BIT(20) },
++	[RST_BUS_EHCI1]		= { 0xa8c, BIT(21) },
++	[RST_BUS_EHCI2]		= { 0xa8c, BIT(22) },
++	[RST_BUS_EHCI3]		= { 0xa8c, BIT(23) },
++	[RST_BUS_OTG]		= { 0xa8c, BIT(24) },
++	[RST_BUS_KEYADC]	= { 0xa9c, BIT(16) },
++
++	[RST_BUS_HDMI]		= { 0xb1c, BIT(16) },
++	[RST_BUS_HDMI_SUB]	= { 0xb1c, BIT(17) },
++	[RST_BUS_TCON_TOP]	= { 0xb5c, BIT(16) },
++	[RST_BUS_TCON_TV0]	= { 0xb9c, BIT(16) },
++	[RST_BUS_HDCP]		= { 0xc4c, BIT(16) },
++};
++
++static const struct sunxi_ccu_desc sun50i_h616_ccu_desc = {
++	.ccu_clks	= sun50i_h616_ccu_clks,
++	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_ccu_clks),
++
++	.hw_clks	= &sun50i_h616_hw_clks,
++
++	.resets		= sun50i_h616_ccu_resets,
++	.num_resets	= ARRAY_SIZE(sun50i_h616_ccu_resets),
++};
++
++static const u32 pll_regs[] = {
++	SUN50I_H616_PLL_CPUX_REG,
++	SUN50I_H616_PLL_DDR0_REG,
++	SUN50I_H616_PLL_DDR1_REG,
++	SUN50I_H616_PLL_PERIPH0_REG,
++	SUN50I_H616_PLL_PERIPH1_REG,
++	SUN50I_H616_PLL_GPU_REG,
++	SUN50I_H616_PLL_VIDEO0_REG,
++	SUN50I_H616_PLL_VIDEO1_REG,
++	SUN50I_H616_PLL_VIDEO2_REG,
++	SUN50I_H616_PLL_VE_REG,
++	SUN50I_H616_PLL_DE_REG,
++	SUN50I_H616_PLL_AUDIO_REG,
++};
++
++static const u32 pll_video_regs[] = {
++	SUN50I_H616_PLL_VIDEO0_REG,
++	SUN50I_H616_PLL_VIDEO1_REG,
++	SUN50I_H616_PLL_VIDEO2_REG,
++};
++
++static const u32 usb2_clk_regs[] = {
++	SUN50I_H616_USB0_CLK_REG,
++	SUN50I_H616_USB1_CLK_REG,
++	SUN50I_H616_USB2_CLK_REG,
++	SUN50I_H616_USB3_CLK_REG,
++};
++
++static int sun50i_h616_ccu_probe(struct platform_device *pdev)
++{
++	struct resource *res;
++	void __iomem *reg;
++	u32 val;
++	int i;
++
++	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
++	reg = devm_ioremap_resource(&pdev->dev, res);
++	if (IS_ERR(reg))
++		return PTR_ERR(reg);
++
++	/* Enable the lock bits on all PLLs */
++	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
++		val = readl(reg + pll_regs[i]);
++		val |= BIT(29);
++		writel(val, reg + pll_regs[i]);
++	}
++
++	/*
++	 * Force the output divider of video PLLs to 0.
++	 *
++	 * See the comment before pll-video0 definition for the reason.
++	 */
++	for (i = 0; i < ARRAY_SIZE(pll_video_regs); i++) {
++		val = readl(reg + pll_video_regs[i]);
++		val &= ~BIT(0);
++		writel(val, reg + pll_video_regs[i]);
++	}
++
++	/*
++	 * Force OHCI 12M clock sources to 00 (12MHz divided from 48MHz)
++	 *
++	 * This clock mux is still mysterious, and the code just enforces
++	 * it to have a valid clock parent.
++	 */
++	for (i = 0; i < ARRAY_SIZE(usb2_clk_regs); i++) {
++		val = readl(reg + usb2_clk_regs[i]);
++		val &= ~GENMASK(25, 24);
++		writel (val, reg + usb2_clk_regs[i]);
++	}
++
++	/*
++	 * Force the post-divider of pll-audio to 12 and the output divider
++	 * of it to 2, so 24576000 and 22579200 rates can be set exactly.
++	 */
++	val = readl(reg + SUN50I_H616_PLL_AUDIO_REG);
++	val &= ~(GENMASK(21, 16) | BIT(0));
++	writel(val | (11 << 16) | BIT(0), reg + SUN50I_H616_PLL_AUDIO_REG);
++
++	/*
++	 * First clock parent (osc32K) is unusable for CEC. But since there
++	 * is no good way to force parent switch (both run with same frequency),
++	 * just set second clock parent here.
++	 */
++	val = readl(reg + SUN50I_H616_HDMI_CEC_CLK_REG);
++	val |= BIT(24);
++	writel(val, reg + SUN50I_H616_HDMI_CEC_CLK_REG);
++
++	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_h616_ccu_desc);
++}
++
++static const struct of_device_id sun50i_h616_ccu_ids[] = {
++	{ .compatible = "allwinner,sun50i-h616-ccu",
++		.data = &sun50i_h616_ccu_desc },
++	{ }
++};
++
++static struct platform_driver sun50i_h616_ccu_driver = {
++	.probe	= sun50i_h616_ccu_probe,
++	.driver	= {
++		.name	= "sun50i-h616-ccu",
++		.of_match_table	= sun50i_h616_ccu_ids,
++	},
++};
++builtin_platform_driver(sun50i_h616_ccu_driver);
+diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
+new file mode 100644
+index 000000000000..da8f0b1206f9
+--- /dev/null
++++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
+@@ -0,0 +1,58 @@ 
++/* SPDX-License-Identifier: GPL-2.0 */
++/*
++ * Copyright 2020 Arm Ltd.
++ */
++
++#ifndef _CCU_SUN50I_H616_H_
++#define _CCU_SUN50I_H616_H_
++
++#include <dt-bindings/clock/sun50i-h616-ccu.h>
++#include <dt-bindings/reset/sun50i-h616-ccu.h>
++
++#define CLK_OSC12M		0
++#define CLK_PLL_CPUX		1
++#define CLK_PLL_DDR0		2
++#define CLK_PLL_DDR1		3
++
++/* PLL_PERIPH0 exported for PRCM */
++
++#define CLK_PLL_PERIPH0_2X	5
++#define CLK_PLL_PERIPH0_4X	6
++#define CLK_PLL_PERIPH1		7
++#define CLK_PLL_PERIPH1_2X	8
++#define CLK_PLL_PERIPH1_4X	9
++#define CLK_PLL_GPU		10
++#define CLK_PLL_VIDEO0		11
++#define CLK_PLL_VIDEO0_4X	12
++#define CLK_PLL_VIDEO1		13
++#define CLK_PLL_VIDEO1_4X	14
++#define CLK_PLL_VIDEO2		15
++#define CLK_PLL_VIDEO2_4X	16
++#define CLK_PLL_VE		17
++#define CLK_PLL_DE		18
++#define CLK_PLL_AUDIO_HS	19
++#define CLK_PLL_AUDIO_1X	20
++#define CLK_PLL_AUDIO_2X	21
++#define CLK_PLL_AUDIO_4X	22
++
++/* CPUX clock exported for DVFS */
++
++#define CLK_AXI			24
++#define CLK_CPUX_APB		25
++#define CLK_PSI_AHB1_AHB2	26
++#define CLK_AHB3		27
++
++/* APB1 clock exported for PIO */
++
++#define CLK_APB2		29
++#define CLK_MBUS		30
++
++/* All module clocks and bus gates are exported except DRAM */
++
++#define CLK_DRAM		51
++
++#define CLK_BUS_DRAM		58
++
++#define CLK_NUMBER		(CLK_BUS_HDCP + 1)
++
++#endif /* _CCU_SUN50I_H616_H_ */
+diff --git a/include/dt-bindings/clock/sun50i-h616-ccu.h b/include/dt-bindings/clock/sun50i-h616-ccu.h
+new file mode 100644
+index 000000000000..a9cc8844e3a9
+--- /dev/null
++++ b/include/dt-bindings/clock/sun50i-h616-ccu.h
+@@ -0,0 +1,110 @@ 
++// SPDX-License-Identifier: (GPL-2.0+ or MIT)
++/*
++ * Copyright (C) 2020 Arm Ltd.
++ */
++
++#ifndef _DT_BINDINGS_CLK_SUN50I_H616_H_
++#define _DT_BINDINGS_CLK_SUN50I_H616_H_
++
++#define CLK_PLL_PERIPH0		4
++
++#define CLK_CPUX		23
++
++#define CLK_APB1		28
++
++#define CLK_DE			31
++#define CLK_BUS_DE		32
++#define CLK_DEINTERLACE		33
++#define CLK_BUS_DEINTERLACE	34
++#define CLK_G2D			35
++#define CLK_BUS_G2D		36
++#define CLK_GPU0		37
++#define CLK_BUS_GPU		38
++#define CLK_GPU1		39
++#define CLK_CE			40
++#define CLK_BUS_CE		41
++#define CLK_VE			42
++#define CLK_BUS_VE		43
++#define CLK_BUS_DMA		44
++#define CLK_BUS_HSTIMER		45
++#define CLK_AVS			46
++#define CLK_BUS_DBG		47
++#define CLK_BUS_PSI		48
++#define CLK_BUS_PWM		49
++#define CLK_BUS_IOMMU		50
++
++#define CLK_MBUS_DMA		52
++#define CLK_MBUS_VE		53
++#define CLK_MBUS_CE		54
++#define CLK_MBUS_TS		55
++#define CLK_MBUS_NAND		56
++#define CLK_MBUS_G2D		57
++
++#define CLK_NAND0		59
++#define CLK_NAND1		60
++#define CLK_BUS_NAND		61
++#define CLK_MMC0		62
++#define CLK_MMC1		63
++#define CLK_MMC2		64
++#define CLK_BUS_MMC0		65
++#define CLK_BUS_MMC1		66
++#define CLK_BUS_MMC2		67
++#define CLK_BUS_UART0		68
++#define CLK_BUS_UART1		69
++#define CLK_BUS_UART2		70
++#define CLK_BUS_UART3		71
++#define CLK_BUS_UART4		72
++#define CLK_BUS_UART5		73
++#define CLK_BUS_I2C0		74
++#define CLK_BUS_I2C1		75
++#define CLK_BUS_I2C2		76
++#define CLK_BUS_I2C3		77
++#define CLK_BUS_I2C4		78
++#define CLK_SPI0		79
++#define CLK_SPI1		80
++#define CLK_BUS_SPI0		81
++#define CLK_BUS_SPI1		82
++#define CLK_EMAC_25M		83
++#define CLK_BUS_EMAC0		84
++#define CLK_BUS_EMAC1		85
++#define CLK_TS			86
++#define CLK_BUS_TS		87
++#define CLK_BUS_THS		88
++#define CLK_SPDIF		89
++#define CLK_BUS_SPDIF		90
++#define CLK_DMIC		91
++#define CLK_BUS_DMIC		92
++#define CLK_AUDIO_CODEC_1X	93
++#define CLK_AUDIO_CODEC_4X	94
++#define CLK_BUS_AUDIO_CODEC	95
++#define CLK_AUDIO_HUB		96
++#define CLK_BUS_AUDIO_HUB	97
++#define CLK_USB_OHCI0		98
++#define CLK_USB_PHY0		99
++#define CLK_USB_OHCI1		100
++#define CLK_USB_PHY1		101
++#define CLK_USB_OHCI2		102
++#define CLK_USB_PHY2		103
++#define CLK_USB_OHCI3		104
++#define CLK_USB_PHY3		105
++#define CLK_BUS_OHCI0		106
++#define CLK_BUS_OHCI1		107
++#define CLK_BUS_OHCI2		108
++#define CLK_BUS_OHCI3		109
++#define CLK_BUS_EHCI0		110
++#define CLK_BUS_EHCI1		111
++#define CLK_BUS_EHCI2		112
++#define CLK_BUS_EHCI3		113
++#define CLK_BUS_OTG		114
++#define CLK_BUS_KEYADC		115
++#define CLK_HDMI		116
++#define CLK_HDMI_SLOW		117
++#define CLK_HDMI_CEC		118
++#define CLK_BUS_HDMI		119
++#define CLK_BUS_TCON_TOP	120
++#define CLK_TCON_TV0		121
++#define CLK_BUS_TCON_TV0	122
++#define CLK_HDCP		123
++#define CLK_BUS_HDCP		124
++
++#endif /* _DT_BINDINGS_CLK_SUN50I_H616_H_ */
+diff --git a/include/dt-bindings/reset/sun50i-h616-ccu.h b/include/dt-bindings/reset/sun50i-h616-ccu.h
+new file mode 100644
+index 000000000000..1c992cfbbbab
+--- /dev/null
++++ b/include/dt-bindings/reset/sun50i-h616-ccu.h
+@@ -0,0 +1,67 @@ 
++// SPDX-License-Identifier: (GPL-2.0+ or MIT)
++/*
++ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
++ */
++
++#ifndef _DT_BINDINGS_RESET_SUN50I_H616_H_
++#define _DT_BINDINGS_RESET_SUN50I_H616_H_
++
++#define RST_MBUS		0
++#define RST_BUS_DE		1
++#define RST_BUS_DEINTERLACE	2
++#define RST_BUS_GPU		3
++#define RST_BUS_CE		4
++#define RST_BUS_VE		5
++#define RST_BUS_DMA		6
++#define RST_BUS_HSTIMER		7
++#define RST_BUS_DBG		8
++#define RST_BUS_PSI		9
++#define RST_BUS_PWM		10
++#define RST_BUS_IOMMU		11
++#define RST_BUS_DRAM		12
++#define RST_BUS_NAND		13
++#define RST_BUS_MMC0		14
++#define RST_BUS_MMC1		15
++#define RST_BUS_MMC2		16
++#define RST_BUS_UART0		17
++#define RST_BUS_UART1		18
++#define RST_BUS_UART2		19
++#define RST_BUS_UART3		20
++#define RST_BUS_UART4		21
++#define RST_BUS_UART5		22
++#define RST_BUS_I2C0		23
++#define RST_BUS_I2C1		24
++#define RST_BUS_I2C2		25
++#define RST_BUS_I2C3		26
++#define RST_BUS_I2C4		27
++#define RST_BUS_SPI0		28
++#define RST_BUS_SPI1		29
++#define RST_BUS_EMAC0		30
++#define RST_BUS_EMAC1		31
++#define RST_BUS_TS		32
++#define RST_BUS_THS		33
++#define RST_BUS_SPDIF		34
++#define RST_BUS_DMIC		35
++#define RST_BUS_AUDIO_CODEC	36
++#define RST_BUS_AUDIO_HUB	37
++#define RST_USB_PHY0		38
++#define RST_USB_PHY1		39
++#define RST_USB_PHY2		40
++#define RST_USB_PHY3		41
++#define RST_BUS_OHCI0		42
++#define RST_BUS_OHCI1		43
++#define RST_BUS_OHCI2		44
++#define RST_BUS_OHCI3		45
++#define RST_BUS_EHCI0		46
++#define RST_BUS_EHCI1		47
++#define RST_BUS_EHCI2		48
++#define RST_BUS_EHCI3		49
++#define RST_BUS_OTG		50
++#define RST_BUS_HDMI		51
++#define RST_BUS_HDMI_SUB	52
++#define RST_BUS_TCON_TOP	53
++#define RST_BUS_TCON_TV0	54
++#define RST_BUS_HDCP		55
++#define RST_BUS_KEYADC		56
++
++#endif /* _DT_BINDINGS_RESET_SUN50I_H616_H_ */
diff --git a/target/linux/sunxi/patches-5.10/506-add-support-for-A100-mmc-controller.patch b/target/linux/sunxi/patches-5.10/506-add-support-for-A100-mmc-controller.patch
new file mode 100644
index 0000000000000..fd03037553125
--- /dev/null
+++ b/target/linux/sunxi/patches-5.10/506-add-support-for-A100-mmc-controller.patch
@@ -0,0 +1,65 @@
+diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
+index fc62773602ec..1518b64112b7 100644
+@@ -244,6 +244,7 @@
+ 
+ struct sunxi_mmc_cfg {
+ 	u32 idma_des_size_bits;
++	u32 idma_des_shift;
+ 	const struct sunxi_mmc_clk_delay *clk_delays;
+ 
+ 	/* does the IP block support autocalibration? */
+@@ -343,7 +344,7 @@
+ 	/* Enable CEATA support */
+ 	mmc_writel(host, REG_FUNS, SDXC_CEATA_ON);
+ 	/* Set DMA descriptor list base address */
+-	mmc_writel(host, REG_DLBA, host->sg_dma);
++	mmc_writel(host, REG_DLBA, host->sg_dma >> host->cfg->idma_des_shift);
+ 
+ 	rval = mmc_readl(host, REG_GCTRL);
+ 	rval |= SDXC_INTERRUPT_ENABLE_BIT;
+@@ -373,8 +374,10 @@
+ 
+ 		next_desc += sizeof(struct sunxi_idma_des);
+ 		pdes[i].buf_addr_ptr1 =
+-			cpu_to_le32(sg_dma_address(&data->sg[i]));
+-		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc);
++			cpu_to_le32(sg_dma_address(&data->sg[i]) >>
++				    host->cfg->idma_des_shift);
++		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc >>
++						    host->cfg->idma_des_shift);
+ 	}
+ 
+ 	pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
+@@ -1178,6 +1181,23 @@
+ 	.needs_new_timings = true,
+ };
+ 
++static const struct sunxi_mmc_cfg sun50i_a100_cfg = {
++	.idma_des_size_bits = 16,
++	.idma_des_shift = 2,
++	.clk_delays = NULL,
++	.can_calibrate = true,
++	.mask_data0 = true,
++	.needs_new_timings = true,
++};
++
++static const struct sunxi_mmc_cfg sun50i_a100_emmc_cfg = {
++	.idma_des_size_bits = 13,
++	.idma_des_shift = 2,
++	.clk_delays = NULL,
++	.can_calibrate = true,
++	.needs_new_timings = true,
++};
++
+ static const struct of_device_id sunxi_mmc_of_match[] = {
+ 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
+ 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
+@@ -1186,6 +1206,8 @@
+ 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
+ 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
+ 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
++	{ .compatible = "allwinner,sun50i-a100-mmc", .data = &sun50i_a100_cfg },
++	{ .compatible = "allwinner,sun50i-a100-emmc", .data = &sun50i_a100_emmc_cfg },
+ 	{ /* sentinel */ }
+ };
+ MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
diff --git a/target/linux/sunxi/patches-5.10/507-Add-Allwinner-H616-.dtsi-file.patch b/target/linux/sunxi/patches-5.10/507-Add-Allwinner-H616-.dtsi-file.patch
new file mode 100644
index 0000000000000..32bf6471606b1
--- /dev/null
+++ b/target/linux/sunxi/patches-5.10/507-Add-Allwinner-H616-.dtsi-file.patch
@@ -0,0 +1,710 @@
+diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+new file mode 100644
+index 000000000000..dcffbfdcd26b
+--- /dev/null
++++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+@@ -0,0 +1,704 @@ 
++// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
++// Copyright (C) 2020 Arm Ltd.
++// based on the H6 dtsi, which is:
++//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
++
++#include <dt-bindings/interrupt-controller/arm-gic.h>
++#include <dt-bindings/clock/sun50i-h616-ccu.h>
++#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
++#include <dt-bindings/reset/sun50i-h616-ccu.h>
++#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
++
++/ {
++	interrupt-parent = <&gic>;
++	#address-cells = <2>;
++	#size-cells = <2>;
++
++	cpus {
++		#address-cells = <1>;
++		#size-cells = <0>;
++
++		cpu0: cpu@0 {
++			compatible = "arm,cortex-a53";
++			device_type = "cpu";
++			reg = <0>;
++			enable-method = "psci";
++			clocks = <&ccu CLK_CPUX>;
++		};
++
++		cpu1: cpu@1 {
++			compatible = "arm,cortex-a53";
++			device_type = "cpu";
++			reg = <1>;
++			enable-method = "psci";
++			clocks = <&ccu CLK_CPUX>;
++		};
++
++		cpu2: cpu@2 {
++			compatible = "arm,cortex-a53";
++			device_type = "cpu";
++			reg = <2>;
++			enable-method = "psci";
++			clocks = <&ccu CLK_CPUX>;
++		};
++
++		cpu3: cpu@3 {
++			compatible = "arm,cortex-a53";
++			device_type = "cpu";
++			reg = <3>;
++			enable-method = "psci";
++			clocks = <&ccu CLK_CPUX>;
++		};
++	};
++
++	reserved-memory {
++		#address-cells = <2>;
++		#size-cells = <2>;
++		ranges;
++
++		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
++		secmon_reserved: secmon@40000000 {
++			reg = <0x0 0x40000000 0x0 0x80000>;
++			no-map;
++		};
++	};
++
++	osc24M: osc24M_clk {
++		#clock-cells = <0>;
++		compatible = "fixed-clock";
++		clock-frequency = <24000000>;
++		clock-output-names = "osc24M";
++	};
++
++	pmu {
++		compatible = "arm,cortex-a53-pmu";
++		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
++			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
++			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
++			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
++		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
++	};
++
++	psci {
++		compatible = "arm,psci-0.2";
++		method = "smc";
++	};
++
++	timer {
++		compatible = "arm,armv8-timer";
++		arm,no-tick-in-suspend;
++		interrupts = <GIC_PPI 13
++			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
++			     <GIC_PPI 14
++			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
++			     <GIC_PPI 11
++			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
++			     <GIC_PPI 10
++			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
++	};
++
++	soc {
++		compatible = "simple-bus";
++		#address-cells = <1>;
++		#size-cells = <1>;
++		ranges = <0x0 0x0 0x0 0x40000000>;
++
++		syscon: syscon@3000000 {
++			compatible = "allwinner,sun50i-h616-system-control",
++				     "allwinner,sun50i-a64-system-control";
++			reg = <0x03000000 0x1000>;
++			#address-cells = <1>;
++			#size-cells = <1>;
++			ranges;
++
++			sram_c: sram@28000 {
++				compatible = "mmio-sram";
++				reg = <0x00028000 0x30000>;
++				#address-cells = <1>;
++				#size-cells = <1>;
++				ranges = <0 0x00028000 0x30000>;
++			};
++
++			sram_c1: sram@1a00000 {
++				compatible = "mmio-sram";
++				reg = <0x01a00000 0x200000>;
++				#address-cells = <1>;
++				#size-cells = <1>;
++				ranges = <0 0x01a00000 0x200000>;
++
++				ve_sram: sram-section@0 {
++					compatible = "allwinner,sun50i-h616-sram-c1",
++						     "allwinner,sun4i-a10-sram-c1";
++					reg = <0x000000 0x200000>;
++				};
++			};
++		};
++
++		ccu: clock@3001000 {
++			compatible = "allwinner,sun50i-h616-ccu";
++			reg = <0x03001000 0x1000>;
++			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
++			clock-names = "hosc", "losc", "iosc";
++			#clock-cells = <1>;
++			#reset-cells = <1>;
++		};
++
++		watchdog: watchdog@30090a0 {
++			compatible = "allwinner,sun50i-h616-wdt",
++				     "allwinner,sun6i-a31-wdt";
++			reg = <0x030090a0 0x20>;
++			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&osc24M>;
++			status = "disabled";
++		};
++
++		pio: pinctrl@300b000 {
++			compatible = "allwinner,sun50i-h616-pinctrl";
++			reg = <0x0300b000 0x400>;
++			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
++				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
++				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
++				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
++				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
++			clock-names = "apb", "hosc", "losc";
++			gpio-controller;
++			#gpio-cells = <3>;
++			interrupt-controller;
++			#interrupt-cells = <3>;
++
++			ext_rgmii_pins: rgmii-pins {
++				pins = "PI0", "PI1", "PI2", "PI3", "PI4",
++				       "PI5", "PI7", "PI8", "PI9", "PI10",
++				       "PI11", "PI12", "PI13", "PI14", "PI15",
++				       "PI16";
++				function = "emac0";
++				drive-strength = <40>;
++			};
++
++			i2c0_pins: i2c0-pins {
++				pins = "PI6", "PI7";
++				function = "i2c0";
++			};
++
++			i2c3_pins_a: i2c1-pins-a {
++				pins = "PH4", "PH5";
++				function = "i2c3";
++			};
++
++			ir_rx_pin: ir_rx_pin {
++				pins = "PH10";
++				function = "ir_rx";
++			};
++
++			mmc0_pins: mmc0-pins {
++				pins = "PF0", "PF1", "PF2", "PF3",
++				       "PF4", "PF5";
++				function = "mmc0";
++				drive-strength = <30>;
++				bias-pull-up;
++			};
++
++			mmc1_pins: mmc1-pins {
++				pins = "PG0", "PG1", "PG2", "PG3",
++				       "PG4", "PG5";
++				function = "mmc1";
++				drive-strength = <30>;
++				bias-pull-up;
++			};
++
++			mmc2_pins: mmc2-pins {
++				pins = "PC0", "PC1", "PC5", "PC6",
++				       "PC8", "PC9", "PC10", "PC11",
++				       "PC13", "PC14", "PC15", "PC16";
++				function = "mmc2";
++				drive-strength = <30>;
++				bias-pull-up;
++			};
++
++			spi0_pins: spi0-pins {
++				pins = "PC0", "PC2", "PC3", "PC4";
++				function = "spi0";
++			};
++
++			spi1_pins: spi1-pins {
++				pins = "PH6", "PH7", "PH8";
++				function = "spi1";
++			};
++
++			spi1_cs_pin: spi1-cs-pin {
++				pins = "PH5";
++				function = "spi1";
++			};
++
++			uart0_ph_pins: uart0-ph-pins {
++				pins = "PH0", "PH1";
++				function = "uart0";
++			};
++
++			uart1_pins: uart1-pins {
++				pins = "PG6", "PG7";
++				function = "uart1";
++			};
++
++			uart1_rts_cts_pins: uart1-rts-cts-pins {
++				pins = "PG8", "PG9";
++				function = "uart1";
++			};
++		};
++
++		gic: interrupt-controller@3021000 {
++			compatible = "arm,gic-400";
++			reg = <0x03021000 0x1000>,
++			      <0x03022000 0x2000>,
++			      <0x03024000 0x2000>,
++			      <0x03026000 0x2000>;
++			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
++			interrupt-controller;
++			#interrupt-cells = <3>;
++		};
++
++		mmc0: mmc@4020000 {
++			compatible = "allwinner,sun50i-h616-mmc",
++				     "allwinner,sun50i-a100-mmc";
++			reg = <0x04020000 0x1000>;
++			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
++			clock-names = "ahb", "mmc";
++			resets = <&ccu RST_BUS_MMC0>;
++			reset-names = "ahb";
++			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
++			pinctrl-names = "default";
++			pinctrl-0 = <&mmc0_pins>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		mmc1: mmc@4021000 {
++			compatible = "allwinner,sun50i-h616-mmc",
++				     "allwinner,sun50i-a100-mmc";
++			reg = <0x04021000 0x1000>;
++			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
++			clock-names = "ahb", "mmc";
++			resets = <&ccu RST_BUS_MMC1>;
++			reset-names = "ahb";
++			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
++			pinctrl-names = "default";
++			pinctrl-0 = <&mmc1_pins>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		mmc2: mmc@4022000 {
++			compatible = "allwinner,sun50i-h616-emmc",
++				     "allwinner,sun50i-a64-emmc";
++			reg = <0x04022000 0x1000>;
++			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
++			clock-names = "ahb", "mmc";
++			resets = <&ccu RST_BUS_MMC2>;
++			reset-names = "ahb";
++			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
++			pinctrl-names = "default";
++			pinctrl-0 = <&mmc2_pins>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		uart0: serial@5000000 {
++			compatible = "snps,dw-apb-uart";
++			reg = <0x05000000 0x400>;
++			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
++			reg-shift = <2>;
++			reg-io-width = <4>;
++			clocks = <&ccu CLK_BUS_UART0>;
++			resets = <&ccu RST_BUS_UART0>;
++			status = "disabled";
++		};
++
++		uart1: serial@5000400 {
++			compatible = "snps,dw-apb-uart";
++			reg = <0x05000400 0x400>;
++			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
++			reg-shift = <2>;
++			reg-io-width = <4>;
++			clocks = <&ccu CLK_BUS_UART1>;
++			resets = <&ccu RST_BUS_UART1>;
++			status = "disabled";
++		};
++
++		uart2: serial@5000800 {
++			compatible = "snps,dw-apb-uart";
++			reg = <0x05000800 0x400>;
++			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
++			reg-shift = <2>;
++			reg-io-width = <4>;
++			clocks = <&ccu CLK_BUS_UART2>;
++			resets = <&ccu RST_BUS_UART2>;
++			status = "disabled";
++		};
++
++		uart3: serial@5000c00 {
++			compatible = "snps,dw-apb-uart";
++			reg = <0x05000c00 0x400>;
++			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
++			reg-shift = <2>;
++			reg-io-width = <4>;
++			clocks = <&ccu CLK_BUS_UART3>;
++			resets = <&ccu RST_BUS_UART3>;
++			status = "disabled";
++		};
++
++		uart4: serial@5001000 {
++			compatible = "snps,dw-apb-uart";
++			reg = <0x05001000 0x400>;
++			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
++			reg-shift = <2>;
++			reg-io-width = <4>;
++			clocks = <&ccu CLK_BUS_UART4>;
++			resets = <&ccu RST_BUS_UART4>;
++			status = "disabled";
++		};
++
++		uart5: serial@5001400 {
++			compatible = "snps,dw-apb-uart";
++			reg = <0x05001400 0x400>;
++			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
++			reg-shift = <2>;
++			reg-io-width = <4>;
++			clocks = <&ccu CLK_BUS_UART5>;
++			resets = <&ccu RST_BUS_UART5>;
++			status = "disabled";
++		};
++
++		i2c0: i2c@5002000 {
++			compatible = "allwinner,sun50i-h616-i2c",
++				     "allwinner,sun6i-a31-i2c";
++			reg = <0x05002000 0x400>;
++			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_I2C0>;
++			resets = <&ccu RST_BUS_I2C0>;
++			pinctrl-names = "default";
++			pinctrl-0 = <&i2c0_pins>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		i2c1: i2c@5002400 {
++			compatible = "allwinner,sun50i-h616-i2c",
++				     "allwinner,sun6i-a31-i2c";
++			reg = <0x05002400 0x400>;
++			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_I2C1>;
++			resets = <&ccu RST_BUS_I2C1>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		i2c2: i2c@5002800 {
++			compatible = "allwinner,sun50i-h616-i2c",
++				     "allwinner,sun6i-a31-i2c";
++			reg = <0x05002800 0x400>;
++			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_I2C2>;
++			resets = <&ccu RST_BUS_I2C2>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		i2c3: i2c@5002c00 {
++			compatible = "allwinner,sun50i-h616-i2c",
++				     "allwinner,sun6i-a31-i2c";
++			reg = <0x05002c00 0x400>;
++			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_I2C3>;
++			resets = <&ccu RST_BUS_I2C3>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		i2c4: i2c@5003000 {
++			compatible = "allwinner,sun50i-h616-i2c",
++				     "allwinner,sun6i-a31-i2c";
++			reg = <0x05003000 0x400>;
++			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_I2C4>;
++			resets = <&ccu RST_BUS_I2C4>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		spi0: spi@5010000 {
++			compatible = "allwinner,sun50i-h616-spi",
++				     "allwinner,sun8i-h3-spi";
++			reg = <0x05010000 0x1000>;
++			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
++			clock-names = "ahb", "mod";
++			resets = <&ccu RST_BUS_SPI0>;
++			pinctrl-names = "default";
++			pinctrl-0 = <&spi0_pins>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		spi1: spi@5011000 {
++			compatible = "allwinner,sun50i-h616-spi",
++				     "allwinner,sun8i-h3-spi";
++			reg = <0x05011000 0x1000>;
++			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
++			clock-names = "ahb", "mod";
++			resets = <&ccu RST_BUS_SPI1>;
++			pinctrl-names = "default";
++			pinctrl-0 = <&spi1_pins>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++
++		emac0: ethernet@5020000 {
++			compatible = "allwinner,sun50i-h616-emac",
++				     "allwinner,sun50i-a64-emac";
++			syscon = <&syscon>;
++			reg = <0x05020000 0x10000>;
++			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
++			interrupt-names = "macirq";
++			resets = <&ccu RST_BUS_EMAC0>;
++			reset-names = "stmmaceth";
++			clocks = <&ccu CLK_BUS_EMAC0>;
++			clock-names = "stmmaceth";
++			status = "disabled";
++
++			mdio: mdio {
++				compatible = "snps,dwmac-mdio";
++				#address-cells = <1>;
++				#size-cells = <0>;
++			};
++		};
++
++		usbotg: usb@5100000 {
++			compatible = "allwinner,sun50i-h616-musb",
++				     "allwinner,sun8i-a33-musb";
++			reg = <0x05100000 0x0400>;
++			clocks = <&ccu CLK_BUS_OTG>;
++			resets = <&ccu RST_BUS_OTG>;
++			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
++			interrupt-names = "mc";
++			phys = <&usbphy 0>;
++			phy-names = "usb";
++			extcon = <&usbphy 0>;
++			status = "disabled";
++		};
++
++		usbphy: phy@5100400 {
++			compatible = "allwinner,sun50i-h616-usb-phy";
++			reg = <0x05100400 0x24>,
++			      <0x05101800 0x4>,
++			      <0x05200800 0x4>,
++			      <0x05310800 0x4>,
++			      <0x05311800 0x4>;
++			reg-names = "phy_ctrl",
++				    "pmu0",
++				    "pmu1",
++				    "pmu2",
++				    "pmu3";
++			clocks = <&ccu CLK_USB_PHY0>,
++				 <&ccu CLK_USB_PHY1>,
++				 <&ccu CLK_USB_PHY2>,
++				 <&ccu CLK_USB_PHY3>;
++			clock-names = "usb0_phy",
++				      "usb1_phy",
++				      "usb2_phy",
++				      "usb3_phy";
++			resets = <&ccu RST_USB_PHY0>,
++				 <&ccu RST_USB_PHY1>,
++				 <&ccu RST_USB_PHY2>,
++				 <&ccu RST_USB_PHY3>;
++			reset-names = "usb0_reset",
++				      "usb1_reset",
++				      "usb2_reset",
++				      "usb3_reset";
++			status = "disabled";
++			#phy-cells = <1>;
++		};
++
++		ehci0: usb@5101000 {
++			compatible = "allwinner,sun50i-h616-ehci",
++				     "generic-ehci";
++			reg = <0x05101000 0x100>;
++			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_OHCI0>,
++				 <&ccu CLK_BUS_EHCI0>,
++				 <&ccu CLK_USB_OHCI0>;
++			resets = <&ccu RST_BUS_OHCI0>,
++				 <&ccu RST_BUS_EHCI0>;
++			status = "disabled";
++		};
++
++		ohci0: usb@5101400 {
++			compatible = "allwinner,sun50i-h616-ohci",
++				     "generic-ohci";
++			reg = <0x05101400 0x100>;
++			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_OHCI0>,
++				 <&ccu CLK_USB_OHCI0>;
++			resets = <&ccu RST_BUS_OHCI0>;
++			status = "disabled";
++		};
++
++		ehci1: usb@5200000 {
++			compatible = "allwinner,sun50i-h616-ehci",
++				     "generic-ehci";
++			reg = <0x05200000 0x100>;
++			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_OHCI1>,
++				 <&ccu CLK_BUS_EHCI1>,
++				 <&ccu CLK_USB_OHCI1>;
++			resets = <&ccu RST_BUS_OHCI1>,
++				 <&ccu RST_BUS_EHCI1>;
++			phys = <&usbphy 1>;
++			phy-names = "usb";
++			status = "disabled";
++		};
++
++		ohci1: usb@5200400 {
++			compatible = "allwinner,sun50i-h616-ohci",
++				     "generic-ohci";
++			reg = <0x05200400 0x100>;
++			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_OHCI1>,
++				 <&ccu CLK_USB_OHCI1>;
++			resets = <&ccu RST_BUS_OHCI1>;
++			phys = <&usbphy 1>;
++			phy-names = "usb";
++			status = "disabled";
++		};
++
++		ehci2: usb@5310000 {
++			compatible = "allwinner,sun50i-h616-ehci",
++				     "generic-ehci";
++			reg = <0x05310000 0x100>;
++			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_OHCI2>,
++				 <&ccu CLK_BUS_EHCI2>,
++				 <&ccu CLK_USB_OHCI2>;
++			resets = <&ccu RST_BUS_OHCI2>,
++				 <&ccu RST_BUS_EHCI2>;
++			phys = <&usbphy 2>;
++			phy-names = "usb";
++			status = "disabled";
++		};
++
++		ohci2: usb@5310400 {
++			compatible = "allwinner,sun50i-h616-ohci",
++				     "generic-ohci";
++			reg = <0x05310400 0x100>;
++			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_OHCI2>,
++				 <&ccu CLK_USB_OHCI2>;
++			resets = <&ccu RST_BUS_OHCI2>;
++			phys = <&usbphy 2>;
++			phy-names = "usb";
++			status = "disabled";
++		};
++
++		ehci3: usb@5311000 {
++			compatible = "allwinner,sun50i-h616-ehci",
++				     "generic-ehci";
++			reg = <0x05311000 0x100>;
++			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_OHCI3>,
++				 <&ccu CLK_BUS_EHCI3>,
++				 <&ccu CLK_USB_OHCI3>;
++			resets = <&ccu RST_BUS_OHCI3>,
++				 <&ccu RST_BUS_EHCI3>;
++			phys = <&usbphy 3>;
++			phy-names = "usb";
++			status = "disabled";
++		};
++
++		ohci3: usb@5311400 {
++			compatible = "allwinner,sun50i-h616-ohci",
++				     "generic-ohci";
++			reg = <0x05311400 0x100>;
++			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&ccu CLK_BUS_OHCI3>,
++				 <&ccu CLK_USB_OHCI3>;
++			resets = <&ccu RST_BUS_OHCI3>;
++			phys = <&usbphy 3>;
++			phy-names = "usb";
++			status = "disabled";
++		};
++
++		rtc: rtc@7000000 {
++			compatible = "allwinner,sun50i-h616-rtc",
++				     "allwinner,sun50i-h6-rtc";
++			reg = <0x07000000 0x400>;
++			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
++				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
++			clock-output-names = "osc32k", "osc32k-out", "iosc";
++			#clock-cells = <1>;
++		};
++
++		r_ccu: clock@7010000 {
++			compatible = "allwinner,sun50i-h616-r-ccu";
++			reg = <0x07010000 0x400>;
++			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
++				 <&ccu CLK_PLL_PERIPH0>;
++			clock-names = "hosc", "losc", "iosc", "pll-periph";
++			#clock-cells = <1>;
++			#reset-cells = <1>;
++		};
++
++		r_pio: pinctrl@7022000 {
++			compatible = "allwinner,sun50i-h616-r-pinctrl";
++			reg = <0x07022000 0x400>;
++			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc 0>;
++			clock-names = "apb", "hosc", "losc";
++			gpio-controller;
++			#gpio-cells = <3>;
++			interrupt-controller;
++			#interrupt-cells = <3>;
++
++			r_i2c_pins: r-i2c-pins {
++				pins = "PL0", "PL1";
++				function = "s_i2c";
++			};
++		};
++
++		ir: ir@7040000 {
++				compatible = "allwinner,sun50i-h616-ir",
++					     "allwinner,sun6i-a31-ir";
++				reg = <0x07040000 0x400>;
++				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
++				clocks = <&ccu CLK_R_APB1_IR>,
++					 <&ccu CLK_IR>;
++				clock-names = "apb", "ir";
++				resets = <&ccu RST_R_APB1_IR>;
++				pinctrl-names = "default";
++				pinctrl-0 = <&ir_rx_pin>;
++				status = "disabled";
++		};
++
++		r_i2c: i2c@7081400 {
++			compatible = "allwinner,sun50i-h616-i2c",
++				     "allwinner,sun6i-a31-i2c";
++			reg = <0x07081400 0x400>;
++			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
++			clocks = <&r_ccu CLK_R_APB2_I2C>;
++			resets = <&r_ccu RST_R_APB2_I2C>;
++			status = "disabled";
++			#address-cells = <1>;
++			#size-cells = <0>;
++		};
++	};
++};
diff --git a/target/linux/sunxi/patches-5.10/508-Add-OrangePi-Zero-2-.dts.patch b/target/linux/sunxi/patches-5.10/508-Add-OrangePi-Zero-2-.dts.patch
new file mode 100644
index 0000000000000..870c00efe3d14
--- /dev/null
+++ b/target/linux/sunxi/patches-5.10/508-Add-OrangePi-Zero-2-.dts.patch
@@ -0,0 +1,244 @@
+diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
+index 211d1e9d4701..0cf8299b1ce7 100644
+--- a/arch/arm64/boot/dts/allwinner/Makefile
++++ b/arch/arm64/boot/dts/allwinner/Makefile
+@@ -36,3 +36,4 @@  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
+ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
+ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
+ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
++dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
+
+diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
+new file mode 100644
+index 000000000000..814f5b4fec7c
+--- /dev/null
++++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
+@@ -0,0 +1,228 @@ 
++// SPDX-License-Identifier: (GPL-2.0+ or MIT)
++/*
++ * Copyright (C) 2020 Arm Ltd.
++ */
++
++/dts-v1/;
++
++#include "sun50i-h616.dtsi"
++
++#include <dt-bindings/gpio/gpio.h>
++#include <dt-bindings/interrupt-controller/arm-gic.h>
++
++/ {
++	model = "OrangePi Zero2";
++	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
++
++	aliases {
++		ethernet0 = &emac0;
++		serial0 = &uart0;
++	};
++
++	chosen {
++		stdout-path = "serial0:115200n8";
++	};
++
++	leds {
++		compatible = "gpio-leds";
++
++		power {
++			label = "orangepi:red:power";
++			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
++			default-state = "on";
++		};
++
++		status {
++			label = "orangepi:green:status";
++			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
++		};
++	};
++
++	reg_vcc5v: vcc5v {
++		/* board wide 5V supply directly from the USB-C socket */
++		compatible = "regulator-fixed";
++		regulator-name = "vcc-5v";
++		regulator-min-microvolt = <5000000>;
++		regulator-max-microvolt = <5000000>;
++		regulator-always-on;
++	};
++
++	reg_usb1_vbus: usb1-vbus {
++		compatible = "regulator-fixed";
++		regulator-name = "usb1-vbus";
++		regulator-min-microvolt = <5000000>;
++		regulator-max-microvolt = <5000000>;
++		enable-active-high;
++		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
++		status = "okay";
++	};
++};
++
++&ehci0 {
++	status = "okay";
++};
++
++&ehci1 {
++	status = "okay";
++};
++
++/* USB 2 & 3 are on headers only. */
++
++&emac0 {
++	pinctrl-names = "default";
++	pinctrl-0 = <&ext_rgmii_pins>;
++	phy-mode = "rgmii-id";
++	phy-handle = <&ext_rgmii_phy>;
++	phy-supply = <&reg_dcdce>;
++	allwinner,rx-delay-ps = <3100>;
++	allwinner,tx-delay-ps = <700>;
++	status = "okay";
++};
++
++&mdio {
++	ext_rgmii_phy: ethernet-phy@1 {
++		compatible = "ethernet-phy-ieee802.3-c22";
++		reg = <1>;
++	};
++};
++
++&mmc0 {
++	vmmc-supply = <&reg_dcdce>;
++	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
++	bus-width = <4>;
++	status = "okay";
++};
++
++&ohci0 {
++	status = "okay";
++};
++
++&ohci1 {
++	status = "okay";
++};
++
++&r_i2c {
++	status = "okay";
++
++	axp305: pmic@36 {
++		compatible = "x-powers,axp305", "x-powers,axp805",
++			     "x-powers,axp806";
++		reg = <0x36>;
++
++		/* dummy interrupt to appease the driver for now */
++		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
++		interrupt-controller;
++		#interrupt-cells = <1>;
++
++		x-powers,self-working-mode;
++		vina-supply = <&reg_vcc5v>;
++		vinb-supply = <&reg_vcc5v>;
++		vinc-supply = <&reg_vcc5v>;
++		vind-supply = <&reg_vcc5v>;
++		vine-supply = <&reg_vcc5v>;
++		aldoin-supply = <&reg_vcc5v>;
++		bldoin-supply = <&reg_vcc5v>;
++		cldoin-supply = <&reg_vcc5v>;
++
++		regulators {
++			reg_aldo1: aldo1 {
++				regulator-always-on;
++				regulator-min-microvolt = <3300000>;
++				regulator-max-microvolt = <3300000>;
++				regulator-name = "vcc-sys";
++			};
++
++			reg_aldo2: aldo2 {
++				regulator-min-microvolt = <3300000>;
++				regulator-max-microvolt = <3300000>;
++				regulator-name = "vcc3v3-ext";
++			};
++
++			reg_aldo3: aldo3 {
++				regulator-min-microvolt = <3300000>;
++				regulator-max-microvolt = <3300000>;
++				regulator-name = "vcc3v3-ext2";
++			};
++
++			reg_bldo1: bldo1 {
++				regulator-always-on;
++				regulator-min-microvolt = <1800000>;
++				regulator-max-microvolt = <1800000>;
++				regulator-name = "vcc1v8";
++			};
++
++			bldo2 {
++				/* unused */
++			};
++
++			bldo3 {
++				/* unused */
++			};
++
++			bldo4 {
++				/* unused */
++			};
++
++			cldo1 {
++				/* reserved */
++			};
++
++			cldo2 {
++				/* unused */
++			};
++
++			cldo3 {
++				/* unused */
++			};
++
++			reg_dcdca: dcdca {
++				regulator-always-on;
++				regulator-min-microvolt = <810000>;
++				regulator-max-microvolt = <1080000>;
++				regulator-name = "vdd-cpu";
++			};
++
++			reg_dcdcc: dcdcc {
++				regulator-always-on;
++				regulator-min-microvolt = <810000>;
++				regulator-max-microvolt = <1080000>;
++				regulator-name = "vdd-gpu-sys";
++			};
++
++			reg_dcdcd: dcdcd {
++				regulator-always-on;
++				regulator-min-microvolt = <1500000>;
++				regulator-max-microvolt = <1500000>;
++				regulator-name = "vdd-dram";
++			};
++
++			reg_dcdce: dcdce {
++				regulator-boot-on;
++				regulator-min-microvolt = <3300000>;
++				regulator-max-microvolt = <3300000>;
++				regulator-name = "vcc-eth-mmc";
++			};
++
++			sw {
++				/* unused */
++			};
++		};
++	};
++};
++
++&uart0 {
++	pinctrl-names = "default";
++	pinctrl-0 = <&uart0_ph_pins>;
++	status = "okay";
++};
++
++&usbotg {
++	dr_mode = "otg";
++	status = "okay";
++};
++
++&usbphy {
++	usb0_vbus-supply = <&reg_vcc5v>;
++	usb1_vbus-supply = <&reg_usb1_vbus>;
++	status = "okay";
++};
