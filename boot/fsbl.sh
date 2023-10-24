#!/bin/bash

export WORK=$(pwd)
export CROSS_COMPILE=aarch64-linux-gnu-
mkdir -p ${WORK}/fsbl; cd ${WORK}/fsbl
cp ${HDF} .
hsi -source ${WORK}/gen_fsbl.tcl
cd ${WORK}
