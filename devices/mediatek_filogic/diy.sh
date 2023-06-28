#!/bin/bash

shopt -s extglob

sh -c "curl -sfL https://patch-diff.githubusercontent.com/raw/openwrt/openwrt/pull/12820.patch | patch -d './' -p1 --forward"