#!/bin/bash

export WORK=$(pwd)
export CROSS_COMPILE=aarch64-linux-gnu-
export ARCH=arm64
export INSTALL_MOD_PATH=./../bootbin/modules
LOCAL_DTS_PATH="./arch/arm64/boot/dts/xilinx/"
export LIN_HEADERS_PATH=./../linux_headers

mkdir -p bootbin

cd ${WORK}/linux-xlnx

rm -rf $INSTALL_MOD_PATH
rm -rf $INSTALL_HDR_PATH

mkdir -p $INSTALL_MOD_PATH
mkdir -p $INSTALL_HDR_PATH
KERNEL_VER=`make kernelversion`
make distclean
make mrproper

echo ""
echo "@@@ Adding custom kernel ${KERNEL_VER} ${ARCH}  defconfig"
cp ./../configs/linux/xilinx_ulrascale_debug_defconfig ./arch/arm64/configs/

echo ""
echo "@@@ Adding custom Dts"
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
echo ""
echo "@@@ Building kernel ${KERNEL_VER} ${ARCH}  modules"
make -j`nproc` modules
echo ""
echo "@@@ Installing kernel ${KERNEL_VER} ${ARCH}  modules to ${INSTALL_MOD_PATH}"
make -j`nproc` modules_install
echo ""
echo "@@@ Building kernel ${KERNEL_VER} ${ARCH}  headers"
make -j`nproc` headers
echo ""
echo "@@@ Installing kernel ${KERNEL_VER} ${ARCH} headers to ${LIN_HEADERS_PATH}"
make -j`nproc` headers_install INSTALL_HDR_PATH=${LIN_HEADERS_PATH}
#make
cd ${LIN_HEADERS_PATH}
echo ""
echo "@@@ Comperssing kernel ${KERNEL_VER} ${ARCH} headers..."
tar cJf linux_${KERNEL_VER}_${ARCH}_headers.tar.bz2 *
cd ${WORK}

