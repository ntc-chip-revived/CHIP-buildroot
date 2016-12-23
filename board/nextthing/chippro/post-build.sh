#!/bin/bash

TARGET_DIR=$1

cat <<EOF >${TARGET_DIR}/etc/issue
Welcome to CHIP Pro Buildroot-fcc build $(date +%Y%m%d) rev $(git rev-list --abbrev-commit --abbrev=8 -1 HEAD)

EOF
