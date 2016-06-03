PATH=~/bin:$PATH

export EDITOR=/usr/bin/vim

export HISTTIMEFORMAT="%h %d %H:%M:%S> "
export HISTCONTROL=ignoredups

export CLICOLOR=1

# source git-completion.bash
# source git-prompt.sh
# export GIT_PS1_SHOWDIRTYSTATE=true
# export GIT_PS1_SHOWUNTRACKEDFILES=true

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
export PS1="$GREEN\t $BLUE\u$YELLOW@$BLUE\h$YELLOW:$CYAN\w\n$RED$PROMPT_CHAR$NORMAL "

# Abbreviate long pwd in prompt (requires Bash 4)
#export PROMPT_DIRTRIM=3

alias eject="drutil eject"
alias vi="mvim -v"

source ~/dotfiles/git-aliases.sh
