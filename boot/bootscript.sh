#!/bin/bash

export WORK=$(pwd)

${WORK}/u-boot-xlnx/tools/mkimage \
 -A arm64 \
 -O linux \
 -T script \
 -C none \
 -a 0 \
 -e 0 \
 -n "boot.scr" \
 -d ${WORK}/boot.script boot.scr
