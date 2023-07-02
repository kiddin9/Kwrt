#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2024-12-06/" package/network/config/netifd/Makefile