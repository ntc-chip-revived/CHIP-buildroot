#!/bin/bash

IMAGES_DIR=$1
NAND_CONFIG=$2
UBOOT_ENV=$3
UBOOT_ENV_SIZE=$4

BUILDROOT_DIR=${IMAGES_DIR%/}
BUILDROOT_DIR=${BUILDROOT_DIR%/*/*}

echo "IMAGES_DIR=${IMAGES_DIR}"
echo "BUILDROOT_DIR=${BUILDROOT_DIR}"

mk_buildroot_images -u "$UBOOT_ENV" -S "$UBOOT_ENV_SIZE" -N nand_configs/$NAND_CONFIG -d "${IMAGES_DIR}" "${BUILDROOT_DIR}"

cp "${BUILDROOT_DIR}/board/nextthing/common/flash.sh" "${IMAGES_DIR}/flash"
