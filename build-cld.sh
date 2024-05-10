#!/bin/bash
set -e
# Description: Log build time.

# Error handling.
  system_type=$1
  if [ -z "${system_type}" ]; then
    echo "Error: system_type can't be empty. Aborted!"
    exit 1;
  fi


# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
  T="$(date +%s)"

# Run command.
  ./cld.sh ${system_type} http://localhost/aptly-repo/master_bookworm-main

# Log total elapsed time if success.
  if [ $? -eq 0 ]; then
    date_string=$(date +"%Y-%m-%d.%0k.%M.%S")
    T="$(($(date +%s)-T))"
    printf "%s: %s: Elapsed time: %02d:%02d:%02d:%02d [DD:HH:MM:SS]\n" "${date_string}" "${system_type}" "$((T/86400))" "$((T/3600%24))" "$((T/60%60))" "$((T%60))" >> build-elapsed.txt
  fi
