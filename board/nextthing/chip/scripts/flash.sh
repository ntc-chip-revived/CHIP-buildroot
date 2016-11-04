#!/bin/bash
BR_OUTPUT_DIR="${1}"
sunxi-fel uboot ${BR_OUTPUT_DIR}/images/u-boot-sunxi-with-spl.bin
sleep 8
fastboot -i 0x1f3a erase UBI
fastboot -i 0x1f3a flash UBI ${BR_OUTPUT_DIR}/images/rootfs.ubi.sparse
fastboot -i 0x1f3a continue -u
