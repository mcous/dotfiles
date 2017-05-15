# bash aliases

# alias hub to git if it exists, and also add some git aliases
if which hub > /dev/null 2>&1; then alias git='hub'; fi
alias gs='git status'
alias gc='git commit -m'
alias gca='git commit -am'

alias push='git push'
__git_complete push _git_push

alias pull='git pull'
__git_complete pull _git_pull

alias gl='git log'
__git_complete gl _git_log

alias gb='git branch'
alias gbd='git branch'
__git_complete gb _git_branch
__git_complete gbd _git_branch

alias gch='git checkout'
alias gchm='git checkout master'
alias gchb='git checkout -b'
__git_complete gch _git_checkout
__git_complete gchb _git_checkout

function gd() {
	git diff --color $@ | diff-so-fancy | less --tabs=4 -RFX
}

# history
alias h='history'
alias hoff='set +o history'
alias hon='set -o history'

# docker
alias d="docker"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias dk="docker kill"
alias drm="docker rm"
alias drmi="docker rmi"
alias dl="docker logs"
alias dlf="docker logs -f"

function drmia() {
	docker rmi $(docker images -q)
}

function drma() {
	docker rm $(docker ps -a -q)
}


function dmenv() {
	eval $(docker-machine env default)
}

alias dmls="docker-machine ls"
alias dmstart="docker-machine start default && dmenv"

# get new dotfiles and source bashrc
alias brc='source ~/.bashrc'
alias dots='~/dotfiles/linkdots'

# list
alias ls='ls -Glp'
alias lsa='ls -Glpa'
alias lsn='command ls'
export LSCOLORS=GxFxCxDxBxegedabagaced

# make cp recursive by default
alias cp='cp -R'
alias cpn='command cp'

# clear the terminal
alias clr='clear'

# search history for a thing
alias hisg='history | grep'

# search process for a thing
alias psg='ps -ax | grep'

# change directory and list files
cl() {
  if [ -d "$1" ]; then
    cd "$1"
    ls
  elif [ "$1" = '' ]; then
    cd ~
    ls
  else
    echo "bash: cl: '$1': directory not found"
  fi
}

# make a directory and change to it
mkcd() {
  mkdir -p "$@" && cd "$_"
}

# http verbs with curl and json
alias GET='curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET'
POST() {
  curl -i -H "Content-Type: application/json" -d $2 -X POST $1
}

# linux pbcopy and pbpaste
command -v pbcopy >/dev/null 2>&1 || alias pbcopy='xclip -selection clipboard'
command -v pbpaste >/dev/null 2>&1 || alias pbpaste='xclip -selection clipboard -o'

# utc time
alias utc='echo -n `date -u +"%Y-%m-%dT%H:%M:%SZ"` | tee >(pbcopy)'
alias utcm='echo -n `date -u +"%Y-%m-%dT%H:%M:%S.000Z"` | tee >(pbcopy)'
