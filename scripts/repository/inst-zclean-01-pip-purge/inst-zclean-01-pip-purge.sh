#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Delete python packages to reduce size
    pip cache purge

# Log
    echo "${GV_LOG} * Delete python packages to reduce size: ~/.cache/pip"
