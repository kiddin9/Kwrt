--- a/package/kernel/linux/modules/crypto.mk
+++ b/package/kernel/linux/modules/crypto.mk
@@ -809,3 +809,18 @@ endef
 
 $(eval $(call KernelPackage,crypto-xts))
 
+
+define KernelPackage/crypto-zstd
+  TITLE:=zstd compression CryptoAPI module
+  DEPENDS:=+kmod-lib-zstd +kmod-crypto-acompress
+  KCONFIG:=CONFIG_CRYPTO_ZSTD
+  FILES:=$(LINUX_DIR)/crypto/zstd.ko
+  AUTOLOAD:=$(call AutoLoad,09,zstd)
+  $(call AddDepends/crypto)
+endef
+
+define KernelPackage/crypto-zstd/description
+ Kernel module for the CryptoAPI to support Zstandard
+endef
+
+$(eval $(call KernelPackage,crypto-zstd))

--- a/package/kernel/linux/modules/lib.mk
+++ b/package/kernel/linux/modules/lib.mk
@@ -166,6 +166,27 @@ endef
 $(eval $(call KernelPackage,lib-lz4))
 
 
+define KernelPackage/lib-lz4hc
+  SUBMENU:=$(LIB_MENU)
+  TITLE:=LZ4HC support
+  DEPENDS:=+kmod-lib-lz4 +kmod-crypto-acompress
+  HIDDEN:=1
+  KCONFIG:= \
+	CONFIG_CRYPTO_LZ4HC \
+	CONFIG_LZ4HC_COMPRESS
+  FILES:= \
+	$(LINUX_DIR)/crypto/lz4hc.ko \
+	$(LINUX_DIR)/lib/lz4/lz4hc_compress.ko
+  AUTOLOAD:=$(call AutoProbe,lz4hc lz4hc_compress)
+endef
+
+define KernelPackage/lib-lz4hc/description
+ Kernel module for LZ4HC compression/decompression support
+endef
+
+$(eval $(call KernelPackage,lib-lz4hc))
+
+
 define KernelPackage/lib-raid6
   SUBMENU:=$(LIB_MENU)
   TITLE:=RAID6 algorithm support

--- a/package/kernel/linux/modules/other.mk
+++ b/package/kernel/linux/modules/other.mk
@@ -869,6 +869,85 @@ endef
 $(eval $(call KernelPackage,zram))
 
 
+define KernelPackage/zsmalloc
+  SUBMENU:=$(OTHER_MENU)
+  TITLE:=ZSMALLOC support
+  DEPENDS:=+kmod-crypto-deflate \
+	+kmod-lib-lz4 \
+	@!PACKAGE_kmod-zram
+  KCONFIG:= \
+	CONFIG_ZSMALLOC \
+	CONFIG_ZSMALLOC_STAT=n
+  FILES:= $(LINUX_DIR)/mm/zsmalloc.ko
+  AUTOLOAD:=$(call AutoLoad,19,zsmalloc)
+endef
+
+define KernelPackage/zsmalloc/description
+ Special purpose memory allocator for compressed memory pages
+endef
+
+define KernelPackage/zsmalloc/config
+	if PACKAGE_kmod-zsmalloc
+		config KERNEL_PGTABLE_MAPPING
+			bool "zsmalloc: enable CONFIG_PGTABLE_MAPPING"
+			default y if arm
+			default n
+			help
+	  Enable CONFIG_PGTABLE_MAPPING in the kernel for faster memory
+	  allocations when using ZSMALLOC, in some architectures. Enabled
+	  by default for the ARM architecture because it may be a huge
+	  performance boost.
+	endif
+endef
+
+$(eval $(call KernelPackage,zsmalloc))
+
+
+define KernelPackage/zram-writeback
+  SUBMENU:=$(OTHER_MENU)
+  TITLE:=zram with writeback support
+  DEPENDS:=+kmod-zsmalloc
+  KCONFIG:= \
+	CONFIG_ZRAM \
+	CONFIG_ZRAM_DEBUG=n \
+	CONFIG_ZRAM_MEMORY_TRACKING=n \
+	CONFIG_ZRAM_WRITEBACK=y
+  FILES:= \
+	$(LINUX_DIR)/drivers/block/zram/zram.ko
+  AUTOLOAD:=$(call AutoLoad,20,zram)
+endef
+
+define KernelPackage/zram-writeback/description
+ Compressed RAM disk with support for page writeback
+endef
+
+$(eval $(call KernelPackage,zram-writeback))
+
+
+define KernelPackage/zswap
+  SUBMENU:=$(OTHER_MENU)
+  TITLE:=zswap compressed swapping cache
+  DEPENDS:=+kmod-zsmalloc
+  KCONFIG:= \
+	CONFIG_FRONTSWAP=y \
+	CONFIG_Z3FOLD \
+	CONFIG_ZBUD \
+	CONFIG_ZPOOL \
+	CONFIG_ZSWAP=y
+  FILES:= \
+	$(LINUX_DIR)/mm/z3fold.ko \
+	$(LINUX_DIR)/mm/zbud.ko \
+	$(LINUX_DIR)/mm/zpool.ko
+  AUTOLOAD:=$(call AutoLoad,20,z3fold zbud zpool)
+endef
+
+define KernelPackage/zswap/description
+ Compressed swap cache and compressed memory allocator support
+endef
+
+$(eval $(call KernelPackage,zswap))
+
+
 define KernelPackage/pps
   SUBMENU:=$(OTHER_MENU)
   TITLE:=PPS support
