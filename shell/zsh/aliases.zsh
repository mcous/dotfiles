# custom shell aliases

# make a directory and change to it
mkcd() {
  mkdir -p "$@" && cd "$_"
}

# linux pbcopy and pbpaste
command -v pbcopy >/dev/null 2>&1 || alias pbcopy='xclip -selection clipboard'
command -v pbpaste >/dev/null 2>&1 || alias pbpaste='xclip -selection clipboard -o'

# utc time
alias utc='echo -n `date -u +"%Y-%m-%dT%H:%M:%SZ"` | tee >(pbcopy) && echo'
alias utcm='echo -n `date -u +"%Y-%m-%dT%H:%M:%S.000Z"` | tee >(pbcopy) && echo'

# make
alias mk=make
alias mkc='make -C'
alias mkj='make -j'

# git + hub
ghbi() { hub browse -- issues/$1 }
ghbp() { hub browse -- pulls/$1 }
ghbm() { hub browse -- milestones/$1 }
alias ghrr='ghbp review-requested/mcous'

# npm
nr() {
  npm run $1 -- ${@:2}
}
