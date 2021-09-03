#!/bin/bash
set -e
# Description: Install PowerShell
#   https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7#debian-10

# Download the powershell '.tar.gz' archive
    curl -L  https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-x64.tar.gz -o /tmp/powershell.tar.gz

# Create the target folder where powershell will be placed
	mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
    tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
    chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
    ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

# Start PowerShell