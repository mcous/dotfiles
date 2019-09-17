# zshell config

ZGEN_PATH="$HOME/.zgen"

SHELL_PATH="$HOME/.shell"

OSX_APPLICATION_PATH="/Applications"

LINUX_BREW_PATH="$HOME/.linuxbrew"

PROJECTS_PATH="$HOME/projects"

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
    zgen load mcous/dotfiles shell/zsh zgen

    zgen oh-my-zsh
    zgen oh-my-zsh plugins/brew
    zgen oh-my-zsh plugins/common-aliases
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/github
    zgen oh-my-zsh plugins/history
    zgen load rust-lang/zsh-config
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions

    zgen save
  fi
fi

# source private shell file if it exists
if [[ -f "$SHELL_PATH/private" ]]; then source "$SHELL_PATH/private"; fi
