#!/bin/bash
set -e

# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Add deb-multimedia key.
  keyring_file=deb-multimedia-keyring_2016.8.1_all.deb
  dpkg -i ${keyring_file} && rm -f ${keyring_file}

# Add deb-multimedia sources list
  GF_ADD_SOURCE_LIST live "deb http://www.deb-multimedia.org buster main non-free"
  GF_ADD_SOURCE_LIST live "deb http://www.deb-multimedia.org buster-backports main"

# Update packages.
  apt-get update
  #apt-get update -oAcquire::AllowInsecureRepositories=true
  #apt-get install deb-multimedia-keyring -oAcquire::AllowInsecureRepositories=true

# Log
  echo "${GV_LOG} * Add deb-multimedia keyring."
  echo "${GV_LOG} * Add deb-multimedia repository."
  echo "${GV_LOG} * apt-get update"

# Note:
# Key might change, see http://www.deb-multimedia.org/
#   wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/${keyring_file}