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

# Get the full repo
git clone $REPO ~/.dotfiles

# CD to ~/.dotfiles
cd ~/.dotfiles

# Execute install script
./install.sh


# Attach install flags based on OS
# OS Detection

UNAME=`uname`

# Fallback info
CURRENT_OS='Linux'
DISTRO=''

if [[ $CURRENT_OS == 'OS X' ]]; then
    #MacOS Install Script
elif [[ $CURRENT_OS == 'Linux' ]]; then
	if [[ $CURRENT_OS == 'Debian' ]]; then
		# Debian/Ubuntu stuff
	elif [[ $CURRENT_OS = 'Redhat' ]]; then
		# Redhat Stuff
	fi
else
    # No Match
fi
