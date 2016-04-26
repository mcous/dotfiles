# bash aliases

# alias hub to git if it exists, and also add some git aliases
if which hub > /dev/null 2>&1; then alias git='hub'; fi
alias stat='git status'
alias gc='git commit -m'
alias gca='git commit -am'
alias push='git push'
alias pull='git pull'
alias gl='git log'
alias gb='git branch'
alias gch='git checkout'
alias gchm='git checkout master'
alias gchb='git checkout -b'

function gd() {
	git diff --color $@ | diff-so-fancy | less --tabs=4 -RFX
}

# docker
alias h=history
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
