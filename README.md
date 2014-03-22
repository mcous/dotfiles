# dotfiles
My dotfiles. Don't have many. Probably gonna get some more. `makedots` script backs up old dotfiles and symlinks in new ones. Hopefully soon I'll have a `deploy` script to deploy my OSX system to a new computer or install.

## usage
to start using these dotfiles, open a terminal and:

1. `$ git clone mcous/dotfiles` (if you have [hub](http://hub.github.com/) installed)
2. `$ chmod +x dotfiles/makedots` 
3. `$ dotfiles/makedots`

## what it do
the makedots script does a few things:

* finds every file in `dotfiles` that doesn't have any dots in the filename, isn't the `makedots` script, and isn't listed in `do_not_link`
* does the same thing in `~/Dropbox/privatedots` if it exists
* backs up any matching, non-symlink dotfiles it finds in `~` to `~/dotfiles_old`
* symlinks the `files` to `.files` in `~`

## deploy to new OSX install
Looking to update my laptop soon, so doing some up-front work. Here's the procedure for a deploy script.

1. ask for user github email, generate an ssh keypair, and copy public key to the clipboard
    * `$ ssh-keygen -t rsa -C "$EMAIL"`
    * `$ ssh-add ~/.ssh/id_rsa`
    * `$ pbcopy < ~/.ssh/id_rsa.pub`
2. open github.com ssh page to add key to github account (user does the rest)
    * `$ open https://github.com/settings/ssh`
3. install Xcode CLT (this will take a little while)
    * `$ xcode-select --install` on Mavericks
4. install homebrew
    * `$ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"`
5. install gui pkgs (includes XQuartz for later CLI applications, and requires password)
    * `$ curl -fSsl https://raw.github.com/mcous/dotfiles/master/caskfile_pkg > Brewfile && brew bundle && rm Brewfile`
6. install homebrew apps
    * `$ curl -fSsl https://raw.github.com/mcous/dotfiles/master/brewfile > Brewfile && brew bundle && rm Brewfile`
7. install remaining gui apps
    * `$ curl -fSsl https://raw.github.com/mcous/dotfiles/master/caskfile > Brewfile && brew bundle && rm Brewfile`
8. install hub and use it to clone dotfiles (will require github password and two-factor)
    * `$ brew install hub`
    * `$ hub clone -p dotfiles ~/dotfiles`
9. clone the dotfiles
    * `chomd +x ~/dotfiles/makedots && ~/dotfiles/makedots`
10. exit the terminal session
    * `$ echo "exiting terminal session. ok to close window" && exit 0`
