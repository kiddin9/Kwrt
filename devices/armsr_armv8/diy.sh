

SHELL_FOLDER=$(dirname $(readlink -f "$0"))


#rm -rf package/feeds/kiddin9/rtl8188eu package/feeds/kiddin9/rtl8192eu package/feeds/kiddin9/rtl8812au-ac

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-diskman automount/' target/linux/armsr/Makefile


