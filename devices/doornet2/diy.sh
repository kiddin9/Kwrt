#!/bin/bash
SHELL_FOLDER=$(dirname $(readlink -f "$0"))
bash $SHELL_FOLDER/../nanopi-r2s/diy.sh

find "$SHELL_FOLDER/../nanopi-r2s/patches" -type f -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 -E --forward"