# dotfiles
My dotfiles for OSX, Linux, and Windows, as well as my system setup for OSX. For cli applications in whatever OS, I've got me a `linkdots` script that links my dotfiles into the home directory. For OSX, I have a brewfile to manage my cli applications with homebrew, a couple caskfiles to manage my gui applications with homebrew-cask, and a mackup configuration to save and sync my gui application preferences.

Finally, I've got a 

## dotfile usage
to start using these dotfiles, open a terminal and:

1. `$ git clone mcous/dotfiles` (if you have [hub](http://hub.github.com/) installed)
2. `$ chmod +x dotfiles/makedots` 
3. `$ dotfiles/makedots`

## linking the dotfiles
the `makedots` script does a few things:

* finds every file in `dotfiles` that doesn't have any dots in the filename, isn't the `makedots` script, and isn't listed in `do_not_link`
* does the same thing in `~/Dropbox/privatedots` if it exists
* backs up any matching, non-symlink dotfiles it finds in `~` to `~/dotfiles_old`
* symlinks the `files` to `.files` in `~`

## deploying to new OSX install
I've got an (untested) deploy script named `deploy` that's supposed to set up my system from a new OSX install. 

1. ask for user github email, generate an ssh keypair, copy public key to the clipboard, and open github ssh page
    * `$ ssh-keygen -t rsa -C "$EMAIL"`
    * `$ ssh-add ~/.ssh/id_rsa`
    * `$ pbcopy < ~/.ssh/id_rsa.pub`
    * `$ open https://github.com/settings/ssh`
2. install Xcode CLT (this will take a little while)
    * `$ xcode-select --install` on Mavericks
3. install homebrew
    * `$ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"`
4. install gui pkgs (includes XQuartz for later CLI applications, and requires password)
    * `$ curl -fSsl https://raw.github.com/mcous/dotfiles/master/caskfile_pkg > Brewfile && brew bundle && rm Brewfile`
5. install homebrew apps
    * `$ curl -fSsl https://raw.github.com/mcous/dotfiles/master/brewfile > Brewfile && brew bundle && rm Brewfile`
6. install remaining gui apps
    * `$ curl -fSsl https://raw.github.com/mcous/dotfiles/master/caskfile > Brewfile && brew bundle && rm Brewfile`
7. use hub to clone dotfiles (will require github password and two-factor)
    * `$ hub clone -p dotfiles ~/dotfiles`
    * `$ chomd +x ~/dotfiles/makedots && ~/dotfiles/makedots`
8. set up dropbox and let stuff sync (most importantly, this is where gui app prefs live)
    * `$ open ~/Applications/Dropbox`
    * prompt for user confirmation that `~/Dropbox/mackup` has synced
    * `$ mackup restore`
9. exit the terminal session
    * `$ echo "exiting terminal session. ok to close window" && exit 0`
