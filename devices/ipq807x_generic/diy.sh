#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

svn co https://github.com/robimarko/nss-packages/trunk/qca/qca-ssdk-shell package/network/utils/qca-ssdk-shell

sh -c "curl -sfL https://github.com/robimarko/openwrt/commit/23fa931934151f72c1655ffa62ff1a979575f07e.patch | patch -d './' -p1 --forward"

sed -i '/rm -rf $(KDIR)\/tmp/d' include/image.mk

rm -rf feeds/kiddin9/{rtl8821cu,rtl88x2bu} package/kernel/mt76
