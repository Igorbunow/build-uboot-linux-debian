#!/bin/bash

export WORK=$(pwd)
export CROSS_COMPILE=aarch64-linux-gnu-
cd ${WORK}/arm-trusted-firmware
make PLAT=zynqmp RESET_TO_BL31=1 -j`nproc`
cd ${WORK}
