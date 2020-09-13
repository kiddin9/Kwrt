#!/bin/bash

sed -i "/bin\/upx/d" package/*/*/*/Makefile
rm -Rf feeds/custom/mt
