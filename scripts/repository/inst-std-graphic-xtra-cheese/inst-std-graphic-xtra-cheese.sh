#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Explicitly download dependent packages
#   apt-get install -s -y <your-package> 

# Install cheese.
  apt-get -y install cheese

# Insert guvcview menu in Graphics
  sed -i "/Graphics\">/ r jwmrc-menus-graphics-cheese.xml" "${CLD_JWMRC_DIR}/jwmrc-menus.xml"

# Add to CLD/
  yes | cp -av ./cld  /usr/local

# Log
  echo "${GV_LOG} * Install cheese."
  echo "${GV_LOG} * By default, cheese stores all files in ~/.gnome2/cheese/media . "

# REJECTED because you can't choose where to store recorded file.
#   Cheese will add 57,396 KB whereas Guvcview will add 4,340 KB.


