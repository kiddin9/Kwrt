FROM scratch

MAINTAINER Kiddin9 "https://github.com/kiddin9/OpenWrt_x86-r2s-r4s"

ADD openwrt/bin/targets/*/*/*rootfs*.tar.gz /

RUN if [[ -f /*r2s* && -f /*r4s* ]] ; then rm -rf /*{r2c,r4s}* ; fi
