

SHELL_FOLDER=$(dirname $(readlink -f "$0"))



sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += perl btrfs-progs luci-app-amlogic kmod-brcmfmac wpad-basic-mbedtls iw -luci-app-attendedsysupgrade -luci-app-gpsysupgrade fdisk lsblk/' target/linux/armvirt/Makefile


