#!/bin/bash

export VIVADO=/opt/Electro/FPGA/Xilinx/Vivado/2023.1/settings64.sh
#export HDF=~/Downloads/rdf0428-zcu106-vcu-trd-2019-1_v2/pl/prebuilt/vcu_trd/vcu_trd_wrapper.hdf 

source ${VIVADO}
echo ""
echo ""
echo ""
echo "*********** Download sources ***********"
sh download_orig.sh
echo ""
echo ""
echo ""
echo "*********** Build fsbl & PMU ***********"
sh fsbl_pmu_2020.sh
echo ""
echo ""
echo ""
echo "*********** Build dtc(host utility) ***********"
sh dtc.sh
#echo "Build PMU"
#sh pmu.sh
echo ""
echo ""
echo ""
echo "*********** Build ARM trusted firmware ***********"
sh atf.sh
echo ""
echo ""
echo ""
echo "*********** Build U-boot ***********"
sh u-boot.sh
echo ""
echo ""
echo ""
echo "*********** Build Linux kernel ***********"
sh kernel.sh
echo ""
echo ""
echo ""
echo "*********** Build BOOT.bin ***********"
sh bootbin.sh
echo ""
echo ""
echo ""
echo "*********** Build boot.scr ***********"
echo ""
echo ""
echo ""
sh bootscript.sh
echo ""
echo ""
echo ""
echo "*********** Copy required files into image/ ***********"
sh image.sh
echo ""
echo ""
echo ""
echo "*********** Build finished! ***********"
echo "Put image/modules into you root file sistem partishion and other to fat boot"
