#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Explicitly list dependent packages
#	apt-get install -s -y <your-package> 

	# Stretch
	apt-get install -s -y libavahi-ui-gtk3-0

# Install remmina.
	apt-get -y install remmina remmina-plugin-rdp


# Log
	echo "${GV_LOG} * Install remmina."
	echo "${GV_LOG} * Need to remote desktop MS Windows machines."
