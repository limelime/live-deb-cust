#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."


# Setup X Window to allow keyboard to move mouse.
#   Why under JWM? Because if JWM didn't run, then there is no point to move the mouse.
	yes | cp -av ./cld/ /usr/local


# Log
	echo "${GV_LOG} * Setup X Window to allow keyboard to move mouse."
	echo "${GV_LOG} * Press Left Shift+NumLock."
	echo "${GV_LOG} * Press on numpad keys to move the mouse."
