#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

function git_clone_path() {
          branch="$1" rurl="$2" localdir="gitemp" && shift 2
          git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
          if [ "$?" != 0 ]; then
            echo "error on $rurl"
            return 0
          fi
          cd $localdir
          git sparse-checkout init --cone
          git sparse-checkout set $@
         mv -n $@/* ../$@/ || cp -rf $@ ../$(dirname "$@")/
		  cd ..
		  rm -rf gitemp
          }

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/generic/hack-6.1

git_clone_path master https://github.com/coolsnowwolf/lede target/linux/meson

rm -rf package/feeds/kiddin9/quectel_Gobinet

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch -o target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch



