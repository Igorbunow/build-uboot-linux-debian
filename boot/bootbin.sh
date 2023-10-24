#!/bin/bash

export WORK=$(pwd)
mkdir -p ${WORK}/bootbin; cd ${WORK}/bootbin
cp ${WORK}/fsbl/fsb_pmu/zynqmp_fsbl/Release/zynqmp_fsbl.elf fsbl.elf
cp ${WORK}/fsbl/fsb_pmu/zynqmp_pmufw/Release/zynqmp_pmufw.elf pmufw.elf
cp ${WORK}/arm-trusted-firmware/build/zynqmp/release/bl31/bl31.elf .
cp ${WORK}/u-boot-xlnx/u-boot.elf .
bootgen -image ${WORK}/boot.bif -arch zynqmp -w -o i BOOT.bin
 
