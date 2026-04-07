-- ======================
-- Bootstrap lazy.nvim
-- ======================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- ======================
-- Plugins
-- ======================
require("lazy").setup({
  { "vim-airline/vim-airline" },
  { "chrisbra/Colorizer" },
  { "sheerun/vim-polyglot" },
  { "jamesh1999/nord-vim" },
  { "jasonccox/vim-wayland-clipboard" },
})

-- ======================
-- Colour setup
-- ======================
vim.opt.termguicolors = false
vim.cmd.colorscheme("nord")

-- ======================
-- Settings
-- ======================
local opt = vim.opt

opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.magic = true
opt.number = true
opt.relativenumber = true
opt.swapfile = false
opt.splitbelow = true
opt.splitright = true
opt.visualbell = true
opt.wildmenu = true
opt.ruler = false
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.scrolloff = 4

-- ======================
-- Keybinds
-- ======================
local keymap = vim.keymap.set

-- Clear search highlight
keymap("n", "<Esc>", ":noh<CR>")

-- Insert jj to escape
keymap("i", "jj", "<Esc>")

-- Disable arrow keys
local modes = { "n", "i" }
for _, mode in ipairs(modes) do
  keymap(mode, "<left>", "<nop>")
  keymap(mode, "<right>", "<nop>")
  keymap(mode, "<up>", "<nop>")
  keymap(mode, "<down>", "<nop>")
end

-- Better regex
keymap("n", "/", "/\\v")
keymap("v", "/", "/\\v")
vim.cmd([[cnoremap %s/ %smagic/]])
vim.cmd([[cnoremap \>s/ \>smagic/]])
keymap("n", ":g/", ":g/\\v")
keymap("n", ":g//", ":g//")

-- Split navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("i", "<C-h>", "<C-w>h")
keymap("i", "<C-l>", "<C-w>l")
keymap("i", "<C-j>", "<C-w>j")
keymap("i", "<C-k>", "<C-w>k")

-- ======================
-- Commands
-- ======================
-- :W sudo save
vim.api.nvim_create_user_command("W", function()
  vim.cmd("w !sudo tee % > /dev/null")
end, {})

vim.cmd([[cnoreabbrev qw wq]])

-- ======================
-- Plugin configuration
-- ======================
vim.g.airline_powerline_fonts = 1
vim.g.python_highlight_indent_errors = 1
vim.g.python_highlight_space_errors = 1
vim.g.cpp_class_decl_highlight = 1
vim.g.cpp_class_scope_highlight = 1
vim.g.cpp_no_boost = 1
