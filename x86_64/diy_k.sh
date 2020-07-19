#!/bin/bash

sed -i "/bin\/upx/d" package/*/*/*/Makefile
sed -i "s/linux\//linux64\//g" package/*/*/coremark/Makefile
rm -Rf feeds/custom/luci/mt
