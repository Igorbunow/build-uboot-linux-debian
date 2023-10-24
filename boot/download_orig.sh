#!/bin/bash

echo " "
echo " "
echo " "
echo "==========================="
echo "Cloning UBOOT"
git clone --depth=1 --branch master https://github.com/Xilinx/u-boot-xlnx.git
cd u-boot-xlnx
git checkout 50f4accf971fe2708a4b4fd515bb5542c50e7f5d
cd ..

echo " "
echo " "
echo " "
echo "==========================="
echo "Cloning Linux Kernel"
git clone --depth=1 --branch master https://github.com/Xilinx/linux-xlnx.git
cd linux-xlnx
git checkout c8b3583bc86352009c6ac61e2ced0e12118f8ebb
cd ..

echo " "
echo " "
echo " "
echo "==========================="
echo "Cloning Linux device tree script"
git clone --depth=1 --branch master https://github.com/Xilinx/device-tree-xlnx.git
cd device-tree-xlnx
git checkout f725aaecffb806aff8dc081b6ab508ce7bb1fc3d
cd ..

echo " "
echo " "
echo " "
echo "==========================="
echo "Cloning Linux device tree"
git clone --depth=1 --branch master https://git.kernel.org/pub/scm/utils/dtc/dtc.git
cd dtc
git checkout 2283dd78eff5b37a092988e04fd873b040ad27c6
cd ..

echo " "
echo " "
echo " "
echo "==========================="
echo "Cloning ARM trusted firmware"
git clone --depth=1 --branch master https://github.com/Xilinx/arm-trusted-firmware.git
cd arm-trusted-firmware
git checkout 04013814718e870261f27256216cd7da3eda6a5d
cd ..

#git clone https://github.com/Xilinx/xen.git
#git clone https://github.com/Xilinx/embeddedsw.git
