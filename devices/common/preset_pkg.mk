# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2007 OpenWrt.org

TOPDIR:=${CURDIR}
export OPENWRT_VERBOSE=s

include rules.mk
include $(INCLUDE_DIR)/target.mk
-include .profiles.mk

.profiles.mk: $(TMP_DIR)/.targetinfo
	@$(SCRIPT_DIR)/target-metadata.pl profile_mk $< '$(BOARD)$(if $(SUBTARGET),/$(SUBTARGET))' > $@

USER_PROFILE ?= $(firstword $(PROFILE_NAMES))
BUILD_PACKAGES:=$(sort $(DEFAULT_PACKAGES) $($(USER_PROFILE)_PACKAGES) kernel)
# "-pkgname" in the package list means remove "pkgname" from the package list
BUILD_PACKAGES:=$(filter-out $(filter -%,$(BUILD_PACKAGES)) $(patsubst -%,%,$(filter -%,$(BUILD_PACKAGES))),$(BUILD_PACKAGES))

presetpkg: FORCE
	@echo "$(BUILD_PACKAGES)"
