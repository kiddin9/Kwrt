
#!/bin/bash

shopt -s extglob

rm -rf target/linux/generic target/linux/airoha package/kernel package/firmware package/boot

git_clone_path airoha-gemtek-xr1710g https://github.com/akorshun/openwrt target/linux/generic target/linux/airoha package/boot package/firmware package/kernel

git_clone_path master https://github.com/coolsnowwolf/lede mv target/linux/generic/hack-6.18

wget -N https://github.com/akorshun/openwrt/raw/refs/heads/airoha-gemtek-xr1710g/include/kernel.mk -P include/

wget -N https://github.com/akorshun/openwrt/raw/refs/heads/airoha-gemtek-xr1710g/include/netfilter.mk -P include/

wget -N https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.18/613-netfilter_optional_tcp_window_check.patch -P target/linux/generic/pending-6.18/

rm -rf package/feeds/kiddin9/{quectel_QMI_WWAN,simcom_QMI_WWAN,fibocom_QMI_WWAN,quectel_MHI,rkp-ipid} package/feeds/packages/{v4l2loopback,libpfring,xtables-addons}