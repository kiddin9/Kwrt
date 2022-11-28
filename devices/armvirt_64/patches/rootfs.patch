--- a/include/image.mk
+++ b/include/image.mk
@@ -768,7 +768,7 @@
 define Device
   $(call Device/InitProfile,$(1))
-  $(call Device/Init,$(1))
+  $(call Device/Init,$(PROFILE_SANITIZED))
   $(call Device/Default,$(1))
-  $(call Device/$(1),$(1))
+  $(call Device/$(PROFILE_SANITIZED),$(1))
   $(call Device/Check,$(1))
   $(call Device/$(if $(DUMP),Dump,Build),$(1))
