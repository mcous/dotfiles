# bashrc
# michael cousins
# january 16, 2014

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# source private bash files (private in that they don't live in my github)
if [[ -f ~/.bash_private ]]; then
  source ~/.bash_private
fi

# bash history control
export HISTCONTROL=ignoreboth
export PROMPT_COMMAND='history -a'

# os specific profiles
# mac
if [[ $OSTYPE =~ "darwin" ]]; then
  # Prepend /usr/local/bin first in my PATH for Homebrew
  PATH=/usr/local/bin:`echo $PATH | sed 's/\/usr\/local\/bin://'`
  # bash completion scripts
  if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
  fi

  # sublime text command line alias
  alias subl='~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
  # make sure sublime text user settings are used
  ln -sf ~/.sublprefs ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
  
# linux
elif [[ $OSTYPE =~ "linux" ]]; then
  # include sbins and private bin in the PATH if directories exist
	if [ -d "/sbin" ] ; then
		PATH="/sbin:$PATH"
	fi
  if [ -d "/usr/sbin" ] ; then
    PATH="/usr/sbin:$PATH"
  fi
  if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
  fi

# msys (windows)
elif [[ $OSTYPE =~ "msys" ]]; then
  # copy sublime text user settings
  ln -sf ~/.sublprefs ~/AppData/Roaming/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings
fi

# npm
if which npm > /dev/null 2>&1; then
  # prepend /usr/local/share/npm/bin and ./node_modules/.bin for npm
  PATH=/usr/local/share/npm/bin:$PATH
  PATH=./node_modules/.bin:$PATH
fi

# ruby environment
if which rbenv > /dev/null 2>&1; then eval "$(rbenv init -)"; fi

#pyton environment
if which pyenv > /dev/null 2>&1; then eval "$(pyenv init -)"; fi

# git stuff
if which hub > /dev/null 2>&1; then alias git='hub'; fi
alias stat='git status'
alias commit='git commit -am'
alias push='git push'
alias pull='git pull'
alias gd='git diff'

# dotfiles
alias brc='source ~/.bashrc'
alias dots='~/dotfiles/makedots && brc'

# list
alias ls='ls -Glp'
alias lsa='ls -Glpa'
alias lsn='command ls'
export LSCOLORS=GxFxCxDxBxegedabagaced

# change directory and list files
cl() {
  if [[ -d $1 ]]; then
    cd "$1"
    ls
  elif [[ $1 = '' ]]; then
    cd ~
    ls
  else
    echo "bash: cl: '$1': directory not found"
  fi
}

# misc alias
alias clr='clear'


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
  local RESET="\[\033[00m\]"

  # two line prompt for skinny windows
  if [[ "$1" = "2" ]]; then
    export PS1="\n$BLACKBOLD[\t] $CYANBOLD\w\n  $GREENBOLD\u$RESET@$PURPLEBOLD\h$RESET: \\$ "
  else
  # one line prompt for wide ones (default)
    export PS1="\n$BLACKBOLD[\t]$GREENBOLD \u$WHITEBOLD@$PURPLEBOLD\h$RESET:$CYANBOLD\w$RESET \\$ "
  fi
}
prompt
