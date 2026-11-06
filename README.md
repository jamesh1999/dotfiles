# dotfiles

## Packages

### Terminal
- stow
- zsh + [antidote](https://antidote.sh/)
- [oh-my-posh](https://ohmyposh.dev/)
- tmux
- alacritty
- neovim (0.11+) and vim
- ranger
- zoxide
- fzf
- eza
- lazygit
- btop
- fastfetch
- direnv + [nix-direnv](https://github.com/nix-community/nix-direnv)

Neovim plugins also need `git`, `make`, a C compiler and the `tree-sitter` CLI to build.

The Hack Nerd Font is bundled in `.local/share/fonts`.

### Desktop (Arch only)
- hyprland, uwsm, hypridle, hyprlock, hyprpaper, hyprpicker
- waybar, swaync, rofi (+ rofi-emoji)
- cliphist, wl-clipboard, gawk
- grim, slurp, libnotify
- playerctl, brightnessctl, wireplumber, pavucontrol
- dolphin, feh
- kvantum, papirus-icon-theme
- Geist Mono font (for hyprlock)

## Installation

Clone with the cursor theme submodule:
```
git clone --recurse-submodules git@github.com:jamesh1999/dotfiles.git ~/dotfiles
```

For an existing clone:
```
git submodule update --init
```

### Stow
Use GNU `stow` to link to the correct locations.

In the repo root:
```
stow .
```

For this to work, the dotfiles should only exist in the repo. The repo should also mirror the directory structure to un-stow to.

To grab the latest dotfiles from outside the repo:
```
stow --adopt .
```

### Git
`.gitconfig` includes `~/.gituser` for identity, which isn't tracked:
```
[user]
	name = ...
	email = ...
```

### zsh
Install antidote to `~/.antidote`:
```
git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
```

Plugins are listed in `.zsh_plugins.txt` and are installed on the next shell start.

### Neovim
`lazy.nvim` bootstraps itself and installs plugins on first launch; use `:Lazy sync` to update.

Treesitter parsers install automatically. Install the language servers with Mason, or provide them on `PATH`:
```
:MasonInstall basedpyright clangd rust-analyzer
```

### Vim
Install `vim-plug`:
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then in vim:
```
:PlugInstall
```

### tmux
Install `tpm`:
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then inside tmux: `prefix + I`.

### direnv
`direnvrc` loads nix-direnv from the Nix profile:
```
nix profile install nixpkgs#nix-direnv
```

Every `.envrc` under `~/Repositories` is trusted automatically (see `direnv.toml`).

### Hyprland
Monitors in `hyprland.lua` are hard-coded for the desktop. The wallpaper and lock screen both read `~/Pictures/desktop`.

The overview plugin comes from hyprpm:
```
hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm enable Hyprspace
```

Hyprland's autostart only reloads hyprpm, so the rest of the session runs as systemd user services under uwsm:
```
systemctl --user enable --now waybar.service hyprpaper.service hypridle.service swaync.service
```

`hypridle` must be running for the screen to lock on suspend.

The clipboard history (`SUPER + V`) also needs `wl-paste --watch cliphist store` running.
