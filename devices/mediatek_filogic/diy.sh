#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
bash $SHELL_FOLDER/../common/kernel_5.15.sh

curl -sfL https://github.com/coolsnowwolf/lede/raw/master/target/linux/mediatek/dts/mt7986a-xiaomi-redmi-router-ax6000.dts -o target/linux/mediatek/dts/mt7986a-xiaomi-redmi-router-ax6000.dts