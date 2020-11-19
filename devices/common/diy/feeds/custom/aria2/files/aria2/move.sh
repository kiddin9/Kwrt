#!/usr/bin/env bash
#
# Copyright (c) 2018-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/aria2.conf
# File name：move.sh
# Description: Move files after Aria2 download is complete
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

TASK_INFO() {
    echo -e "
-------------------------- [${YELLOW_FONT_PREFIX}Task Infomation${FONT_COLOR_SUFFIX}] --------------------------
${LIGHT_PURPLE_FONT_PREFIX}Task GID:${FONT_COLOR_SUFFIX} ${TASK_GID}
${LIGHT_PURPLE_FONT_PREFIX}Number of Files:${FONT_COLOR_SUFFIX} ${FILE_NUM}
${LIGHT_PURPLE_FONT_PREFIX}First File Path:${FONT_COLOR_SUFFIX} ${FILE_PATH}
${LIGHT_PURPLE_FONT_PREFIX}Task File Name:${FONT_COLOR_SUFFIX} ${TASK_FILE_NAME}
${LIGHT_PURPLE_FONT_PREFIX}Task Path:${FONT_COLOR_SUFFIX} ${TASK_PATH}
${LIGHT_PURPLE_FONT_PREFIX}Aria2 Download Directory:${FONT_COLOR_SUFFIX} ${ARIA2_DOWNLOAD_DIR}
${LIGHT_PURPLE_FONT_PREFIX}Custom Download Directory:${FONT_COLOR_SUFFIX} ${DOWNLOAD_DIR}
${LIGHT_PURPLE_FONT_PREFIX}Source Path:${FONT_COLOR_SUFFIX} ${SOURCE_PATH}
${LIGHT_PURPLE_FONT_PREFIX}Destination Path:${FONT_COLOR_SUFFIX} ${DEST_PATH}
${LIGHT_PURPLE_FONT_PREFIX}.aria2 File Path:${FONT_COLOR_SUFFIX} ${DOT_ARIA2_FILE}
-------------------------- [${YELLOW_FONT_PREFIX}Task Infomation${FONT_COLOR_SUFFIX}] --------------------------
"
}

OUTPUT_MOVE_LOG() {
    LOG="${MOVE_LOG}"
    LOG_PATH="${MOVE_LOG_PATH}"
    OUTPUT_LOG
}

DEFINITION_PATH() {
    SOURCE_PATH="${TASK_PATH}"
    if [[ "${DOWNLOAD_DIR}" != "${ARIA2_DOWNLOAD_DIR}" && "${DOWNLOAD_DIR}" =~ "${ARIA2_DOWNLOAD_DIR}" ]]; then
        DEST_PATH="${DEST_DIR}${DEST_PATH_SUFFIX%/*}"
    else
        DEST_PATH="${DEST_DIR}"
    fi
}

MOVE_FILE() {
    echo -e "$(DATE_TIME) ${INFO} Start move files ..."
    TASK_INFO
    mkdir -p "${DEST_PATH}"
    mv -vf "${SOURCE_PATH}" "${DEST_PATH}"
    MOVE_EXIT_CODE=$?
    if [ ${MOVE_EXIT_CODE} -eq 0 ]; then
        MOVE_LOG="$(DATE_TIME) ${INFO} Move done: ${SOURCE_PATH} -> ${DEST_PATH}"
    else
        MOVE_LOG="$(DATE_TIME) ${ERROR} Move failed: ${SOURCE_PATH}"
    fi
    OUTPUT_MOVE_LOG
    DELETE_EMPTY_DIR
}

CHECK_CORE_FILE "$@"
CHECK_PARAMETER "$@"
CHECK_FILE_NUM
CHECK_SCRIPT_CONF
GET_TASK_INFO
GET_DOWNLOAD_DIR
CONVERSION_PATH
DEFINITION_PATH
CLEAN_UP
MOVE_FILE
exit 0
