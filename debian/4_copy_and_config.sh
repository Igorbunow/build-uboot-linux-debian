#!/bin/bash

USER_ADD=user

echo "********* Setting standart password for root *********"
echo 'root:root' | chroot ./root/ chpasswd

echo "********* Clean apt cache *********"
chroot ./root/ apt clean

echo "********* Clean logs *********"
rm ./root/var/log/bootstrap.log
echo -n > ./root/var/log/alternatives.log
echo -n > ./root/var/log/dpkg.log

echo "********* Creating user ${USER_ADD} *********"
echo "1) creating user ${USER_ADD}"
chroot ./root/ useradd -d /home/${USER_ADD} -s  /bin/bash ${USER_ADD}
echo "2) creating home user dir /home/${USER_ADD}"
chroot ./root/  mkdir /home/${USER_ADD}  
echo "3) settings home user dir /home/${USER_ADD} owner"
chroot ./root/  chown ${USER_ADD}:${USER_ADD} /home/${USER_ADD}
echo "${USER_ADD}:${USER_ADD}" | chroot ./root/ chpasswd

echo "********* Fixing python error *********"
rm -rf ./root/usr/lib/binfmt.d/python3.11.conf

echo "********* Config network interfaces *********"
echo "# eth0 interface config" > ./root/etc/network/interfaces.d/eth0
echo "" >> ./root/etc/network/interfaces.d/eth0
echo "allow-hotplug eth0" >> ./root/etc/network/interfaces.d/eth0
echo "iface eth0 inet dhcp" >> ./root/etc/network/interfaces.d/eth0

echo "********* Config fstab *********"
echo "# fstab config for sd card boot" > ./root/etc/fstab
echo "" >> ./root/etc/fstab
echo "#root partishin" >> ./root/etc/fstab
echo "/dev/mmcblk0p2 /  btrfs   noatime,nodiratime,relatime,ssd,discard,compress=lzo 0  0" >> ./root/etc/fstab
echo "" >> ./root/etc/fstab
echo "#boot partishion" >> ./root/etc/fstab
echo "/dev/mmcblk0p1 /boot    vfat    defaults        0       0" >> ./root/etc/fstab

echo "********* Copifig files *********"
cp -r -n -f -u ./files/* ./root/
echo "- lib and sbin separately"
rm ./root/lib/systemd/system/serial-getty@.service
cp -r -n -f -u ./files/lib/* ./root/lib/
cp -r -n -f -u ./files/sbin/* ./root/sbin/
cp -r -n -f -u ./root/root/.vimrc ./root/home/${USER_ADD}
chroot ./root/  chown -R ${USER_ADD}:${USER_ADD} ./home/${USER_ADD}
