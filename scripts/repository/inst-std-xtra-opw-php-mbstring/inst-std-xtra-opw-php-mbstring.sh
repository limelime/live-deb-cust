#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Explicitly download dependent packages
#   apt-get install -s -y <your-package> 

# Install php-mbstring.
apt-get -y install php-mbstring


# Log
echo "${GV_LOG} * Install php-mbstring."