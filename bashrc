# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Prompt
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY"]; then
    export PS1="\[\e[31m\](REMOTE) \[\e[m\]\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\] \[\e[37m\]\w\[\e[m\] [\!] $ "
else
    export PS1="\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\] \[\e[37m\]\w\[\e[m\] [\!] $ "
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
