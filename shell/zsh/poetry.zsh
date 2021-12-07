export POETRY_HOME="$HOME/.poetry"

if [[ -d "$POETRY_HOME/bin" ]]; then
  export PATH="${PATH}:${POETRY_HOME}/bin"
fi

alias por='poetry run'
