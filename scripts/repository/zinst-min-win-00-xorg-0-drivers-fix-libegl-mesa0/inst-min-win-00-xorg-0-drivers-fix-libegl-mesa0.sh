#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Explicitly list dependent packages
#	apt-get install -s -y <your-package> 

# Install libegl-mesa0.
	apt-get -y install libegl-mesa0
	apt-get -y install libglx-mesa0

	# apt-get -y install libegl-mesa0=24.2.4-1~bpo12+1
	# apt-get -y install libglx-mesa0=24.2.4-1~bpo12+1


# Log
	echo "${GV_LOG} * Install libegl-mesa0."
