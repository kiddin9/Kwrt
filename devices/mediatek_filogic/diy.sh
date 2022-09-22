#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
bash $SHELL_FOLDER/../common/kernel_5.15.sh

curl -sfL https://github.com/coolsnowwolf/lede/raw/master/target/linux/mediatek/dts/mt7986a-xiaomi-redmi-router-ax6000.dts -o target/linux/mediatek/dts/mt7986a-xiaomi-redmi-router-ax6000.dts

sh -c "curl -sfL https://github.com/openwrt/openwrt/commit/8686a9a085d4313a0107a3e4378b3762c8293570.patch | patch -d './' -p1 --forward"