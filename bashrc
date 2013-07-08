# bashrc
# michael cousins
# july 7, 2013

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# bash history control (ignore dupes and ignore commands with leading whitespace)
HISTCONTROL=ignoreboth

# os specific profiles
if [[ $OSTYPE =~ "darwin" ]]
    then
    source ~/.bash_mac
elif [[ $OSTYPE =~ "linux" ]]
    then
    source ~/.bash_linux
elif [[ $OSTYPE =~ "msys" ]]
    then
    source ~/.bash_windows
fi

# Git stuff
# source ~/.git-completion.bash
alias git='hub'
alias status='git status'
alias commit='git commit -am'
alias push='git push'
alias pull='git pull'

# dotfiles
alias dots='~/dotfiles/makedots'

# list
alias ls='ls -Glp'
alias lsa='ls -Glpa'
export LSCOLORS=GxFxCxDxBxegedabagaced

#Prompt and prompt colors
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# 0 - Normal
# 1 - Bold
function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
export PS1="\n$BLACKBOLD[\t]$GREENBOLD \u\[\033[00m\]:$CYANBOLD\w\[\033[00m\] \\$ "
}
prompt


