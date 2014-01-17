# dotfiles
my dotfiles. don't have many. probably gonna get some more. makedots script backs up old dotfiles and symlinks in new ones.

## usage
to start using these dotfiles, open a terminal and:

1. `$ git clone mcous/dotfiles` (if you have [hub](http://hub.github.com/) installed)
2. `$ chmod +x dotfiles/makedots` 
3. `$ dotfiles/makedots`

## what it do
the makedots script does a few things:

* finds every file in `dotfiles` that doesn't have an extension and isn't the `makedots` script
* does the same thing in `~/Dropbox/privatedots` if it exists
* backs up any matching, non-symlink dotfiles it finds in `~` to `~/dotfiles_old`
* symlinks the `files` to `.files` in `~`
