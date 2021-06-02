if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

if command -v pyenv-virtualenv 1>/dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)"
fi
