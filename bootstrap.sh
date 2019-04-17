#!/bin/bash

# colors

RED='\033[0;31m'
GREEN='\033[0:32m'
NC='\033[0m'

# OS Detection

UNAME=`uname`
REPO='https://github.com/AaronSeibert/dotfiles.git'

# Fallback info
CURRENT_OS='Linux'
DISTRO=''

if [[ $UNAME == 'Darwin' ]]; then
    CURRENT_OS='OS X'
else
    # Must be Linux, determine distro
    if [[ -f /etc/redhat-release ]]; then
        # CentOS or Redhat?
        if grep -q "CentOS" /etc/redhat-release; then
            DISTRO='CentOS'
        else
            DISTRO='RHEL'
        fi
    fi
fi

printf "\n${GREEN}Processiong bootstrap script for ${CURRENT_OS}..."

# Check if Git is installed
printf "\n${GREEN}Checking for git..."
command -v git >/dev/null 2>&1 || { echo >&2 "${RED}Git not installed. Aborting"; exit 1; }

# Check if local repo already exists, if so, update. If not, clone

if [ -d ~/.dotfiles ]; then
    printf "\n\n${GREEN}Updating dotfiles repo\n"
    cd ~/.dotfiles
    git pull
else
    # Get the full repo
    printf "\n\n${GREEN}Cloning dotfiles repo\n"
    git clone $REPO ~/.dotfiles
fi

# CD to ~/.dotfiles
cd ~/.dotfiles

# Execute install script
./install.sh

# Attach install flags based on OS
if [ $CURRENT_OS == 'OS X' ]; then
    #MacOS Install Script
    printf "\n\n${RED}No MacOS Install Scripts yet"
elif [ $CURRENT_OS == 'Linux' ]; then
    printf "\n\n${RED}No Linux Install Scripts yet"
	if [ $CURRENT_OS == 'Debian' ]; then
		# Debian/Ubuntu stuff
        printf "\n\n${RED}No Debian/Ubuntu Install Scripts yet"
	elif [ $CURRENT_OS = 'Redhat' ]; then
		# Redhat Stuff
        printf "\n\n${RED}No RedHat Install Scripts yet"
	fi
else
    printf "\n\n${RED}OS not supported by install scripts"
    # No Match
fi
