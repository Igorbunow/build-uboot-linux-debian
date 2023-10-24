#!/bin/bash

ARCH=arm64
REPO=http://httpredir.debian.org/debian/
VERSION=stable
BUILD_DIR=./root
PACKAGES="cloud-guest-utils kmod mtd-utils openssh-server vim mc ethtool bind9-dnsutils initscripts isc-dhcp-client xxd htop net-tools logrotate btrfs-progs e2fsprogs exfatprogs util-linux fdisk u-boot-tools parted fdisk nfs-common ftp-ssl ftp usbutils lsof lsscsi lshw pciutils i2c-tools spi-tools iptables"

mkdir -p ${BUILD_DIR}

debootstrap --arch=$ARCH --include="${PACKAGES}"  $VERSION $BUILD_DIR  $REPO
ln -s "$(which qemu-arm64-static)" ./root/qemu-arm64-static
rm ./root/usr/lib/binfmt.d/python3.11.conf

echo "" > ./root/info
echo "debian ${VERSION} ${ARCH}" >> ./root/info
echo "packages: ${PACKAGES}" >> ./root/info

