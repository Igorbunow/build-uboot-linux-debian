#!/bin/bash

export WORK=$(pwd)
export CROSS_COMPILE=aarch64-linux-gnu-
export ARCH=arm64
export INSTALL_MOD_PATH=./../bootbin/modules
LOCAL_DTS_PATH="./arch/arm64/boot/dts/xilinx/"

mkdir -p bootbin

cd ${WORK}/linux-xlnx
mkdir -p $INSTALL_MOD_PATH
make distclean
make mrproper

echo "Adding custom kernel defconfig"
cp ./../configs/linux/xilinx_ulrascale_debug_defconfig ./arch/arm64/configs/

echo "Adding custom Dts"
cp ./../configs/dts/* ${LOCAL_DTS_PATH}
git checkout ${LOCAL_DTS_PATH}Makefile
cat ./../configs/dts/Makefile.in > ${LOCAL_DTS_PATH}Makefile_
cat ${LOCAL_DTS_PATH}Makefile >> ${LOCAL_DTS_PATH}Makefile_
mv ${LOCAL_DTS_PATH}Makefile_  ${LOCAL_DTS_PATH}Makefile
rm ${LOCAL_DTS_PATH}Makefile.in

#make xilinx_zynqmp_defconfig
make xilinx_ulrascale_debug_defconfig
#make menuconfig
make -j`nproc`
make modules
make modules_install
#make 
cd ${WORK}

