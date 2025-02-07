#!/bin/bash
set -e
# Description: Create Debian menu.

MENU_DIR=~/.menu
mkdir -p "${MENU_DIR}"

MENU_DIR=$(readlink -ev "${MENU_DIR}")



cp -av *.menu "${MENU_DIR}"
update-menus