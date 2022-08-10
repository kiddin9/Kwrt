

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
bash $SHELL_FOLDER/../common/kernel_5.15.sh

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += perl btrfs-progs autocore-arm luci-app-amlogic kmod-brcmfmac wpad-basic-wolfssl iw -luci-app-attendedsysupgrade -luci-app-gpsysupgrade fdisk lsblk kmod-usb2 kmod-usb3/' target/linux/armvirt/Makefile

echo '
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/armvirt/64/config-5.15

