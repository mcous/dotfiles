# dotfiles

Dotfiles and `zsh` configuration. Requires [sheldon] and [starship].

```shell
brew install sheldown starship
git clone git@github.com:mcous/dotfiles.git
source dotfiles/plugins/dotfiles.zsh
dotfiles
exit
```

[sheldon]: https://sheldon.cli.rs/
[starship]: https://starship.rs/

## Adding/removing dotfiles

Dotfiles in `dotfiles/src` are symlinked to `$HOME`.

1. Add/remove file to/from `dotfiles/src`
2. Run `dotfiles --reset`

If a real, non-symlink file already exists for a given dotfile, it will not be overwritten.

## License

This code is released into the [public domain].

[public domain]: https://unlicense.org/
