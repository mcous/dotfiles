# dotfiles

Dotfiles and `zsh` configuration. Uses [starship] for the prompt and [mise] for language versions. `zsh` plugins are cloned from GitHub on first shell start; update them with `zsh-plugins-update`.

```shell
brew install starship mise
git clone git@github.com:mcous/dotfiles.git
source projects/dotfiles/plugins/dotfiles.zsh
dotfiles
exit
```

[starship]: https://starship.rs/
[mise]: https://mise.jdx.dev/

## Adding/removing dotfiles

Dotfiles in `dotfiles/src` are symlinked to `$HOME`.

1. Add/remove file to/from `dotfiles/src`
2. Run `dotfiles --reset`

If a real, non-symlink file already exists for a given dotfile, it will not be overwritten.

## License

This code is released into the [public domain].

[public domain]: https://unlicense.org/
