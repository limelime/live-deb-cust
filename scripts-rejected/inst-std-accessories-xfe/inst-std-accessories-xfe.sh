#!/bin/bash
set -e
# Global variables:
# ${GV_LOG}: Prefix this variable in echo to log echoed string.

SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "${GV_LOG}>>>>>>>>> Running ${SCRIPT_NAME} ..."

# Examples:
#   apt-get install -d -y --force-yes <your-package>  # Explicitly download dependent packages 

# Install xfe.
apt-get -y --force-yes install xfe

# Insert xfe in Accessories menu.
sed -i "/Accessories\">/ r jwmrc-menus-acc-xfe.xml" "${GV_CLD_ROOT_DIR}/jwmrc-menus.xml"

# Disable root warning popup.
mkdir -p ~/.config/xfe/
\cp -av xferc ~/.config/xfe/

# Log
echo "${GV_LOG} * Install xfe."
echo "${GV_LOG} * Insert xfe in Accessories menu."
echo "${GV_LOG} * Disable root warning popup: Edit->Preferences->Dialogs."

# Feature: 
#   -Can compress and extract by its own but need archive manager to view files.(e.g. file-roller).
#   -Similar to MS Windows File Explorer.

# REJECTED:
#   -Can't display Chinese characters.