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

# Check if Git is installed
command -v git >/dev/null 2>&1 || { echo >&2 "Git not installed. Aborting"; exit 1; }

# Check if local repo already exists, if so, update. If not, clone

if [ -d ~/.dotfiles ]; then
    echo "Updating dotfiles repo\n"
    cd ~/.dotfiles
    git pull
else
    # Get the full repo
    echo "Cloning dotfiles repo\n"
    git clone $REPO ~/.dotfiles
fi

# CD to ~/.dotfiles
cd ~/.dotfiles

# Execute install script
./install.sh


# Attach install flags based on OS
if [ $CURRENT_OS == 'OS X' ]; then
    #MacOS Install Script
    echo
    echo "No MacOS Install Scripts yet"
elif [ $CURRENT_OS == 'Linux' ]; then
    echo
    echo "No Linux Install Scripts yet"
	if [ $CURRENT_OS == 'Debian' ]; then
		# Debian/Ubuntu stuff
        echo
        echo "No Debian/Ubuntu Install Scripts yet"
	elif [ $CURRENT_OS = 'Redhat' ]; then
		# Redhat Stuff
        echo
        echo "No RedHat Install Scripts yet"
	fi
else
    echo
    echo "OS not supported by install scripts"
    # No Match
fi
