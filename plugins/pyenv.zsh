if (( $+commands[pyenv] )); then
  eval "$(pyenv init -)"
fi

if (( $+commands[pyenv-virtualenv] )); then
  eval "$(pyenv virtualenv-init -)"
fi
