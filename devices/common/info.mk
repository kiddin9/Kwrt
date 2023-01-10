# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2007 OpenWrt.org

TOPDIR:=${CURDIR}
export OPENWRT_VERBOSE=s

include rules.mk
include $(INCLUDE_DIR)/target.mk

kernel_version: FORCE
	@echo "$(LINUX_VERSION)"
