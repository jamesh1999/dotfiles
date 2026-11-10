# TODO

Suggestions from a review that haven't been applied yet.

## Security
- [ ] Rotate the pony.cx upload credentials hard-coded in `bin/screenshot.sh`, then read them from outside the repo (e.g. `secret-tool lookup service pony.cx`). Consider scrubbing them from history.
- [ ] Narrow the direnv whitelist in `direnv.toml` from `~/Repositories` so third-party clones don't run their `.envrc` automatically.
- [ ] Add a pre-commit hook with `gitleaks`, `shellcheck` and `stylua`.

## Bugs
- [ ] `.vimrc`: insert-mode `<C-hjkl>` maps to `<C-w>…`, which deletes the previous word. Remove them, as was done for Neovim.
- [ ] `hyprland.lua`: `DP-2` and `HDMI-A-1` both sit at `0x0` and overlap.
- [ ] `screenshot.sh`: use `curl -f` so a failed upload doesn't copy the error page, and quote `$url`.
- [ ] Shell: zoxide warns that `zoxide init` isn't the last thing in `.zshrc`.
- [ ] Shell: something sourced at start-up uses `[ a == b ]`, which fails in zsh (`= not found`). Use `=` or `[[ … ]]`.
- [ ] Claude statusline (`.claude/statusline-command.sh`):
  - `git --git-dir="$current_dir/.git"` misses subdirectories and worktrees; use `git -C "$current_dir"`.
  - Width is measured in bytes (`wc -c`), so the padding is off by the multi-byte powerline glyphs.
  - `tput cols` likely returns 80 when not attached to a terminal.

## Neovim
- [ ] Show diagnostics inline again (off by default since 0.11): `vim.diagnostic.config({ virtual_text = true })` or `virtual_lines = { current_line = true }`.
- [ ] Enable the `ruff` and `lua_ls` language servers.
- [ ] `opt.undofile = true` for persistent undo.
- [ ] Highlight on yank: `TextYankPost` autocmd calling `vim.hl.on_yank()`.
- [ ] gitsigns keymaps: `]c`/`[c`, `<leader>hs`/`<leader>hr`, `<leader>hb`.
- [ ] Telescope pickers: `lsp_references`, `diagnostics`, `resume`.
- [ ] `vim-tmux-navigator` for seamless `C-hjkl` across Neovim splits and tmux panes (takes `C-l` from the shell).

## Git
- [ ] `delta` as the pager (`core.pager = delta`, `interactive.diffFilter = delta --color-only`), with a Nord theme.
- [ ] `rerere.enabled = true`, `diff.algorithm = histogram`, `commit.verbose = true`.
- [ ] `[includeIf "gitdir:~/Repositories/"]` to separate the work identity from personal.
- [ ] Remove the unused `[difftool "vscode"]`/`[mergetool "vscode"]` blocks and the stale "VSCode for diff/merge" comment.
- [ ] `.gitignore-global`: ignore `CLAUDE.local.md` and `.claude/settings.local.json` instead of `/CLAUDE.md` and `/.claude`, so team CLAUDE.md files can still be added.
- [ ] Track `.config/lazygit/config.yml` with delta as the pager and Nord colours.

## Shell
- [ ] `Aloxaf/fzf-tab` in `.zsh_plugins.txt` (load fzf bindings via `zvm_after_init_commands` so `zsh-vi-mode` doesn't reset them).
- [ ] oh-my-posh segments: `status`, `executiontime` (above ~2s), `nix-shell`/`python`.

## tmux
- [ ] `tmux-continuum` to save and restore sessions automatically alongside resurrect.
- [ ] [sesh](https://github.com/joshmedeski/sesh) in a popup to jump to project sessions: `bind f display-popup -E "sesh connect \$(sesh list | fzf)"`.

## Claude Code
- [ ] Allow read-only git in `.claude/settings.json`: `Bash(git diff:*)`, `Bash(git log:*)`, `Bash(git status:*)`, `Bash(git show:*)`.
- [ ] `Notification` hook running `notify-send "Claude Code" "Needs input"`.

## Hyprland
- [ ] `SUPER + SHIFT + arrows` to move windows, plus a resize submap.
- [ ] `idle_inhibitor` module in waybar.
- [ ] `hyprsunset` for a night light.
- [ ] Split monitors out of `hyprland.lua` per host so the config works on other machines.
- [ ] `XDG_MENU_PREFIX=arch-` in `uwsm/env-hyprland` leaves Dolphin's "Open with" empty if used outside Arch.

## Other
- [ ] alacritty: `new-session -ADs main` makes every terminal window mirror the same session; `new-session -t main` gives each window its own view.
- [ ] Delete the stock ranger `commands.py` (the `my_edit` sample) and `commands_full.py`.
- [ ] Install the Hack Nerd Font from a package manager/Nix instead of committing 30 MB of fonts.
- [ ] Optional: a `flake.nix` `buildEnv` of CLI tools (`nix profile install ~/dotfiles`) for the same versions on Debian and Arch.
