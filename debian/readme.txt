- install aditional packages if need

-- bind mount
mount --bind /dev ./root/dev/
mount --bind /sys ./root/sys/
mount --bind /proc ./root/proc/
mount --bind /dev/pts ./root/dev/pts

chroot ./root
PACKAGES="valgrind build-essential clang u-boot-tools cmake git subversion tcpdump kbuild nmap wget libboost-all-dev linux-headers-arm64 minicom picocom p7zip-full gzip zstd bzip2"
apt update
apt install ${PACKAGES}
echo "packages: ${PACKAGES}" >> /info
rm /usr/lib/binfmt.d/llvm-14-runtime.binfmt.conf
rm -rf ./root/usr/lib/binfmt.d/python3.11.conf
apt clean
exit
-- bind umount
umount ./root/sys
umount ./root/proc
umount ./root/dev/pts
umount ./root/dev

rm -rf ./root/var/log/apt/*

echo -n > ./root/var/log/alternatives.log
echo -n > ./root/var/log/dpkg.log
echo -n > ./root/root/.bash_history
rm ./root/var/cache/apt/archives/lock

- create disk image
dd if=/dev/zero bs=1M count=1024 of=ultrascale_short.img
sync;

- map partishions
fdisk -c=dos ultrascale_short.img

-- create new boot  partishion 'n'
-- make it primary 'p'
-- part number '1'
-- first sector '63'
-- last sector '1048576'
-- mark bootable 'a'
-- create root partishion 'n'
-- make root primary 'p'
-- part root number '2'
-- first sector '1048577'
-- last sector '2097151'
-- write changes and exit 'w'
-- select all free space for it

- mount disk image
losetup --partscan --find --show ultrascale_short.img

- view partishions
ls /dev | grep loop0

-- free disk partishion
dd if=/dev/zero of=/dev/loop0p1 bs=4M
dd if=/dev/zero of=/dev/loop0p2 bs=4M
sync;

-- map file systems
mkfs.vfat -F 32 -n "BOOT" /dev/loop0p1
mkfs.btrfs /dev/loop0p2 -L "root"
sync;

-- mount created systems
mkdir /tmp/root
mkdir /tmp/boot
mount -o compress=lzo /dev/loop0p2 /tmp/root
mount  /dev/loop0p1 /tmp/boot

-- copy rootfs and bootimages

copy bitsteam: system.bit -> /tmp/boot

cp ./../boot/image/BOOT.bin  /tmp/boot
cp ./../boot/image/boot.scr  /tmp/boot
cp ./../boot/image/Image /tmp/boot
cp ./../boot/image/zynqmp-zcu106-revA.dtb /tmp/boot
chmod -R 777 /tmp/boot
sync;

-- place bitstreem 'system.bit' to /tmp/boot

--copy root file system
cp -rpna  ./root/*  /tmp/root/
rm /tmp/root/qemu-arm64-static
sync;

-- if file system archived:
tar -C /tmp/root -xjf images/rootfs.tar.bz2
sync;

-- umount
umount /tmp/boot
umount /tmp/root
sync;
losetup -d /dev/loop0
sync;

-- compress image
gzip -9cf ultrascale_short.img > ultrascale_short.img.gz
zstd -16v --ultra --format=zstd ultrascale_short.img -o ultrascale_short.img.zst

-- write it on sd card
zcat ultrascale_short.img.gz | dd bs=8M iflag=fullblock of=/dev/sdxxx status=progress
zstdcat ultrascale_short.img.zst | dd bs=8M iflag=fullblock of=/dev/sdxxx status=progress



-- after first boot increase root size to fool flash size:
extend_sd

-- save serial root autologin
chattr +i /lib/systemd/system/serial-getty@.service

or use separate comands
growpart /dev/mmcblk0 2
btrfs filesystem resize max /
- in ext2,3,4 case: resize2fs /dev/xxxx
- in xfs case xfs_growfs /

- in some cases ssh connect need to use:
ssh user@192.168.x.x  -o PreferredAuthentications=password -o PubkeyAuthentication=no

- if need set force link speed
ethtool -s end0 speed 100 autoneg off


