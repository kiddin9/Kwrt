#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-usb2 kmod-usb3/' target/linux/ipq806x/Makefile
