#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sed -i '/rm -rf $(KDIR)\/tmp/d' include/image.mk

rm -rf feeds/kiddin9/{rtl8821cu,rtl88x2bu} package/kernel/mt76 devices/common/patches/mt7922.patch
