# Make Debian Linux arm64

This repo contains scripts, helps you to make debian from binary packages via debootstrap. 

![Debian boot screen](/doc/img/debian/debian_into_i.png)

## Install packages

```bash
apt install qemu-user-static debootstrap
```

## Config scripts

1) Add files into `./files` wich you need to replace in target system
2) Open and correct `2_debian_bootstrap.sh` with packages, wich you need
3) Open and correct in `4_copy_and_config.sh` root and user's password if need
 serial-getty@.service - uses for root autologin via serial


## Run scripts

1) ./2_debian_bootstrap.sh
2) ./3_copy_kernel_modules.sh
3) ./4_copy_and_config.sh

# *Config system and add aditional packages if need (not required item)

For example, let's add packages to make this image developer variant

## Bindind devices

```bash
mount --bind /dev ./root/dev/
mount --bind /sys ./root/sys/
mount --bind /proc ./root/proc/
mount --bind /dev/pts ./root/dev/pts

```

For example, let's install aditional packages:

##Chroot in system:
```bash
chroot ./root
```

##Install packages:
```bash
PACKAGES="valgrind build-essential clang u-boot-tools cmake git subversion tcpdump kbuild nmap wget libboost-all-dev linux-headers-arm64 minicom picocom p7zip-full gzip zstd bzip2"
apt update
apt install ${PACKAGES}
echo "packages: ${PACKAGES}" >> /info
apt clean
```

##Exit chroot:
```bash
exit
```

## UnBindind devices
```bash
umount ./root/sys
umount ./root/proc
umount ./root/dev/pts
umount ./root/dev

```

## Fix failing `binfmt.service`:
rm -rf ./root/usr/lib/binfmt.d/python3.11.conf
rm -rf ./root/usr/lib/binfmt.d/llvm-14-runtime.binfmt.conf

## Clean logs:

```bash
rm -rf ./root/var/log/apt/*
echo -n > ./root/var/log/alternatives.log
echo -n > ./root/var/log/dpkg.log
echo -n > ./root/root/.bash_history
rm ./root/var/cache/apt/archives/lock
```

# Create sd card disk image

Our task - create minimal disk image, which be extended on target's sd card to maximum size

## Calculate minimal image size

In our case, will make for boot partishion (first fat partishin with fsbl, uboot, kernel & bitsreem) of 512Mb (saving debug variants and other). You may do it 256Mb, 128Mb or smaller if need.
For second partishion we selected btrfs - compression + copy-on-write user card's source more safely. But you may select ext4 if need.
Let's see root partishion size:
```bash
du -h -d 1
```
The result is 465Mb in now package size. So, we can select minimum root partishion size 512Mb

## Creating target image

So, we calculated, that we need in 1G disk image size (512Mb boot + 512Mb root)

### Create blank disk image:

```bash
dd if=/dev/zero bs=1M count=1024 of=ultrascale_short.img
sync;
```

### Map partishions:

```bash
fdisk -c=dos ultrascale_short.img
```

And then:

- create new boot partishion 'n'
- make it primary 'p'
- part number '1'
- first sector '63'
- last sector '1048576'
- mark bootable 'a'
- create root partishion 'n'
- make root primary 'p'
- part root number '2'
- first sector '1048577'
- last sector '2097151'
- write changes and exit 'w'
- select all free space for it


### Moint disk image

```bash
losetup --partscan --find --show ultrascale_short.img
```

In our case it determinate as `loop**0**`. In you case it may be differ. So, we'll be use `loop**XX**`

Look at mounted partishions:
```bash
ls /dev | grep loop**XX**
```
