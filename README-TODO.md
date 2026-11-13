# TODO

Suggestions from a review that haven't been applied yet.

## Security
- [ ] Rotate the pony.cx upload credentials hard-coded in `bin/screenshot.sh`, then read them from outside the repo (e.g. `secret-tool lookup service pony.cx`). Consider scrubbing them from history.

## Bugs
- [ ] `.vimrc`: insert-mode `<C-hjkl>` maps to `<C-w>…`, which deletes the previous word. Remove them, as was done for Neovim.
- [ ] `screenshot.sh`: use `curl -f` so a failed upload doesn't copy the error page, and quote `$url`.
- [ ] Claude statusline (`.claude/statusline-command.sh`):
  - `git --git-dir="$current_dir/.git"` misses subdirectories and worktrees; use `git -C "$current_dir"`.
  - Width is measured in bytes (`wc -c`), so the padding is off by the multi-byte powerline glyphs.
  - `tput cols` likely returns 80 when not attached to a terminal.

## Neovim
- [ ] Show diagnostics inline again (off by default since 0.11): `vim.diagnostic.config({ virtual_text = true })` or `virtual_lines = { current_line = true }`.
- [ ] Enable the `ruff` and `lua_ls` language servers.
- [ ] gitsigns keymaps: `]c`/`[c`, `<leader>hs`/`<leader>hr`, `<leader>hb`.

## Claude Code
- [ ] Allow read-only git in `.claude/settings.json`: `Bash(git diff:*)`, `Bash(git log:*)`, `Bash(git status:*)`, `Bash(git show:*)`.
- [ ] `Notification` hook running `notify-send "Claude Code" "Needs input"`.

## Hyprland
- [ ] `idle_inhibitor` module in waybar.
