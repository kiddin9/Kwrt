sed -i "s/+luci\( \|$\)//g"  package/*/*/*/Makefile
rm -Rf common/patches/syncdial.patch common/patches/disable_flock.patch common/diy/package/network/services
