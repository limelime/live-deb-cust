* >>>>>>>>> Running inst-xtra-zfs-dkms.sh ...
  * After this operation, 10.2 kB of additional disk space will be used.
  * After this operation, 400 kB of additional disk space will be used.
  * After this operation, 17.5 MB of additional disk space will be used.
  * After this operation, 6,724 kB of additional disk space will be used.
  * Install instructions: https://github.com/zfsonlinux/zfs/wiki/Debian
  * Install zfs-dkms: version: 2.0.3-9~bpo10+1, DKMS style package. DKMS vs KMOD, see http://zfsonlinux.org/generic-deb.html
  * Install zfs-initramfs to be able to boot from ZFS.
  * Import existing ZFS partitions: zpool import -a
  * Disk size = 4900604K. Space Used = 56672K. Runtime = 00:00:05:52.
  * The following NEW packages will be installed:
  ```bash
build-essential* dkms* file libc6-dev* libelf-dev
libnvpair3linux libuutil3linux libzfs4linux libzpool4linux linux-headers-5.10.0-0.bpo.7-amd64*
linux-headers-amd64 lsb-release* module-assistant spl-dkms zfs-dkms
zfs-dkms* zfs-initramfs zfsutils-linux
  ```
