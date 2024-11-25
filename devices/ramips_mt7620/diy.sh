#!/bin/bash

shopt -s extglob

sh -c "curl -sfL https://github.com/openwrt/openwrt/commit/2e6d19ee32399e37c7545aefc57d41541a406d55.patch | patch -d './' -p1 --forward" || true

sed -i '/# start dockerd/,/# end dockerd/d' .config



