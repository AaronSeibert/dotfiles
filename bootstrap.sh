#!/bin/bash

# colors

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLACK=$(tput setaf 0)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)
NC=$(tput sgr0)

# OS Detection

UNAME=`uname`
REPO='https://github.com/AaronSeibert/dotfiles.git'

# Fallback info
CURRENT_OS='Linux'
DISTRO=''

if [[ $UNAME == 'Darwin' ]]; then
    CURRENT_OS='OS X'

    # We also need xcode-select for this
	os=$(sw_vers -productVersion | awk -F. '{print $1 "." $2}')
	if softwareupdate --history | grep --silent "Command Line Tools.*${os}"; then
	    printf "\n${GREEN}Command-line tools already installed.\n" 
	else
	    printf "\n${GREEN}Installing Command-line tools...\n"
	    in_progress=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
	    touch ${in_progress}
	    product=$(softwareupdate --list | awk "/\* Command Line.*${os}/ { sub(/^   \* /, \"\"); print }")
	    softwareupdate --verbose --install "${product}" || printf "\n${RED}Installation failed.\n\n${NORMAL}" 1>&2 && rm ${in_progress} && exit 1
	    rm ${in_progress}
	    printf "\n${GREEN}Installation succeeded.\n"
	fi
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
    printf "\n${GREEN}Updating dotfiles repo\n\n${BRIGHT}"
    cd ~/.dotfiles
    git -c color.ui=auto pull
else
    # Get the full repo
    printf "\n${GREEN}Cloning dotfiles repo\n\n${BRIGHT}"
    git -c color.ui=auto clone $REPO ~/.dotfiles
fi

# CD to ~/.dotfiles
cd ~/.dotfiles

# Execute install script
./install.sh

# Attach install flags based on OS
if [ $CURRENT_OS == 'OS X' ]; then
    #MacOS Install Script
    printf "\n\n${RED}No MacOS Install Scripts yet\n"
elif [ $CURRENT_OS == 'Linux' ]; then
    printf "\n\n${RED}No Linux Install Scripts yet\n"
	if [ $CURRENT_OS == 'Debian' ]; then
		# Debian/Ubuntu stuff
        printf "\n\n${RED}No Debian/Ubuntu Install Scripts yet\n"
	elif [ $CURRENT_OS = 'Redhat' ]; then
		# Redhat Stuff
        printf "\n\n${RED}No RedHat Install Scripts yet\n"
	fi
else
    printf "\n\n${RED}OS not supported by install scripts\n"
    # No Match
fi
