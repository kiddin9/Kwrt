#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf devices/common/patches/{imagebuilder.patch,iptables.patch,kernel-defaults.patch,targets.patch}

