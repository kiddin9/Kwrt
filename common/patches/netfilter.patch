--- a/package/kernel/linux/modules/netfilter.mk
+++ b/package/kernel/linux/modules/netfilter.mk
@@ -458,15 +458,100 @@
 $(eval $(call KernelPackage,ipt-nat))
 
+define KernelPackage/ipt-cgroup
+  SUBMENU:=$(NF_MENU)
+  TITLE:=cgroup netfilter module
+  KCONFIG:=$(KCONFIG_IPT_CGROUP)
+  FILES:=$(LINUX_DIR)/net/netfilter/*cgroup*.$(LINUX_KMOD_SUFFIX)
+  AUTOLOAD:=$(call AutoLoad,$(notdir $(IPT_CGROUP-m)))
+  DEPENDS:= kmod-ipt-core
+endef
 
+$(eval $(call KernelPackage,ipt-cgroup))
+
+define KernelPackage/ipt-cgroup/description
+ Kernel support for cgroup netfilter module
+ Include:
+ - cgroup
+endef
+
 define KernelPackage/ipt-raw
   TITLE:=Netfilter IPv4 raw table support
   KCONFIG:=CONFIG_IP_NF_RAW
   FILES:=$(LINUX_DIR)/net/ipv4/netfilter/iptable_raw.ko
   AUTOLOAD:=$(call AutoProbe,iptable_raw)
   $(call AddDepends/ipt)
 endef
 
 $(eval $(call KernelPackage,ipt-raw))
+
+
+define KernelPackage/ipt-imq
+  TITLE:=Intermediate Queueing support
+  KCONFIG:= \
+	CONFIG_IMQ \
+	CONFIG_IMQ_BEHAVIOR_BA=y \
+	CONFIG_IMQ_NUM_DEVS=2 \
+	CONFIG_NETFILTER_XT_TARGET_IMQ
+  FILES:= \
+	$(LINUX_DIR)/drivers/net/imq.$(LINUX_KMOD_SUFFIX) \
+	$(foreach mod,$(IPT_IMQ-m),$(LINUX_DIR)/net/$(mod).$(LINUX_KMOD_SUFFIX))
+  AUTOLOAD:=$(call AutoProbe,$(notdir imq $(IPT_IMQ-m)))
+  $(call AddDepends/ipt)
+endef
+
+define KernelPackage/ipt-imq/description
+ Kernel support for Intermediate Queueing devices
+endef
+
+$(eval $(call KernelPackage,ipt-imq))
+
+
+define KernelPackage/ipt-bandwidth
+  SUBMENU:=$(NF_MENU)
+  TITLE:=bandwidth
+  KCONFIG:=$(KCONFIG_IPT_BANDWIDTH)
+  FILES:=$(LINUX_DIR)/net/ipv4/netfilter/*bandwidth*.$(LINUX_KMOD_SUFFIX)
+  AUTOLOAD:=$(call AutoLoad,$(notdir $(IPT_BANDWIDTH-m)))
+  DEPENDS:=@!LINUX_5_4 kmod-ipt-core
+endef
+
+$(eval $(call KernelPackage,ipt-bandwidth))
+
+
+define KernelPackage/ipt-timerange
+  SUBMENU:=$(NF_MENU)
+  TITLE:=timerange
+  KCONFIG:=$(KCONFIG_IPT_TIMERANGE)
+  FILES:=$(LINUX_DIR)/net/ipv4/netfilter/*timerange*.$(LINUX_KMOD_SUFFIX)
+  AUTOLOAD:=$(call AutoLoad,$(notdir $(IPT_TIMERANGE-m)))
+  DEPENDS:=@!LINUX_5_4 kmod-ipt-core
+endef
+
+$(eval $(call KernelPackage,ipt-timerange))
+
+
+define KernelPackage/ipt-webmon
+  SUBMENU:=$(NF_MENU)
+  TITLE:=webmon
+  KCONFIG:=$(KCONFIG_IPT_WEBMON)
+  FILES:=$(LINUX_DIR)/net/ipv4/netfilter/*webmon*.$(LINUX_KMOD_SUFFIX)
+  AUTOLOAD:=$(call AutoLoad,$(notdir $(IPT_WEBMON-m)))
+  DEPENDS:=@!LINUX_5_4 kmod-ipt-core
+endef
+
+$(eval $(call KernelPackage,ipt-webmon))
+
+
+define KernelPackage/ipt-weburl
+  SUBMENU:=$(NF_MENU)
+  TITLE:=weburl
+  KCONFIG:=$(KCONFIG_IPT_WEBURL)
+  FILES:=$(LINUX_DIR)/net/ipv4/netfilter/*weburl*.$(LINUX_KMOD_SUFFIX)
+  AUTOLOAD:=$(call AutoLoad,$(notdir $(IPT_WEBURL-m)))
+  DEPENDS:=@!LINUX_5_4 kmod-ipt-core
+endef
+
+$(eval $(call KernelPackage,ipt-weburl))
 
 
 define KernelPackage/ipt-raw6

--- a/include/netfilter.mk
+++ b/include/netfilter.mk
@@ -111,3 +111,14 @@
 
+# imq
+
+$(eval $(call nf_add,IPT_IMQ,CONFIG_IP_NF_TARGET_IMQ, $(P_V4)ipt_IMQ))
+$(eval $(call nf_add,IPT_IMQ,CONFIG_NETFILTER_XT_TARGET_IMQ, $(P_XT)xt_IMQ))
+
+# gargoyle-qos
+
+$(eval $(call nf_add,IPT_BANDWIDTH,CONFIG_IP_NF_MATCH_BANDWIDTH, $(P_V4)ipt_bandwidth))
+$(eval $(call nf_add,IPT_TIMERANGE,CONFIG_IP_NF_MATCH_TIMERANGE, $(P_V4)ipt_timerange))
+$(eval $(call nf_add,IPT_WEBMON,CONFIG_IP_NF_MATCH_WEBMON, $(P_V4)ipt_webmon))
+$(eval $(call nf_add,IPT_WEBURL,CONFIG_IP_NF_MATCH_WEBURL, $(P_V4)ipt_weburl))
 
 # ipopt
@@ -151,3 +162,6 @@
 $(eval $(call nf_add,IPT_FLOW,CONFIG_NETFILTER_XT_TARGET_FLOWOFFLOAD, $(P_XT)xt_FLOWOFFLOAD))
+
+# cgroup
+$(eval $(call nf_add,IPT_CGROUP,CONFIG_NETFILTER_XT_MATCH_CGROUP, $(P_XT)xt_cgroup))
 
 # IPv6

--- a/package/network/utils/iptables/Makefile
+++ b/package/network/utils/iptables/Makefile
@@ -170,3 +170,49 @@
 endef
 
+define Package/iptables-mod-cgroup
+$(call Package/iptables/Module, +kmod-ipt-cgroup)
+  TITLE:=cgroup extension
+  endef
+
+define Package/iptables-mod-cgroup/description
+iptables extension for cgroup support.
+
+ Matches:
+   - cgroup
+
+endef
+
+define Package/iptables-mod-imq
+$(call Package/iptables/Module, +kmod-ipt-imq)
+  TITLE:=IMQ support
+endef
+
+define Package/iptables-mod-imq/description
+iptables extension for IMQ support.
+
+ Targets:
+   - IMQ
+
+endef
+
+define Package/iptables-mod-bandwidth
+$(call Package/iptables/Module, +kmod-ipt-bandwidth)
+  TITLE:=bandwidth option extensions
+endef
+
+define Package/iptables-mod-timerange
+$(call Package/iptables/Module, +kmod-ipt-timerange)
+  TITLE:=timerange option extensions
+endef
+
+define Package/iptables-mod-webmon
+$(call Package/iptables/Module, +kmod-ipt-webmon)
+  TITLE:=webmon option extensions
+endef
+
+define Package/iptables-mod-weburl
+$(call Package/iptables/Module, +kmod-ipt-weburl)
+  TITLE:=weburl option extensions
+endef
+
 define Package/iptables-mod-ipopt
@@ -666,2 +712,8 @@
 $(eval $(call BuildPlugin,iptables-mod-filter,$(IPT_FILTER-m)))
+$(eval $(call BuildPlugin,iptables-mod-cgroup,$(IPT_CGROUP-m)))
+$(eval $(call BuildPlugin,iptables-mod-imq,$(IPT_IMQ-m)))
+$(eval $(call BuildPlugin,iptables-mod-bandwidth,$(IPT_BANDWIDTH-m)))
+$(eval $(call BuildPlugin,iptables-mod-timerange,$(IPT_TIMERANGE-m)))
+$(eval $(call BuildPlugin,iptables-mod-webmon,$(IPT_WEBMON-m)))
+$(eval $(call BuildPlugin,iptables-mod-weburl,$(IPT_WEBURL-m)))
 $(eval $(call BuildPlugin,iptables-mod-ipopt,$(IPT_IPOPT-m)))

