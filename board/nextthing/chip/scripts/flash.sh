#!/bin/bash
FLASH_SPL=false
FLASH_UBOOT=false
BR_OUTPUT_DIR="${1}"
BOARD_DIR="${BOARD_DIR:-${BR_OUTPUT_DIR}/../board/nextthing/chip}"

if [ "${2}" == "--bootloader" ]; then
	IMAGE_TYPE="${3:-Toshiba-SLC-4G-TC58NVG2S0H}"
	FLASH_SPL=true
	FLASH_UBOOT=true
fi

sunxi-fel uboot ${BR_OUTPUT_DIR}/images/u-boot-sunxi-with-spl.bin
sleep 4

if [ -n "${IMAGE_TYPE}" ]; then
        IMAGE_CONFIG_FILE="${BOARD_DIR}/configs/nand/${IMAGE_TYPE}.config"
	echo "Loading config: ${IMAGE_CONFIG_FILE}"
        if [ ! -f "${IMAGE_CONFIG_FILE}" ]; then
                echo -e "Selected NAND type: ${IMAGE_TYPE} but config file does not exist:"
                echo -e "\t${IMAGE_CONFIG_FILE}"
                exit 1
        fi

        source "${IMAGE_CONFIG_FILE}"

	ebsize=`printf %x $NAND_ERASE_BLOCK_SIZE`
	psize=`printf %x $NAND_PAGE_SIZE`
	osize=`printf %x $NAND_OOB_SIZE`
	spl=spl-$ebsize-$psize-$osize.bin

	echo "SPL: $spl"
	if $FLASH_SPL; then
		fastboot -i 0x1f3a erase spl
		fastboot -i 0x1f3a flash spl ${BR_OUTPUT_DIR}/images/$spl
		fastboot -i 0x1f3a erase spl-backup
		fastboot -i 0x1f3a flash spl-backup ${BR_OUTPUT_DIR}/images/$spl
	fi
	
	if $FLASH_UBOOT; then
		fastboot -i 0x1f3a erase uboot
		fastboot -i 0x1f3a flash uboot ${BR_OUTPUT_DIR}/images/uboot-$ebsize.bin
	fi

fi
fastboot -i 0x1f3a erase UBI
fastboot -i 0x1f3a flash UBI ${BR_OUTPUT_DIR}/images/rootfs.ubi.sparse
fastboot -i 0x1f3a continue -u
