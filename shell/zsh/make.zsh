# use gmake if available
if command -v gmake 1>/dev/null 2>&1; then
  alias make=gmake
fi

# make
alias mk=make
alias mkc='make -C'
alias mkj='make -j'

