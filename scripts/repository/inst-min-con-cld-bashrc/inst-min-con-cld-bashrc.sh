#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.
# ${GV_SOURCES_LIST}: APT sources list file

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."


# Add common bashrc environment.
	yes | cp -av ./cld/ /usr/local/


# Log
	echo "${GV_LOG} * Set common settings for ~/.bashrc."
	# find cld/ -type f -name '*.sh' -execdir chmod +x {} \;
