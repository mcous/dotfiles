# zshell config

ANTIGEN_PATH="/usr/local/share/antigen"
ZGEN_PATH="$HOME/.zgen"

SHELL_PATH="$HOME/.shell"

LOCAL_PLUGINS_PATH="$SHELL_PATH/zsh"

OSX_APPLICATION_PATH="/Applications"

LINUX_BREW_PATH="$HOME/.linuxbrew"

PROJECTS_PATH="$HOME/projects"

ZSH_THEME=steeef

export CDPATH=.:$HOME:$PROJECTS_PATH
export EDITOR=vim
export HISTTIMEFORMAT="[%F %T] "

# auto_cd is annoying; turn it off
unsetopt AUTO_CD

# os specific settings
if [[ $OSTYPE =~ "darwin" ]]; then
  export HOMEBREW_CASK_OPTS="--appdir=$OSX_APPLICATION_PATH"

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

if [[ -d "$ZGEN_PATH" ]]; then
  source "$ZGEN_PATH/zgen.zsh"

  if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/brew
    zgen oh-my-zsh plugins/common-aliases
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/github
    zgen oh-my-zsh plugins/history

    zgen load $LOCAL_PLUGINS_PATH
    zgen load rust-lang/zsh-config
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions

    zgen save
  fi
fi

# source private shell file if it exists
if [[ -f "$SHELL_PATH/private" ]]; then source "$SHELL_PATH/private"; fi

# set aliases
if [[ -f "$SHELL_PATH/aliases" ]]; then source "$SHELL_PATH/aliases"; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
