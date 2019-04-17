# .bashrc

# COLORS
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
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

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi
# Prompt
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY"]; then
    export PS1="${RED}(REMOTE) ${CYAN}\u ${WHITE}on ${YELLOW}\h ${POWDER_BLUE}\w [\!] ${WHITE}$ "
else
    export PS1="${CYAN}\u ${WHITE}on ${YELLOW}\h ${POWDER_BLUE}\w [\!] ${NORMAL}$ "
fi

if [ -f "${HOME}/.gpg-agent-info" ]; then
    source "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
else
    eval $( gpg-agent --daemon --write-env-file ~/.gpg-agent-info )
fi

# User specific aliases and functions

. ~/.exports
. ~/.aliases

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
