

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

mv -f target/linux/armvirt target/linux/armvirt_pcat

#svn co https://github.com/photonicat/rockchip_rk3568_openwrt_packages/trunk/utils/pcat-manager feeds/packages/utils/pcat-manager
#ln -sf $SHELL_FOLDER/../../feeds/packages/utils/pcat-manager package/feeds/packages/pcat-manager


svn co https://github.com/photonicat/rockchip_rk3568_openwrt/trunk/files files

mv -f $SHELL_FOLDER/network files/etc/config/



