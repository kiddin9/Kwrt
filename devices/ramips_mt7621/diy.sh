#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))


sed -i "s/DEVICE_MODEL := HC5962$/DEVICE_MODEL := HC5962 \/ B70/" target/linux/ramips/image/mt7621.mk


sed -i '/# start dockerd/,/# end dockerd/d' .config

sed -i "s/--max-leb-cnt=96/--max-leb-cnt=128/g" target/linux/ramips/image/mt7621.mk
