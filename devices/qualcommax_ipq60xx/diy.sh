#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

git clone https://github.com/JiaY-shi/nss-packages.git package/nss-packages

rm -rf feeds/kiddin9/{fibocom_QMI_WWAN,quectel_Gobinet,shortcut-fe}

rm -rf devices/common/patches/rootfstargz.patch
