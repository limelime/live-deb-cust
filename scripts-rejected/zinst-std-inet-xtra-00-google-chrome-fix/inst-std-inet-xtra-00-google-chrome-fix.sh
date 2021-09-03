#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

                    
# Dependency needed from K4.14 -> K4.16.
apt-get install -s -y libappindicator3-1  # Need after google-chrome v65.0.3325.181.


