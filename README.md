# dotfiles

My dotfiles for OSX, Linux, and Windows, as well as my system setup for OSX.

## dotfile usage

To start using these dotfiles, open a terminal and:

1. `$ git clone mcous/dotfiles` (if you have [hub](https://hub.github.com) installed)
2. `$ chmod +x dotfiles/linkdots` 
3. `$ dotfiles/linkdots`

### what linkdots does

The `linkdots` script:

1. Finds every file in `dotfiles` and `dotfiles/one-level-down` that isn't the `linkdots` script, and isn't listed in `do_not_link`
2. Does the same thing in `~/Dropbox/privatedots` if it exists
3. Backs up any matching, non-symlink dotfiles it finds to `~` to `~/dotfiles_old`
4. Symlinks the `files` to `~/.files` and the `directory/files` to `~/.directory/files`
