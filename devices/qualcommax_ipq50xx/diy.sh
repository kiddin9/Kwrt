#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

wget -N https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/openwrt-24.10/target/imagebuilder/files/Makefile -P target/imagebuilder/files/