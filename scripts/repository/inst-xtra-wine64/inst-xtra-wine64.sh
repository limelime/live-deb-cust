#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Explicitly download dependent packages
  apt-get install -s -y libgphoto2-6 

# Install wine64.
  apt-get -y install wine wine64 fonts-wine


# Log
  echo "${GV_LOG} * Install wine64."
  echo "${GV_LOG} * Test with Notepad++ 64-bit: wine notepad++.exe"


