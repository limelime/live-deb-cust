* >>>>>>>>> Running inst-xtra-zfs-dkms.sh ...
  * After this operation, 13.3 kB of additional disk space will be used.
  * After this operation, 416 kB of additional disk space will be used.
  * After this operation, 19.2 MB of additional disk space will be used.
  * After this operation, 7,396 kB of additional disk space will be used.
  * Install instructions: https://github.com/zfsonlinux/zfs/wiki/Debian
  * Install zfs-dkms: version: 2.2.6-1~bpo12+3, DKMS style package. DKMS vs KMOD, see http://zfsonlinux.org/generic-deb.html
  * Install zfs-initramfs to be able to boot from ZFS.
  * Import existing ZFS partitions: zpool import -a
  * Disk size = 7089164K. Space Used = 47224K. Runtime = 00:00:11:44.
  * The following NEW packages will be installed:
  ```bash
build-essential* dkms* file libc6-dev* libelf-dev
libnvpair3linux libuutil3linux libzfs4linux libzpool5linux libzstd-dev
linux-headers-6.11.5+bpo-amd64* linux-headers-amd64 lsb-release* module-assistant zfs-dkms
zfs-initramfs zfsutils-linux
  ```
