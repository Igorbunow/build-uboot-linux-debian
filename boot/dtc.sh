#!/bin/bash

#sudo apt install -y pkg-config libyaml-dev # if required
export WORK=$(pwd)
mkdir -p ${WORK}/dtc; cd ${WORK}/dtc
make -j`nproc`
cd ${WORK}
