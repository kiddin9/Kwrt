#!/bin/bash

sed -i "/bin\/upx/d" package/*/*/*/Makefile
sed -i "s/linux\//linux64\//g" package/*/*/coremark/Makefile
rm -Rf feeds/custom/luci/mt
rm -Rf files/usr/share/amule/webserver/AmuleWebUI-Reloaded && git clone https://github.com/MatteoRagni/AmuleWebUI-Reloaded files/usr/share/amule/webserver/AmuleWebUI-Reloaded
