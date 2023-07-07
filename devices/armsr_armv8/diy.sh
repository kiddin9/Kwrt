

SHELL_FOLDER=$(dirname $(readlink -f "$0"))



sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += -luci-app-attendedsysupgrade -luci-app-gpsysupgrade/' target/linux/armsr/Makefile


