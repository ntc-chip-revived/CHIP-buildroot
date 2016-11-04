#!/bin/bash

ROOT_DIR="$(pwd)"
BOARD_DIR=${ROOT_DIR}/board/nextthing/chip

MKIMAGE=${HOST_DIR}/usr/bin/mkimage

${MKIMAGE} -f ${BOARD_DIR}/bootimg.its ${BINARIES_DIR}/bootimg.itb

