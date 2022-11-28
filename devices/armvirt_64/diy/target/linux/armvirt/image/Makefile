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

define Device/n1
  DEVICE_VENDOR := Phicomm
  DEVICE_MODEL := N1
  SOC := s905d
  DEVICE_PACKAGES :=
endef
TARGET_DEVICES += n1

define Device/beikeyun
  DEVICE_VENDOR := 贝壳云
  DEVICE_MODEL :=P1
  SOC := rk3328
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += beikeyun

define Device/vplus
  DEVICE_VENDOR := 微加云
  DEVICE_MODEL := V-Plus
  SOC := h6
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += vplus

define Device/l1pro
  DEVICE_VENDOR := 我家云
  DEVICE_MODEL := lL Pro
  SOC := rk3328
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += l1pro

define Device/mxqpro
  DEVICE_VENDOR := MXQ
  DEVICE_MODEL := Pro+
  SOC := s905
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += mxqpro

define Device/x96max
  DEVICE_VENDOR := x96 Max
  DEVICE_MODEL := s905x2
  SOC := s905x2
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += x96max

define Device/hk1
  DEVICE_VENDOR := HK1
  DEVICE_MODEL := Box
  SOC := s905x3
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += hk1

define Device/zyxq
  DEVICE_VENDOR := 章鱼星球
  DEVICE_MODEL := ZYXQ
  SOC := s912
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += zyxq

define Device/gtking
  DEVICE_VENDOR := Beelink
  DEVICE_MODEL := GT-King
  SOC := s922x
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += gtking

define Device/odroid-n2
  DEVICE_VENDOR := Hardkernel
  DEVICE_MODEL := Odroid-N2
  SOC := s922x
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += odroid-n2

define Device/rock5b
  DEVICE_VENDOR := Radxa
  DEVICE_MODEL := ROCK 5B
  SOC := RK3588
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += rock5b

define Device/h88k
  DEVICE_VENDOR := HinLink
  DEVICE_MODEL := H88K
  SOC := RK3588
  DEVICE_PACKAGES := 
endef
TARGET_DEVICES += h88k

define Image/Build
	export IMG_PREFIX="$(IMG_PREFIX)$(if $(PROFILE_SANITIZED),-$(PROFILE_SANITIZED))"; \
	export BIN_DIR=$(BIN_DIR); \
	export PARTSIZE=$(CONFIG_TARGET_ROOTFS_PARTSIZE); \
	cd /www/wwwroot/op.supes.top/bcache/armvirt/64/openwrt_packit; \
	. ../modify_packit.sh; \
	if [ $(PROFILE_SANITIZED) == "n1" ]; then \
		./mk_s905d_n1.sh; \
	elif [ $(PROFILE_SANITIZED) == "beikeyun" ]; then \
		./mk_rk3328_beikeyun.sh; \
	elif [ $(PROFILE_SANITIZED) == "l1pro" ]; then \
		./mk_rk3328_l1pro.sh; \
	elif [ $(PROFILE_SANITIZED) == "mxqpro" ]; then \
		./mk_s905_mxqpro+.sh; \
	elif [ $(PROFILE_SANITIZED) == "x96max" ]; then \
		./mk_s905x2_x96max.sh; \
	elif [ $(PROFILE_SANITIZED) == "zyxq" ]; then \
		./mk_s912_zyxq.sh; \
	elif [ $(PROFILE_SANITIZED) == "gtking" ]; then \
		./mk_s922x_gtking.sh; \
	elif [ $(PROFILE_SANITIZED) == "odroid-n2" ]; then \
		./mk_s922x_odroid-n2.sh; \
	elif [ $(PROFILE_SANITIZED) == "vplus" ]; then \
		./mk_h6_vplus.sh; \
	elif [ $(PROFILE_SANITIZED) == "fastrhino_r68s" ]; then \
		./mk_rk3568_r68s.sh; \
	elif [ $(PROFILE_SANITIZED) == "hk1" ]; then \
		./mk_s905x3_multi.sh; \
	elif [ $(PROFILE_SANITIZED) == "rock5b" ]; then \
		./mk_rk3588_rock5b.sh; \
	elif [ $(PROFILE_SANITIZED) == "h88k" ]; then \
		./mk_rk3588_h88k.sh; \
	fi; \
	gzip -f9n $(BIN_DIR)/$(IMG_PREFIX)$(if $(PROFILE_SANITIZED),-$(PROFILE_SANITIZED)).img || true
endef

$(eval $(call BuildImage))

# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2020 Tobias Maedel
