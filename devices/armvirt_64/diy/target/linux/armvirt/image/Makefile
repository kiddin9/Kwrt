# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2012-2019 OpenWrt.org
# Copyright (C) 2016-2017 LEDE project

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/Compile
	$(CP) $(LINUX_DIR)/COPYING $(KDIR)/COPYING.linux
endef

### Devices ###
define Device/Default
  KERNEL := kernel-bin
endef

define Device/box
  DEVICE_VENDOR := 
  DEVICE_MODEL := 电视盒子全系列 / N1
  DEVICE_PACKAGES :=
endef
TARGET_DEVICES += box

define Image/Build
	export BIN_DIR=$(BIN_DIR); \
	export DATE=$(DATE); \
	cd /www/wwwroot/op.supes.top/bcache/armvirt/64/amlogic-s9xxx-openwrt; \
	. ../modify_amlogic.sh; \
	./make -k 5.15.100 -b $(MORE) -s $(CONFIG_TARGET_ROOTFS_PARTSIZE)
endef

$(eval $(call BuildImage))

# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2020 Tobias Maedel
