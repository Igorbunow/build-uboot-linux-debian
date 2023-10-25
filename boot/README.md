# Build-ZCU106-Linux

## Pre-requirements

Install related binaries as the following.

```bash
sudo apt install -y pkg-config libyaml-dev
```

Firstly, you must set correct path to you vivado `all.sh`. Reques vivado 2020 and later:

```bash
export VIVADO=/xxx/2020.1/settings64.sh
```

## Build Linux and related files

### Add you own configs, if need

uboot defconfig into `/configs/uboot/xilinx_ulrascale_debug_defconfig`
linux kernel defconfig into `./configs/linux/xilinx_ulrascale_debug_defconfig` 

### Build all

```
sh all.sh
```

### Copy result into boot partishion

You can get required files in `./image/`

Result files:

| File | Descriptin |
|:-|:-|
| BOOT.bin | Fsbl and UBoot |
| boot.scr | UBoot scrip |
| Image | Linux kernel image |
| zynqmp-zcu106-revA.dtb | Target linux kernel dts file |

You need to generate `system.bit` with the help of vivado for you own project 


### Config boot menu

1) Remove `uboot-redund.env` and `uboot.env` from boot partishion

2) Default boot menu able to boot only via SD card:
![UBoot menu with ftp and NFS boot options](/doc/img/uboot/uboot_men_short.png)

3) Connect device via uart, open uart terminal  `/dev/ttyUSB0` in my case, mode 115200-8-N-1
4) If device already booted, press reset button
5) Interrupt boot on message with timer `Hit any key to stop autoboot: `
![UBoot menu with ftp and NFS boot options](/doc/img/uboot/uboot_interrupt.png)

6) Set tftp ip adress and folder:

```
setenv tftp_serverip '192.168.0.112'
setenv tftp_dir /zsu106/
saveenv
reset
```
![UBoot menu with ftp and NFS boot options](/doc/img/uboot/uboot_set_tftp_env.png)

after reboot you'll be watch menu with able to boot via tftp:
![UBoot menu with ftp and NFS boot options](/doc/img/uboot/uboot_men_tftp.png)

7) Set NFS ip adress and folder (if need):

```
setenv nfs_serverip '192.168.0.112'
setenv nfs_dir /tmp/root
saveenv
reset
```
After reboot boot menu will be:
![UBoot menu with ftp and NFS boot options](/doc/img/uboot/uboot_men_tftp_nfs.png)

8) For disable tftp or NFS, you need to remove variable:

tftp: 
```
setenv tftp_serverip
saveenv
reset
```
nfs:
```
setenv nfs_serverip
saveenv
reset
```
9) In case any problem? remove `uboot-redund.env` and `uboot.env` from boot partishion and repeat
   

