ulimit -n 4096

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH

# Chruby support
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

#export EDITOR=/usr/bin/vim
export EDITOR="mvim -v"

export HISTTIMEFORMAT="%h %d %H:%M:%S> "
export HISTCONTROL=ignoredups

# For dark themes:
#export CLICOLOR=1
#export LSCOLORS=GxFxCxDxBxegedabagaced

# For light themes:
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

source git-completion.bash
source git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

#export PROMPT_COMMAND="__git_ps1 '\u@\h:\W' '\\$ ' '[%s]'"

BLACK='\[\e[0;30m\]'
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
MAGENTA='\[\e[0;35m\]'
CYAN='\[\e[0;36m\]'
WHITE='\[\e[0;37m\]'
NORMAL='\[\e[m\]'

PROMPT_CHAR='\$'
#PROMPT_CHAR='☆ '
LINE='-------------------------------------------------------------------------------\n'
#export PROMPT_COMMAND="__git_ps1 '$YELLOW$LINE[$BLUE\u$YELLOW@$BLUE\h$YELLOW:$CYAN\w$YELLOW]$NORMAL' '\n$RED$PROMPT_CHAR$NORMAL ' '$YELLOW[$MAGENTA%s$YELLOW]$NORMAL'"
export PROMPT_COMMAND="__git_ps1 '$GREEN\t $BLUE\u$YELLOW@$BLUE\h$YELLOW:$CYAN\w$NORMAL' '\n$RED$PROMPT_CHAR$NORMAL ' ' $MAGENTA%s$NORMAL'"

. ~/bin/setup_bundle_exec_aliases.sh

. ~/dotfiles/git-aliases.sh
alias gci="gitcommit"

# Other aliases
alias vi="mvim -v"
alias view="mvim -vR"

alias DC="docker-compose"

####################
# Stuff for Lovely #
####################
# Old boot2docker style
#export DOCKER_HOST=tcp://192.168.59.103:2376
#export DOCKER_CERT_PATH=/Users/sbrauer/.boot2docker/certs/boot2docker-vm
#export DOCKER_TLS_VERIFY=1

# Commented our for now... re-enable if I do more lovely work...
# docker-machine --native-ssh start dev > /dev/null 2>&1
# eval "$(docker-machine env dev)"

# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/projects
# export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
# source /usr/local/bin/virtualenvwrapper_lazy.sh


# Hmmm...
source ~/.idg_profile
