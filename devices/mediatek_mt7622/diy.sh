#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
#bash $SHELL_FOLDER/../common/kernel_5.15.sh

#curl -sfL https://raw.githubusercontent.com/x-wrt/x-wrt/master/target/linux/mediatek/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch -o target/linux/mediatek/patches-5.15/995-0001-hwnat-add-natflow-flow-offload-support.patch

