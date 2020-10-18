sed -i "s/+luci\( \|$\)//g"  package/*/*/*/Makefile
rm -Rf devices/common/patches/syncdial.patch devices/common/patches/disable_flock.patch devices/common/diy/package/network/services
