#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
#bash $SHELL_FOLDER/../common/kernel_5.15.sh

#curl -sfL https://raw.githubusercontent.com/x-wrt/x-wrt/master/target/linux/mediatek/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch -o target/linux/mediatek/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += autocore-arm luci-app-cpufreq/' target/linux/mediatek/Makefile

echo '
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
' >> ./target/linux/mediatek/mt7622/config-5.10
