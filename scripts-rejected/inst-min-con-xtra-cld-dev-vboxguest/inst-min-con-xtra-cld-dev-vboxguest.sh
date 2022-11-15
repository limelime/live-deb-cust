#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.
# ${GV_SOURCES_LIST}: APT sources list file

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."


# Explicitly download dependent packages.
apt-get -d -y install linux-headers-amd64


# Install required packages to compile VirtualBox guest additions.
KERNEL_HEADER=$(dpkg-query -W -f='${binary:Package}\n' linux-image-* | head -n 1 | sed 's/linux-image-//')
apt-get -y install dkms libc6-dev
apt-get -y install linux-headers-${KERNEL_HEADER}

# Install virtualbox-guest-utils.
apt-get -y install virtualbox-guest-dkms virtualbox-guest-utils


# Log
VBOXGUEST_ADD_VERSION=$(modinfo vboxguest | grep ^version | tr -s ' ')
if [ -z "${VBOXGUEST_ADD_VERSION}" ]; then
  VBOXGUEST_ADD_VERSION="ERROR: VirtualBox guest additions installation failed!"
fi
echo "${GV_LOG} * Install virtualbox-guest-utils to access shared folder. No need for x11. Less error prone."
echo "${GV_LOG} * VirtualBox guest additions installed: ${VBOXGUEST_ADD_VERSION}."

# 1) Working dependencies.
###PKGS_LIST="dkms libc6-dev linux-headers-${KERNEL_HEADER} build-essential module-assistant"
###apt-get -y install ${PKGS_LIST}
###m-a -i prepare
###apt-get -y install virtualbox-guest-dkms virtualbox-guest-source virtualbox-guest-utils

# 2) Working dependencies.
###PKGS_LIST="dkms libc6-dev linux-headers-${KERNEL_HEADER}"
###apt-get -y install ${PKGS_LIST}
###apt-get -y install virtualbox-guest-dkms virtualbox-guest-source virtualbox-guest-utils

# 3) Working dependencies.
###PKGS_LIST="dkms libc6-dev linux-headers-${KERNEL_HEADER}"
###apt-get -y install ${PKGS_LIST}
###apt-get -y install virtualbox-guest-dkms virtualbox-guest-utils
