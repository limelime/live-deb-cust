#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Explicitly list dependent packages
#	apt-get install -s -y <your-package> 

# Install ansible.
	apt-get -y install ansible sshpass
	apt-get -y install -s python3-cffi-backend

# Log
	echo "${GV_LOG} * Install ansible."
	echo "${GV_LOG} * sshpass: to allow passing username and password on the fly."
