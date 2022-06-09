#!/bin/bash

shopt -s extglob


sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += my-autocore-arm luci-app-cpufreq luci-app-turboacc/' target/linux/mediatek/Makefile

