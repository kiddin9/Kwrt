#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sed -i '/# start dockerd/,/# end dockerd/d' .config

rm -rf feeds/kiddin9/xtables-wgobfs
