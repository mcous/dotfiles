# dotfiles
My dotfiles for OSX, Linux, and Windows, as well as my system setup for OSX. For cli applications in whatever OS, I've got me a `linkdots` script that links my dotfiles into the home directory. For OSX, I also have a brewfile to manage my cli applications with [homebrew](http://brew.sh), a couple caskfiles to manage my gui applications with [homebrew-cask](http://caskroom.io), and a [mackup](https://github.com/lra/mackup) configuration to save and sync my gui application preferences.

Finally, I've got a fancy little (**thouroughly untested**) `deploy` script for setting up a new OSX environment that I can call with:

`$ bash -c "$(curl -fsSL https://raw.github.com/mcous/dotfiles/master/deploy)"`

(that one-liner inspired by the homebrew installer)

## dotfile usage
to start using these dotfiles, open a terminal and:

1. `$ git clone mcous/dotfiles` (if you have [hub](https://hub.github.com) installed)
2. `$ chmod +x dotfiles/linkdots` 
3. `$ dotfiles/linkdots`

## what linkdots do
the `linkdots` script:

1. finds every file in `dotfiles` and `dotfiles/one-level-down` that isn't the `linkdots` script, and isn't listed in `do_not_link`
2. does the same thing in `~/Dropbox/privatedots` if it exists
3. backs up any matching, non-symlink dotfiles it finds in `~` to `~/dotfiles_old`
4. symlinks the `files` to `~/.files` and the `directory/files` to `~/.directory/files`

## deploying to new OSX install
I've got an (**untested**) deploy script named `deploy` that's supposed to set up my system on a new OSX install. It's not an unattended setup, but large chunks (like installing the applications) should be automatic.

### deploy dependencies
    * script is currently hard coded to my dotfiles repository; so be me, I guess

### deploy
1. generates an ssh keypair for github
    * runs `ssh-keygen` with the user following the prompts
    * copies the public key to the clipboard and opens [GitHub's SSH settings page](https://github.com/settings/ssh) for the user to add it to their account
2. installs the command line tools for xcode
    * if on OSX 10.9, runs `xcode-select --install`
    * if on an earlier version, tells the user to install Xcode from the App Store
3. installs homebrew
4. installs pkg'ed gui apps (including xquartz)
    * calls `brew bundle` on `caskfile_pkg`
    * uses homebrew-cask, and the initial run requires the user password
    * because the apps are pkg's, this also requires the password
5. installs cli apps
    * calls `brew bundle` on `brewfile`
6. installs gui apps
    * called `brew bundle` on `caskfile`
7. clones dotfiles
    * this step also sets up `hub`
    * user needs to put in their github username, password, and two-factor code (if enabled)
8. sets up dropbox and syncs important files
    * opens up dropbox (which was installed in step 6)
    * user needs to follow prompts for using dropbox for private dotfiles and/or `mackup`
    * script tries to wait for proper directories to sync before continuing, but it might not work
9. links dotfiles and mackup, which is the same as the user calling:
    * `$ ~/dotfiles/linkdots`
    * `$ mackup restore`
10. exits the script

