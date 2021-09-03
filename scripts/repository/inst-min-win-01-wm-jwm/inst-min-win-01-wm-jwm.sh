#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Install jwm.
	apt-get -y install jwm

# Set JWM.
	yes | cp -av ./cld/ /usr/local/

# Log
	JWM_VERSION=$(jwm -v | head -n 1)
	echo "${GV_LOG} * Install Window Manager jwm: ${JWM_VERSION}."
	echo "${GV_LOG} * Set ${JWMRC}."
	echo "${GV_LOG} * Change X window manager: update-alternatives --config x-window-manager"