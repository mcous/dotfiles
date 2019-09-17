export NVS_HOME="$HOME/.nvs"

if [[ -s "$NVS_HOME/nvs.sh" ]]; then
  source "$NVS_HOME/nvs.sh" ""
  nvs auto on
fi
