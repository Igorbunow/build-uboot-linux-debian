# Build-ZCU106-Linux

This repo contains scripts, helps you to build you own boot image from sources and make debian from binary packages via debootstrap. Project makes for zunq ultrascale and tested on board zcu106. For most productive debuging, uboot contains menu, helps you to boot from sd card, boot.bin (contains Uboot, fsbl), kernel, bitsteem from dts and root file system via NFS. So, for fast debuding bitstream, dts, kernel image may be replaced separaply without runing any scripts

## Build boot imaged

Menu sample:

![UBoot menu with ftp and NFS boot options](/doc/img/uboot/uboot_men_tftp_nfs.png)

Resulted files are:

| File | Descriptin |
|:-|:-|
| BOOT.bin | Fsbl and UBoot |
| boot.scr | UBoot scrip |
| Image | Linux kernel image |
| system.bit | Target FPGA bitsteam |
| zynqmp-zcu106-revA.dtb | Target linux kernel dts file |


[create boot fsbl uboot and linux kernel](boot/README.md)



## Build debian from amd64 binaries

[build debian via debootstrap](debian/README.md)

![Debian boot screen](/doc/img/debian/debian_into_i.png)
