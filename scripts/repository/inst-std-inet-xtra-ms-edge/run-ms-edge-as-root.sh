#!/bin/bash
set -e
# Description: Change configuration so that MS Edge can be ran as root.


# Run MS Edge as root. Consider: x-www-browser. 
GOOGLE_CHROME_BIN=/opt/google/chrome/google-chrome
sed -i.original 's|exec -a "$0" "$HERE/chrome" "$@"$|exec -a "$0" "$HERE/chrome" "$@" --no-sandbox --user-data-dir|' "${GOOGLE_CHROME_BIN}"
