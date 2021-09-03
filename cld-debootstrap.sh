#!/bin/bash
set -e
# Description: debootstrap
#   - Ensure /root/.gnupg/trustedkeys.gpg has key for CLD aptly repository.

CHROOT_DIR=$1
DEB_REPO_URL=$2

# Error Handling
  CMD_EXAMPLES=$(printf "%s\n%s\n%s\n" \
                        "  e.g. $0 <CHROOT_DIR> <DEB_REPO_URL>"\
                        "  e.g. $0 chroot http://ftp.debian.org/debian/"\
                        "  e.g. $0 my-chroot-dir http://localhost/aptly-repo/"\
                )
	if [ "$#" -ne 2 ]; then
    echo "Error: 2 arguments are required. Aborted!"
    echo "${CMD_EXAMPLES}"
    exit 1;
	fi

	if [ -z "${DEB_REPO_URL}" ]; then
	  echo "Error: Please provide the debian repository URL. Aborted!"
    echo "${CMD_EXAMPLES}"
	  exit 1;
	fi

# Clear chroot directory
	rm -rf "${CHROOT_DIR}"
	mkdir -p "${CHROOT_DIR}"
	CHROOT_DIR=$(readlink -ev "${CHROOT_DIR}")

# Boot strap the minimum live system.
    debootstrap --keyring=/root/.gnupg/trustedkeys.gpg --arch=amd64 buster ${CHROOT_DIR} ${DEB_REPO_URL}

# copy original source.list to source.list.live
    cp -a ${CHROOT_DIR}/etc/apt/sources.list ${CHROOT_DIR}/etc/apt/sources.list.live

# Copy all scripts, setting files and binary to live system.
    cp -a scripts ${CHROOT_DIR}/root


# What to do next.
cat <<EOF
============================================
What to do next?
Run the following tolog in the live system:
    chroot chroot
Then, run
  cd /root/scripts
  chmod +x setup-chroot.sh
  ./setup-chroot.sh
  chmod +x scripts-ls.sh
  ./scripts-ls.sh ${SYSTEM}
  chmod +x main.sh
  ./main.sh
EOF


# Reference:
# https://l3net.wordpress.com/2013/09/21/how-to-build-a-debian-livecd/
# http://willhaley.com/blog/create-a-custom-debian-live-environment/
