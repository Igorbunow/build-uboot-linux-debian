#!/bin/bash

export WORK=$(pwd)
export CROSS_COMPILE=aarch64-linux-gnu-
mkdir -p ${WORK}/fsbl 
cd ${WORK}/fsbl
#cp ${HDF} .
xsct  ${WORK}/gen_fsbl_pmu_2020.tcl
cd ${WORK}
