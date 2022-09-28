#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/meson target/linux/meson

