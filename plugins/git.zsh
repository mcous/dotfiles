# mostly copied from oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
# https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.zsh

# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# git + hub
if command -v hub 1>/dev/null 2>&1; then
  alias git=hub
fi

ghbi() { hub browse -- issues/$1 }
ghbp() { hub browse -- pulls/$1 }
ghbm() { hub browse -- milestones/$1 }
alias ghrr='ghbp review-requested/mcous'

#
# Aliases
# (sorted alphabetically)
#

alias g='git'

alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbm='git branch -m'

alias gc='git commit -v'
alias gcam='git commit -a -m'
alias gcmsg='git commit -m'

alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout main'
alias gcd='git checkout develop'

alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'

alias gl='git pull'

alias glg='git log --stat'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'

alias gst='git status'
