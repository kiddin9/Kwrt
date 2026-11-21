#!/bin/bash

shopt -s extglob

git_clone_path istoreos-25.12 https://github.com/istoreos/istoreos target/linux/amlogic package/boot/uboot-amlogic-prebuilt

rm -rf target/linux/amlogic/base-files/etc/inittab

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-diskman automount/' target/linux/amlogic/Makefile



