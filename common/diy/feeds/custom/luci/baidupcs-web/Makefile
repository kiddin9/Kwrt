#
# Copyright (C) 2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=baidupcs-web
PKG_VERSION:=v3.7.1
PKG_RELEASE:=1

# 禁止OpenWrt对二进制文件进行strip
STRIP:=true

ifeq ($(ARCH),i386)
	PKG_ARCH:=386
endif

ifeq ($(ARCH),x86_64)
	PKG_ARCH:=amd64
endif

ifeq ($(ARCH),mipsel)
	PKG_ARCH:=mipsle
endif

ifeq ($(ARCH),mips)
	PKG_ARCH:=mipsle
endif

ifeq ($(ARCH),arm)
ifeq ($(BOARD),bcm53xx)
	PKG_ARCH:=armv5
else ifeq ($(BOARD),kirkwood)
	PKG_ARCH:=armv5
else
	PKG_ARCH:=armv7
endif
endif

ifeq ($(ARCH),aarch64)
	PKG_ARCH:=arm64
endif

PKG_SOURCE:=BaiduPCS-Go-$(PKG_VERSION)-linux-$(PKG_ARCH).tgz
PKG_SOURCE_URL:=https://github.com/garypang13/luci-app-baidupcs-web/releases/download/$(PKG_VERSION)/
PKG_BUILD_DIR:=$(BUILD_DIR)/BaiduPCS-Go-$(PKG_VERSION)-linux-$(PKG_ARCH)
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=BaiduPCS-Web is a web controller for BaiduPCS-Go
endef


define Package/$(PKG_NAME)/description
BaiduPCS-Web is a web controller for BaiduPCS-Go
endef



define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/BaiduPCS-Go $(1)/usr/bin/$(PKG_NAME)
	chmod 755 $(1)/usr/bin/$(PKG_NAME)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
