#!/bin/bash

export WORK=$(pwd)
export CROSS_COMPILE=aarch64-linux-gnu-
export ARCH=arm64
export INSTALL_MOD_PATH=./../bootbin/modules

mkdir -p bootbin

cd ${WORK}/linux-xlnx
mkdir -p $INSTALL_MOD_PATH
make distclean
make mrproper
cp ./../configs/linux/xilinx_ulrascale_debug_defconfig ./arch/arm64/configs/
#make xilinx_zynqmp_defconfig
make xilinx_ulrascale_debug_defconfig
#make menuconfig
make -j`nproc`
make modules
make modules_install
#make 
cd ${WORK}

