#!/bin/bash

export WORK=$(pwd)
mkdir -p ${WORK}/image; cd ${WORK}/image
cp ${WORK}/bootbin/BOOT.bin .
cp ${WORK}/linux-xlnx/arch/arm64/boot/Image .
cp ${WORK}/linux-xlnx/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-custom.dtb ./system.dtb
cp ${WORK}/boot.scr .
cp -r ${WORK}/bootbin/modules .
