#!/usr/bin/env bash
#
# Copyright (c) 2018-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/aria2.conf
# File name：delete.sh
# Description: Delete files after Aria2 download error or task removed
# Version: 3.0
#

CHECK_CORE_FILE() {
    CORE_FILE="$(dirname $0)/core"
    if [[ -f "${CORE_FILE}" ]]; then
        . "${CORE_FILE}"
    else
        echo "!!! core file does not exist !!!"
        exit 1
    fi
}

CHECK_RPC_CONECTION() {
    READ_ARIA2_CONF
    if [[ "${RPC_SECRET}" ]]; then
        RPC_PAYLOAD='{"jsonrpc":"2.0","method":"aria2.getVersion","id":"P3TERX","params":["token:'${RPC_SECRET}'"]}'
    else
        RPC_PAYLOAD='{"jsonrpc":"2.0","method":"aria2.getVersion","id":"P3TERX"}'
    fi
    (curl "${RPC_ADDRESS}" -fsSd "${RPC_PAYLOAD}" || curl "https://${RPC_ADDRESS}" -kfsSd "${RPC_PAYLOAD}") >/dev/null
}

DELETE_ON_STOP() {
    if [[ "${TASK_STATUS}" = "error" && "${DELETE_ON_ERROR}" = "true" ]] || [[ "${TASK_STATUS}" = "removed" && "${DELETE_ON_REMOVED}" = "true" ]]; then
        if [[ -f "${TASK_PATH}.aria2" ]]; then
            echo -e "$(DATE_TIME) ${INFO} Download task ${TASK_STATUS}, deleting files..."
            rm -vrf "${TASK_PATH}.aria2" "${TASK_PATH}"
        else
            [[ -e "${TASK_PATH}" ]] &&
                echo -e "$(DATE_TIME) ${WARRING} Skip delete. Download completed files: ${TASK_PATH}" ||
                echo -e "$(DATE_TIME) ${WARRING} Skip delete. File does not exist: ${TASK_PATH}"
        fi
    else
        echo -e "$(DATE_TIME) ${WARRING} Skip delete. Task status invalid: ${TASK_STATUS}"
    fi
}

DELETE_ON_UNKNOWN() {
    if [[ -f "${FILE_PATH}.aria2" ]]; then
        echo -e "$(DATE_TIME) ${INFO} Download task force removed, deleting files..."
        rm -vrf "${FILE_PATH}.aria2" "${FILE_PATH}"
    else
        [[ -e "${FILE_PATH}" ]] &&
            echo -e "$(DATE_TIME) ${WARRING} Skip delete. Download completed files: ${FILE_PATH}" ||
            echo -e "$(DATE_TIME) ${WARRING} Skip delete. File does not exist: ${FILE_PATH}"
    fi
}

DELETE_FILE() {
    if GET_TASK_INFO; then
        GET_DOWNLOAD_DIR
        GET_TASK_STATUS
        CONVERSION_PATH
        DELETE_ON_STOP
        DELETE_DOT_TORRENT
        DELETE_EMPTY_DIR
    elif CHECK_RPC_CONECTION && [[ "${DELETE_ON_UNKNOWN}" = "true" && ${FILE_NUM} -eq 1 ]]; then
        DELETE_ON_UNKNOWN
    else
        echo -e "$(DATE_TIME) ${ERROR} Aria2 RPC interface error!"
        exit 1
    fi
}

CHECK_CORE_FILE "$@"
CHECK_PARAMETER "$@"
CHECK_FILE_NUM
CHECK_SCRIPT_CONF
DELETE_FILE
exit 0
