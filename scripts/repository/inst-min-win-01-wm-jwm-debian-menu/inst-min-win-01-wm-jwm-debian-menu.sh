#!/bin/bash

# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."


# An easy way to get the programs that you install in the menu quickly 
# without having to remember to manually create an entry each time you install something.
apt-get -y install menu

# Log
echo "${GV_LOG} * Install menu, an easy way to get installed programs in the menu automatically."
echo "${GV_LOG} * For how to use Debian menu, see https://www.debian.org/doc/packaging-manuals/menu.html/ch3.html."

# Note:
# Check menu-xdg