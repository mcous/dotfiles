# zshell config

ANTIGEN_PATH="/usr/local/share/antigen"

SHELL_PATH="$HOME/.shell"

LOCAL_PLUGINS_PATH="$SHELL_PATH/zsh"

OSX_APPLICATION_PATH="$HOME/Applications"

LINUX_BREW_PATH="$HOME/.linuxbrew"

PROJECTS_PATH="$HOME/projects"

ZSH_THEME=steeef

export CDPATH=.:$HOME:$PROJECTS_PATH
export EDITOR=vim
export HISTTIMEFORMAT="[%F %T] "
# os specific settings
if [[ $OSTYPE =~ "darwin" ]]; then
  export HOMEBREW_CASK_OPTS="--appdir=$OSX_APPLICATION_PATH"
  export ATOM_PATH="$OSX_APPLICATION_PATH"

# linux
elif [[ $OSTYPE =~ "linux" ]]; then
  # linuxbrew in path if necessary
  if [ -d "$LINUX_BREW_PATH" ]; then
    PATH="$LINUX_BREW_PATH/bin:$PATH"
    MANPATH="$LINUX_BREW_PATH/share/man:$MANPATH"
    INFOPATH="$LINUX_BREW_PATH/share/info:$INFOPATH"
  fi

# end os if
fi

# antigen
if [[ -d "$ANTIGEN_PATH" ]]; then
  source "$ANTIGEN_PATH/antigen.zsh"

  antigen use oh-my-zsh

  antigen bundle $LOCAL_PLUGINS_PATH
  antigen bundle brew
  antigen bundle common-aliases
  antigen bundle docker
  antigen bundle git
  antigen bundle github
  antigen bundle history
  antigen bundle node
  antigen bundle npm
  antigen bundle nvm
  antigen bundle osx
  antigen bundle rust-lang/zsh-config
  antigen bundle zsh-users/zsh-syntax-highlighting

  antigen theme $ZSH_THEME

  antigen apply
fi

# # source private shell file if it exists
if [[ -f "$SHELL_PATH/private" ]]; then source "$SHELL_PATH/private"; fi

# set aliases
if [[ -f "$SHELL_PATH/aliases" ]]; then source "$SHELL_PATH/aliases"; fi

# cronjobs
# make sure this hasn't run already
if test -z $CRONCMD; then
  # get the crontab command
  export CRONCMD=$(which crontab 2>/dev/null)
  if [ -n "$CRONCMD" ]; then
    crontab () {
      if [ "$@" = "-e" ]; then
        vim "$SHELL_PATH/cron" && $CRONCMD "$SHELL_PATH/cron"
      else
        $CRONCMD $@
      fi
    }
    $CRONCMD "$SHELL_PATH/cron"
  fi
fi
