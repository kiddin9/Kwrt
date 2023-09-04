#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

sh -c curl -sfL https://patch-diff.githubusercontent.com/raw/openwrt/openwrt/pull/11542.patch | git apply -p1

sed -i "s/^TARGET_DEVICES /# TARGET_DEVICES /" target/linux/bcm53xx/image/Makefile
sed -i "s/# TARGET_DEVICES += phicomm_k3/TARGET_DEVICES += phicomm_k3/" target/linux/bcm53xx/image/Makefile
sed -i "s/# TARGET_DEVICES += asus_rt-ac88u/TARGET_DEVICES += asus_rt-ac88u/" target/linux/bcm53xx/image/Makefile
sed -i "s/# TARGET_DEVICES += dlink_dir-885l/TARGET_DEVICES += dlink_dir-885l/" target/linux/bcm53xx/image/Makefile
sed -i "s/DEVICE_PACKAGES := \$(BRCMFMAC_4366C0) \$(USB3_PACKAGES)/DEVICE_PACKAGES := \$(BRCMFMAC_4366C0) \$(USB3_PACKAGES) k3screenctrl/" target/linux/bcm53xx/image/Makefile