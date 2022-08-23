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

    # Install homebrew (we need xcode-select)
    if ! [ -x "$(command -v brew)" ]; then
        printf "\n${GREEN}We need xcode-tools installed, and homebrew installs those so we're installing Homebrew...${NORMAL}\n\n"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || (printf "\n${RED}Homebrew install failed.${NORMAL}\n\n"; exit 1;)
    fi
elif [ -f /etc/os-release ]; then
    # /etc/os-release exists, read info from it
    . /etc/os-release
    DISTRO=$ID
elif [[ -f /etc/redhat-release ]]; then
    # couldn't find os-release, try redhat-release

    if grep -q "CentOS" /etc/redhat-release; then
        DISTRO='centos'
    else
        DISTRO='rhel'
    fi
else
    # Who knows
    DISTRO='unknown'
fi

printf "\n${GREEN}Processiong bootstrap script for ${CURRENT_OS}..."

# Check if Git is installed
printf "\n${GREEN}Checking for git..."
command -v git >/dev/null 2>&1 || { echo >&2 "${RED}Git not installed. Aborting"; exit 1; }

# Check if local repo already exists, if so, update. If not, clone

if [ -d ~/.dotfiles ]; then
    printf "\n${GREEN}Updating dotfiles repo and submodules\n\n${BRIGHT}"
    cd ~/.dotfiles
    git -c color.ui=auto pull
    git submodule update --recursive --remote
else
    # Get the full repo
    printf "\n${GREEN}Cloning dotfiles repo and submodules ${NORMAL}\n\n"
    git -c color.ui=auto clone $REPO ~/.dotfiles
    cd ~/.dotfiles
    git submodule update --init --recursive
fi

# CD to ~/.dotfiles
cd ~/.dotfiles

# Execute install script
./dotfiles.sh

# Install VIM plugins
vim +PluginInstall +qall

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Attach install flags based on OS
if [ "$CURRENT_OS" == 'OS X' ]; then
    #MacOS Install Script
    printf "\n\n${RED}No MacOS Install Scripts yet${NORMAL}\n"
elif [ "$CURRENT_OS" == 'Linux' ]; then
    printf "\n\n${RED}Checking Linux Distro for Install Scripts${NORMAL}\n"
	if [ "$DISTRO" == 'ubuntu' ]; then
        printf "\n\n${RED}Running Ubuntu install scripts${NORMAL}\n"
		# Debian/Ubuntu stuff
        sudo apt install -y zsh
        printf "\n\n${RED}Ubuntu Install Scripts completed${NORMAL}\n"
	elif [ "$CURRENT_OS" = 'rhel' ]; then
		# Redhat Stuff
        printf "\n\n${RED}No RedHat Install Scripts yet${NORMAL}\n"
	fi

    # Linux wrap up

    printf "\n\n${RED}Changing shell to zsh for current user${NORMAL}\n"
    sudo chsh $USER /bin/zsh
else
    printf "\n\n${RED}OS not supported by install scripts${NORMAL}\n"
    # No Match
fi
