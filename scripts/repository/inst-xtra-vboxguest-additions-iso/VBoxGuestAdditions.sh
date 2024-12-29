#!/bin/bash
set -e

# Description: Download the VBoxGuestAdditions.iso.
#     http://download.virtualbox.org/virtualbox/

URL=http://download.virtualbox.org/virtualbox/6.0.12/VBoxGuestAdditions_6.0.12.iso  # Buster: K5.20
URL=http://download.virtualbox.org/virtualbox/6.0.14/VBoxGuestAdditions_6.0.14.iso
URL=http://download.virtualbox.org/virtualbox/6.0.16/VBoxGuestAdditions_6.0.16.iso
URL=http://download.virtualbox.org/virtualbox/6.0.18/VBoxGuestAdditions_6.0.18.iso
URL=http://download.virtualbox.org/virtualbox/6.1.4/VBoxGuestAdditions_6.1.4.iso    # Clipboard doesn't work.
URL=http://download.virtualbox.org/virtualbox/6.1.2/VBoxGuestAdditions_6.1.2.iso
URL=http://download.virtualbox.org/virtualbox/6.1.6/VBoxGuestAdditions_6.1.6.iso	# 6.1.6 r137129 Copy & paste work flawlessly, include formatting.
URL=http://download.virtualbox.org/virtualbox/6.1.14/VBoxGuestAdditions_6.1.14.iso
URL=http://download.virtualbox.org/virtualbox/6.0.24/VBoxGuestAdditions_6.0.24.iso
URL=http://download.virtualbox.org/virtualbox/6.1.18/VBoxGuestAdditions_6.1.18.iso	# After install, kernel panic.
URL=http://download.virtualbox.org/virtualbox/6.1.16/VBoxGuestAdditions_6.1.16.iso
URL=http://download.virtualbox.org/virtualbox/6.1.22/VBoxGuestAdditions_6.1.22.iso
URL=http://download.virtualbox.org/virtualbox/6.1.32/VBoxGuestAdditions_6.1.32.iso
URL=http://download.virtualbox.org/virtualbox/6.1.32/VBoxGuestAdditions_6.1.32.iso  # OK
URL=http://download.virtualbox.org/virtualbox/6.1.38/VBoxGuestAdditions_6.1.38.iso
URL=http://download.virtualbox.org/virtualbox/7.0.4/VBoxGuestAdditions_7.0.4.iso    # Copy & paste work flawlessly, include formatting TO host. Host win32 v7.0.0 r153978. But only 1 line copy FROM host.
#~ URL=http://download.virtualbox.org/virtualbox/7.0.10/VBoxGuestAdditions_7.0.10.iso	# BAD: mv file: segmentation fault. Copy & paste not working.
#~ URL=http://download.virtualbox.org/virtualbox/7.0.12/VBoxGuestAdditions_7.0.12.iso  # BAD: Boot can´t open Window manager.
URL=http://download.virtualbox.org/virtualbox/7.1.0/VBoxGuestAdditions_7.1.0.iso  # OK
URL=http://download.virtualbox.org/virtualbox/7.1.4/VBoxGuestAdditions_7.1.4.iso

# Download ISO if not already exists.
    vbox_iso="VBoxGuestAdditions.iso"
    vbox_iso_txt="VBoxGuestAdditions.iso.txt"
    dled_iso=$(cat "${vbox_iso_txt}")
    url_iso_file=$(basename $URL)

    if [ "${url_iso_file}" == "${dled_iso}" ]; then
        echo "Warning: already downloaded: ${url_iso_file}."
    else
        wget "${URL}"
        md5sum "${url_iso_file}" >> VBoxGuestAdditions.iso.md5
        
        echo "${url_iso_file}" > "${vbox_iso_txt}"
        
        \cp "${url_iso_file}" "${vbox_iso}"
    fi
