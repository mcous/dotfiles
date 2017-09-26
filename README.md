# dotfiles

My dotfiles for macOS and Linux

## dotfile usage

To start using these dotfiles, open a terminal and:

```shell
$ dotfiles/link
```

### link script

The `link` script symlinks every file (recursively) in `$HOME/dotfiles/*` that [isn't blacklisted][blacklist] or according to the following scheme:

* Files at `$HOME/dotfiles/filename`

```shell
ln -sf "$HOME/dotfiles/filename" "$HOME/.filename"
```

* Files at `$HOME/dotfiles/path/to/filename`

```shell
ln -sf "$HOME/dotfiles/path/to/filename" "$HOME/.path/to/filename"
```

It also does the same for `$HOME/dropbox/dotfiles/*`. It will try to prompt you before overwriting any non-symlink files.

## license

This code is released into the [public domain][unlicense]

[blacklist]: ./link#L9
[unlicense]: https://unlicense.org/
