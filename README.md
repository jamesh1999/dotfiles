# dotfiles

## Essential Packages
- stow
- ranger
- zoxide
- tmux
- zsh
- [oh-my-posh](https://ohmyposh.dev/)
- direnv

## Stow Usage
Use GNU `stow` to link to the correct locations

In the repo root:
```
stow .
```

For this to work, the dotfiles should only exist in the repo. The repo should also mirror the directory structure to un-stow to.

To grab the latest dotfiles from outside the repo:
```
stow --adopt .
```

## Other installation
In vim:
Install `vim-plug`
```
:PlugInstall
```

In tmux:
Install `tpm`
prefix + I
