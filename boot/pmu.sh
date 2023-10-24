#!/bin/bash

export WORK=$(pwd)
export CROSS_COMPILE=aarch64-linux-gnu-
mkdir ${WORK}/pmc; cd ${WORK}/pmc
cp ${HDF} .
hsi -source ${WORK}/gen_pmu.tcl
cd ${WORK}
