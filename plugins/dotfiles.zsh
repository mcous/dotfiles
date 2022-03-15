_SCRIPT_PATH=${0}
_DOTFILES_MARKER="$HOME/.dotfiles"

function _do_mkdir () {
  echo "mkdir -p $1"
  if [[ ! $DRYRUN ]]; then mkdir -p $1; fi
}

function _do_ln () {
  echo "ln -sf $1 $2"
  if [[ ! $DRYRUN ]]; then ln -sf $1 $2; fi
}

function _do_rm () {
  echo "rm -f $1"
  if [[ ! $DRYRUN ]]; then rm -f $1; fi
}

function _link_file () {
  local target=$1
  local source_directory=$2
  local dotfile="$HOME/.${target#$source_directory/}"
  local dotfile_dir=$(dirname $dotfile)

  if [[ -f "$dotfile" && ! -h "$dotfile" ]]; then
    echo "SKIP $dotfile; already exists"
  else
    if [[ ! -d $dotfile_dir ]]; then
      _do_mkdir $dotfile_dir
    fi

    _do_ln $target $dotfile
    echo "$dotfile" >> "$_DOTFILES_MARKER"
  fi
}

function _link_files_in_dir () {
  local directory=$1
  local source_directory=${2-$directory}

  if [[ -d "$directory" ]]; then
    local files_to_link=( $directory/* )

    for target in $files_to_link; do
      if [[ -d "$target" ]]; then
        _link_files_in_dir $target $source_directory
      else
        _link_file $target $source_directory
      fi
    done
  fi
}

function _reset_dotfiles () {
  if [[ -f $_DOTFILES_MARKER ]]; then
    linked_files=( $(<$_DOTFILES_MARKER) )

    for f in $linked_files; do
      _do_rm $f
    done

    _do_rm $_DOTFILES_MARKER
  fi
}

function _resolve_dirname () {
  echo $(cd "$1" && pwd)
}

function _abs_dirname () {
  echo $(_resolve_dirname "$(dirname "$1")")
}

function dotfiles () {
  local script_dir=$(_abs_dirname $_SCRIPT_PATH)
  local dotfiles_source=$(_resolve_dirname "$script_dir/../src")
  local dotfiles_private=$(_resolve_dirname "$HOME/Dropbox/dotfiles")

  if [[ $1 == "--reset" ]]; then
    _reset_dotfiles
  fi

  if [[ ! -f $_DOTFILES_MARKER ]]; then
    _link_files_in_dir $dotfiles_source
    _link_files_in_dir $dotfiles_private
  fi
}
