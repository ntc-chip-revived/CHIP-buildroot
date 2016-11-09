#!/bin/bash

ROOT_DIR="$(pwd)"
BOARD_DIR=${ROOT_DIR}/board/nextthing/chip

MKIMAGE=${HOST_DIR}/usr/bin/mkimage

# ${MKIMAGE} -f ${BOARD_DIR}/bootimg.its ${BINARIES_DIR}/bootimg.itb

cat <<-EOF >> ${TARGET_DIR}/etc/mdev.conf
sd[a-z][0-9]* 0:0 0660 *(/opt/bin/automount $MDEV)
mmcblk[0-9]p[0-9] 0:0 0660 *(/opt/bin/automount $MDEV)
EOF

echo "TERM=xterm" | tee -a ${TARGET_DIR}/etc/profile
