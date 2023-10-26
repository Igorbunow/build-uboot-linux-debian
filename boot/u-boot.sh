#!/bin/bash

export WORK=$(pwd)
export CROSS_COMPILE=aarch64-linux-gnu-
export ARCH=aarch64
LOCAL_DTS_PATH="./arch/arm/dts/"

cd ${WORK}/u-boot-xlnx
make distclean
#cp ./../configs/uboot/xilinx_ulrascale_debug_defconfig ./arch/arm64/configs/

echo "Adding custom UBoot defconfig"
cp ./../configs/uboot/xilinx_ulrascale_debug_defconfig ./configs/

echo "Adding custom Dts"
cp ./../configs/dts/* ${LOCAL_DTS_PATH}
git checkout ${LOCAL_DTS_PATH}Makefile
cat ./../configs/dts/Makefile.in > ${LOCAL_DTS_PATH}Makefile_
cat ${LOCAL_DTS_PATH}Makefile >> ${LOCAL_DTS_PATH}Makefile_
mv ${LOCAL_DTS_PATH}Makefile_  ${LOCAL_DTS_PATH}Makefile
rm ${LOCAL_DTS_PATH}Makefile.in
#cp ./../configs/uboot/zynqmp-u-boot.dtsi ./arch/arm/dts/
#xilinx_zynqmp_virt_defconfig
#make savedefconfig
#cp ./../configs/uboot/.config ./


echo " " >> ./drivers/mtd/Kconfig
echo "config SYS_FLASH_BASE"  >> ./drivers/mtd/Kconfig
echo '	hex "Flash base address"'  >> ./drivers/mtd/Kconfig
echo "	default 0xE2000000 if ARCH_SUNXI || ARCH_ZYNQ	"  >> ./drivers/mtd/Kconfig
echo "	default 0xE2000000 if ARCH_SUNXI || ARCH_ZYNQMP	"  >> ./drivers/mtd/Kconfig
echo "	help"  >> ./drivers/mtd/Kconfig
echo "	  Physical start address of Flash memory"  >> ./drivers/mtd/Kconfig

make xilinx_ulrascale_debug_defconfig
export DEVICE_TREE="zynqmp-zcu106-revA"



make -j`nproc`
cd ${WORK}

