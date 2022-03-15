# use gmake if available
if (( $+commands[gmake] )); then
  alias make=gmake
fi

# make
alias mk=make
alias mkc='make -C'
alias mkj='make -j'

