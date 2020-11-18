#!/usr/bin/env bash
#
# Copyright (c) 2018-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/aria2.conf
# File name：tracker.sh
# Description: Get BT trackers and add to Aria2
# Version: 3.0
#
# BT tracker is provided by the following project.
# https://github.com/XIU2/TrackersListCollection
#
# Fallback URLs provided by jsDelivr
# https://www.jsdelivr.com
#

RED_FONT_PREFIX="\033[31m"
GREEN_FONT_PREFIX="\033[32m"
YELLOW_FONT_PREFIX="\033[1;33m"
LIGHT_PURPLE_FONT_PREFIX="\033[1;35m"
FONT_COLOR_SUFFIX="\033[0m"
INFO="[${GREEN_FONT_PREFIX}INFO${FONT_COLOR_SUFFIX}]"
ERROR="[${RED_FONT_PREFIX}ERROR${FONT_COLOR_SUFFIX}]"
ARIA2_CONF=${1:-aria2.conf}
DOWNLOADER="curl -fsSL --connect-timeout 3 --max-time 3 --retry 2"

DATE_TIME() {
    date +"%m/%d %H:%M:%S"
}

GET_TRACKERS() {
    echo && echo -e "$(DATE_TIME) ${INFO} Get BT trackers ..."
    if [[ -z "${CUSTOM_TRACKER_URL}" ]]; then
        TRACKER=$(
            ${DOWNLOADER} https://trackerslist.com/all_aria2.txt ||
                ${DOWNLOADER} https://cdn.jsdelivr.net/gh/XIU2/TrackersListCollection@master/all_aria2.txt ||
                ${DOWNLOADER} https://trackers.p3terx.com/all_aria2.txt
        )
    else
        TRACKER=$(${DOWNLOADER} ${CUSTOM_TRACKER_URL} | awk NF | sed ":a;N;s/\n/,/g;ta")
    fi
    [[ -z "${TRACKER}" ]] && {
        echo
        echo -e "$(DATE_TIME) ${ERROR} Unable to get trackers, network failure or invalid links." && exit 1
    }
}

ECHO_TRACKERS() {
    echo -e "
--------------------[BitTorrent Trackers]--------------------
${TRACKER}
--------------------[BitTorrent Trackers]--------------------
"
}

ADD_TRACKERS() {
    echo -e "$(DATE_TIME) ${INFO} Adding BT trackers to Aria2 configuration file ${LIGHT_PURPLE_FONT_PREFIX}${ARIA2_CONF}${FONT_COLOR_SUFFIX} ..." && echo
    if [ ! -f ${ARIA2_CONF} ]; then
        echo -e "$(DATE_TIME) ${ERROR} '${ARIA2_CONF}' does not exist."
        exit 1
    else
        [ -z $(grep "bt-tracker=" ${ARIA2_CONF}) ] && echo "bt-tracker=" >>${ARIA2_CONF}
        sed -i "s@^\(bt-tracker=\).*@\1${TRACKER}@" ${ARIA2_CONF} && echo -e "$(DATE_TIME) ${INFO} BT trackers successfully added to Aria2 configuration file !"
    fi
}

ADD_TRACKERS_RPC() {
    if [[ "${RPC_SECRET}" ]]; then
        RPC_PAYLOAD='{"jsonrpc":"2.0","method":"aria2.changeGlobalOption","id":"P3TERX","params":["token:'${RPC_SECRET}'",{"bt-tracker":"'${TRACKER}'"}]}'
    else
        RPC_PAYLOAD='{"jsonrpc":"2.0","method":"aria2.changeGlobalOption","id":"P3TERX","params":[{"bt-tracker":"'${TRACKER}'"}]}'
    fi
    curl "${RPC_ADDRESS}" -fsSd "${RPC_PAYLOAD}" || curl "https://${RPC_ADDRESS}" -kfsSd "${RPC_PAYLOAD}"
}

ADD_TRACKERS_RPC_STATUS() {
    RPC_RESULT=$(ADD_TRACKERS_RPC)
    [[ $(echo ${RPC_RESULT} | grep OK) ]] &&
        echo -e "$(DATE_TIME) ${INFO} BT trackers successfully added to Aria2 !" ||
        echo -e "$(DATE_TIME) ${ERROR} Network failure or Aria2 RPC interface error!"
}

ADD_TRACKERS_REMOTE_RPC() {
    echo -e "$(DATE_TIME) ${INFO} Adding BT trackers to remote Aria2: ${LIGHT_PURPLE_FONT_PREFIX}${RPC_ADDRESS%/*}${FONT_COLOR_SUFFIX} ..." && echo
    ADD_TRACKERS_RPC_STATUS
}

ADD_TRACKERS_LOCAL_RPC() {
    if [ ! -f ${ARIA2_CONF} ]; then
        echo -e "$(DATE_TIME) ${ERROR} '${ARIA2_CONF}' does not exist."
        exit 1
    else
        RPC_PORT=$(grep ^rpc-listen-port ${ARIA2_CONF} | cut -d= -f2-)
        RPC_SECRET=$(grep ^rpc-secret ${ARIA2_CONF} | cut -d= -f2-)
        [[ ${RPC_PORT} ]] || {
            echo -e "$(DATE_TIME) ${ERROR} Aria2 configuration file incomplete."
            exit 1
        }
        RPC_ADDRESS="localhost:${RPC_PORT}/jsonrpc"
        echo -e "$(DATE_TIME) ${INFO} Adding BT trackers to Aria2 ..." && echo
        ADD_TRACKERS_RPC_STATUS
    fi
}

[ $(command -v curl) ] || {
    echo -e "$(DATE_TIME) ${ERROR} curl is not installed."
    exit 1
}

if [ "$1" = "cat" ]; then
    GET_TRACKERS
    ECHO_TRACKERS
elif [ "$1" = "RPC" ]; then
    RPC_ADDRESS="$2/jsonrpc"
    RPC_SECRET="$3"
    GET_TRACKERS
    ECHO_TRACKERS
    ADD_TRACKERS_REMOTE_RPC
elif [ "$2" = "RPC" ]; then
    GET_TRACKERS
    ECHO_TRACKERS
    ADD_TRACKERS
    echo
    ADD_TRACKERS_LOCAL_RPC
else
    GET_TRACKERS
    ECHO_TRACKERS
    ADD_TRACKERS
fi

exit 0
