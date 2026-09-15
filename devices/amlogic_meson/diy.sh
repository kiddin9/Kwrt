#!/bin/bash

shopt -s extglob

sed -i 's/Os/O2/g' include/target.mk

git_clone_path istoreos-25.12 https://github.com/istoreos/istoreos target/linux/amlogic package/boot/uboot-amlogic-prebuilt

rm -rf package/kernel/r81* target/linux/amlogic/base-files/etc/inittab



