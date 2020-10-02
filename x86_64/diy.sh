#!/bin/bash
sed -i 's/Os/O2/g' include/target.mk
sed -i "s/+luci\( \|$\)//g"  package/*/*/*/Makefile