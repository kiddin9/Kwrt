--- a/include/target.mk
+++ b/include/target.mk
@@ -259,9 +259,18 @@ ifeq ($(DUMP),1)
     CPU_CFLAGS_arc700 = -mcpu=arc700
     CPU_CFLAGS_archs = -mcpu=archs
   endif
+  ifeq ($(BOARD),rockchip)
+    CPU_CFLAGS = -O3 -pipe
+    CPU_CFLAGS_cortex-a53 = -mcpu=cortex-a53
+    CPU_CFLAGS_cortex-a55 = -march=armv8-a+crypto+crc -mcpu=cortex-a55+crypto+crc -mtune=cortex-a55
+    CPU_CFLAGS_cortex-a73 = -march=armv8-a+crypto+crc -mcpu=cortex-a73.cortex-a53+crypto+crc -mtune=cortex-a73.cortex-a53
+    ifneq ($(SOC_CFLAGS),)
+      CPU_CFLAGS_generic = $(SOC_CFLAGS)
+    endif
+  endif
   ifneq ($(CPU_TYPE),)
     ifndef CPU_CFLAGS_$(CPU_TYPE)
-      $(warning CPU_TYPE "$(CPU_TYPE)" doesn't correspond to a known type)
+      $(warning CPU_TYPE "$(CPU_TYPE)" "doesn't correspond to a known type")
     endif
   endif
   DEFAULT_CFLAGS=$(strip $(CPU_CFLAGS) $(CPU_CFLAGS_$(CPU_TYPE)) $(CPU_CFLAGS_$(CPU_SUBTYPE)))