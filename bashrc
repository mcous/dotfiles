# bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# cdpath for home directory and projects folder
export CDPATH=.:~:~/projects

# bash history control
export HISTCONTROL=ignoreboth
export PROMPT_COMMAND='history -a'

# bash settings
# enable globstar if available
shopt -s globstar

# os specific path setting
# mac
if [[ $OSTYPE =~ "darwin" ]]; then
  # put /usr/local/bin first in my PATH for Homebrew
  PATH=/usr/local/bin:`echo $PATH | sed 's/\/usr\/local\/bin://'`

  # bash completion scripts
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
  # help out atom
  export ATOM_PATH="${HOME}/Applications"

# linux
elif [[ $OSTYPE =~ "linux" ]]; then
  # bash completion
  if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi

  # include sbins and private bin in the PATH if directories exist
  if [ -d "/sbin" ] ; then PATH="/sbin:$PATH"; fi
  if [ -d "/usr/sbin" ] ; then PATH="/usr/sbin:$PATH"; fi

  # linuxbrew in path if necessary
  if [ -d "$HOME/.linuxbrew" ]; then
    PATH="$HOME/.linuxbrew/bin:$PATH"
    MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
  fi

elif [[ $OSTYPE =~ "msys" ]]; then
  # ensure ssh agent has started
  eval `ssh-agent -s`
  ssh-add

# end OS if
fi

# npm and js dev
# first, check if we're using nvm
if [ -d "${HOME}/.nvm" ]; then
  . ~/.nvm/nvm.sh;
  [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
fi
# prepend /usr/local/share/npm/bin and ./node_modules/.bin for npm
# also source npm completion
if which npm > /dev/null 2>&1; then
  PATH=/usr/local/share/npm/bin:./node_modules/.bin:$PATH
  . <(npm completion)
fi

# added by travis gem
[ -f "${HOME}/.travis/travis.sh" ] && . ${HOME}/.travis/travis.sh

# gulp bash completion (gulp must be installed globally to work)
if which gulp > /dev/null 2>&1; then eval "$(gulp --completion=bash)"; fi

# ruby environment
if which rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
  export PATH="./bin:$PATH"
fi

# python environment
if which pyenv > /dev/null 2>&1; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)";
fi

# go environment
if which go > /dev/null 2>&1; then
  export GOPATH=$HOME/golang
  export GOROOT=/usr/local/opt/go/libexec
  export PATH=$PATH:$GOPATH/bin
  export PATH=$PATH:$GOROOT/bin
fi

# source private bash files if they exist
if [ -f ~/.bash_private ]; then . ~/.bash_private; fi

# set aliases
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi

# cronjobs
# make sure this hasn't run already (e.g. if bachrc has already been sourced)
if test -z $CRONCMD; then
  # get the crontab command
  export CRONCMD=$(which crontab 2>/dev/null)
  if [ -n "$CRONCMD" ]; then
    crontab() {
      if [ "$@" = "-e" ]; then
        vim ~/.cronjobs && $CRONCMD ~/.cronjobs
      else
        $CRONCMD $@
      fi
    }
    $CRONCMD ~/.cronjobs
  fi
fi

# set prompt
. ~/.bash_prompt
