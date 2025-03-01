#!/bin/bash
set -e

# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Install sqlite.
apt-get -y install sqlite3

# Add to CLD/
 yes | cp -av ./cld  /usr/local

# Log
echo "${GV_LOG} * Install Database: sqlite3."