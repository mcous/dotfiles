# custom shell aliases
# many copied from oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh

# make a directory and change to it
mkcd() {
  mkdir -p "$@" && cd "$_"
}

# utc time
alias utc='echo -n `date -u +"%Y-%m-%dT%H:%M:%SZ"` | tee >(pbcopy) && echo'
alias utcm='echo -n `date -u +"%Y-%m-%dT%H:%M:%S.000Z"` | tee >(pbcopy) && echo'


# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"

alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias p='ps -f'
