#!/bin/bash

shopt -s extglob
SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_6.1.sh

sed -i "s/mi-router-wr30u-stock/mi-router-wr30u/" package/boot/uboot-envtools/files/mediatek_filogic
sed -i "s/mi-router-wr30u-stock/mi-router-wr30u/" target/linux/mediatek/filogic/base-files/etc/board.d/01_leds
sed -i "s/mi-router-wr30u-stock/mi-router-wr30u/" target/linux/mediatek/filogic/base-files/etc/board.d/02_network
sed -i "s/mi-router-wr30u-stock/mi-router-wr30u/" target/linux/mediatek/filogic/base-files/lib/upgrade/platform.sh

