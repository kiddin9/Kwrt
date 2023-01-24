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

define Device/photonicat
  DEVICE_VENDOR := 光影猫
  DEVICE_MODEL := Photonicat
  SOC := RK3568
  DEVICE_PACKAGES := pcat-manager
endef
TARGET_DEVICES += photonicat

define Image/Build
	export IMG_PREFIX="$(IMG_PREFIX)$(if $(PROFILE_SANITIZED),-$(PROFILE_SANITIZED))"; \
	export BIN_DIR=$(BIN_DIR); \
	export TOPDIR=$(TOPDIR); \
	export PARTSIZE=$(CONFIG_TARGET_ROOTFS_PARTSIZE); \
	cd /www/wwwroot/op.supes.top/bcache/armvirt/64/rk3568-linux-sdk; \
	export CROSS_COMPILE=aarch64-linux-gnu-;\
	bash ./build.sh
endef

$(eval $(call BuildImage))
