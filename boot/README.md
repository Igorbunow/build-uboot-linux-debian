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
