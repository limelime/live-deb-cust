#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Explicitly list dependent packages
#	apt-get install -s -y <your-package> 

# Install vim-python-jedi.
	apt-get -y install vim-python-jedi


# Log
	echo "${GV_LOG} * Install vim-python-jedi."
	echo "${GV_LOG} * vim-addons install python-jedi"
	
