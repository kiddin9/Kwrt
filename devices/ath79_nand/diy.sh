#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sed -i '/# start dockerd/,/# end dockerd/d' .config