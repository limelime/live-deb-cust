#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Explicitly list dependent packages
#	apt-get install -s -y <your-package> 

# Install ffplay.
	apt-get -y install ffplay


# Log
	echo "${GV_LOG} * Explicitly install ffplay because ffmpeg package from deb-multimedia.org doesn't include it."
