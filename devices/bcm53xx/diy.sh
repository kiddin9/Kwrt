#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
bash $SHELL_FOLDER/../common/kernel_5.15.sh

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += autocore-arm luci-app-cpufreq luci-app-turboacc/' target/linux/mediatek/Makefile

