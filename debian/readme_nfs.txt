
Organise on pc tftp server for dts and kernel

=== HOST PC soft instalation ===

1) tftp server

mkdir /srv
mkdir /srv/tftp
chown 777 /srv/tftp

apt install atftpd

vim  /etc/default/atftpd

## Options for atftpd:
USE_INETD=false
OPTIONS="--port 69 --tftpd-timeout 300 --retry-timeout 5 --mcast-port 1758 --mcast-addr 239.239.239.0-255 --mcast-ttl 1 --maxthread 100 --verbose=5 /srv/tftp"

systemctl restart atftpd

2) install NFS server

mkdir /srv/nfs
mkdir /srv/nfs/root

and copy ./root -> /srv/nfs/root

apt install nfs-kernel-server

vim /etc/exports

/srv/nfs   *(no_root_squash,no_subtree_check,rw)
#/srv/nfs   192.168.10.1/24(no_root_squash,no_subtree_check,rw)
#/tmp/root *(no_root_squash,no_subtree_check,rw)
#/var/jetson/Linux_for_Tegra/rootfs    *(ro,sync,no_subtree_check)

test mount:
mount -t nfs4 127.0.0.1:/tmp/root /mnt

test mount fstab: cat /etc/fstab
192.168.4.12:/tmp/root  /  nfs4 defaults 0 0


=== On target

1) reboot and terminate booting uboot by pressing enter
2) set tftp anf server ip, nfs dir

setenv tftp_serverip 192.168.0.112
setenv nfs_serverip 192.168.0.112
setenv nfs_dir /srv/nfs/root
setenv tftp_dir '/zsu106/'
saveenv
reset


