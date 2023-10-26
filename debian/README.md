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

- create new boot partishion **n**
- make it primary **p**
- part number **1**
- first sector **63**
- last sector **1048576**
- mark bootable **a**
- create root partishion **n**
- make root primary **p**
- part root number **2**
- first sector **1048577**
- last sector **2097151**
- write changes and exit **w**


### Moint disk image

```bash
losetup --partscan --find --show ultrascale_short.img
```

In our case it determinate as `loop0`. In you case it may be differ. So, we'll be use `loopX`

Look at mounted partishions:
```bash
ls /dev | grep loopX
```
The result is `loopXp1` and `loopXp2`


### Zero mounted image partishions:

```bash
dd if=/dev/zero of=/dev/loopXp1 bs=4M
dd if=/dev/zero of=/dev/loopXp2 bs=4M
sync;
```

### Map partishion:

```bash
mkfs.vfat -F 32 -n "BOOT" /dev/loop0p1
mkfs.btrfs /dev/loop0p2 -L "root"
sync;
```

if you need in ext4 file system:
```bash
mkfs.ext4 /dev/loop0p2 -L "root"
sync;
```


### Mount created file systems:

In btrfs system case, we can use comperssion. For small embedded device best solution is `lzo` as most speedly.

```bash
mkdir /tmp/root
mkdir /tmp/boot
mount -o compress=lzo /dev/loop0p2 /tmp/root
mount  /dev/loop0p1 /tmp/boot
```


### Copy our boot files and debian rootfs:

#### Copy boot fsbl, U-Boot, dts, Linux kernel to `boot` partishion

copy bitsteam: system.bit -> /tmp/boot

```bash
cp ./../boot/image/BOOT.bin  /tmp/boot
cp ./../boot/image/boot.scr  /tmp/boot
cp ./../boot/image/Image /tmp/boot
cp ./../boot/image/system.dtb /tmp/boot
chmod -R 777 /tmp/boot
sync;
```


#### Copy debian rootfs to `root` partishin

```bash
cp -rpna  ./root/*  /tmp/root/
rm /tmp/root/qemu-arm64-static
sync;
```

if out rootfs is archived:

```bash
tar -C /tmp/root -xjf images/rootfs.tar.bz2
sync;
```


### Unmount our image partishions:

```bash
umount /tmp/boot
umount /tmp/root
sync;
```

Unmount `loopX` device:
```bash
losetup -d /dev/loop0
sync;
```

### Compress created image:

You may use `gz` or `zstd` compression algoritm. `zstd` give better compression, but not supported into `rufus` windows flash prepairing tool. If you prefer windows for image creating, please, select `gz` compression.

#### Compress image

```bash
gzip -9cf ultrascale_short.img > ultrascale_short.img.gz
zstd -16v --ultra --format=zstd ultrascale_short.img -o ultrascale_short.img.zst
```

####  write it on sd card

```bash
zcat ultrascale_short.img.gz | dd bs=8M iflag=fullblock of=/dev/sdxxx status=progress
zstdcat ultrascale_short.img.zst | dd bs=8M iflag=fullblock of=/dev/sdxxx status=progress
```

# First device boot

## Extend file system to full sd card size

run `extend_sd` or separatly commands for **btrfs**:
```bash
growpart /dev/mmcblk0 2
btrfs filesystem resize max /
sync;
```

in **ext2**, **ext3**, **ext4** case:
```bash
growpart /dev/mmcblk0 2
resize2fs /dev/mmcblk0p2
sync;
```

in **xfs** case:
```bash
growpart /dev/mmcblk0 2
xfs_growfs /
sync;
```

and reboot device

For protect login without password do:
```bash
chattr +i /lib/systemd/system/serial-getty@.service
```

## downgrage link speed

In some cases, ed bad cable and etc maybe need to set ethernet speed force 1000->1000
```bash
ethtool -s eth0 speed 100 autoneg off
```


# Boot rootfs via NFS

## Install requered packages

```bash
apt install nfs-kernel-server
```

## Config

```bash
mkdir /srv/nfs
mkdir /srv/nfs/root
```

and copy ./root -> /srv/nfs/root or add it as in config example:


```bash
vim /etc/exports

/srv/nfs   *(no_root_squash,no_subtree_check,rw)
#/srv/nfs   192.168.1.19/24(no_root_squash,no_subtree_check,rw)
```bash

You may set access for all (not recommend) or only for target **192.168.1.19/24** - example target ip, need replace by your

Restart nfs server:
```bash
systemctl restart nfs-server
```

test mount:
```bash
mount -t nfs4 127.0.0.1:/tmp/root /mnt
```

fstab mount:
```bash
192.168.1.15:/tmp/root  /  nfs4 defaults 0 0
```

