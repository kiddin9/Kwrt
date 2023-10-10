#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2099-12-06/" package/network/config/netifd/Makefile

rm -rf feeds/kiddin9/{rtl8821cu,rtl88x2bu} package/kernel/mt76 devices/common/patches/mt7922.patch