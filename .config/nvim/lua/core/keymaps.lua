-- ======================
-- Keybinds
-- ======================
local keymap = vim.keymap.set

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", {desc = "Clear search highlighting"})
keymap("i", "jj", "<Esc>", {desc = "Insert jj to escape"})

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

-- Split creation
keymap("n", "<leader>v", "<C-w>v", {desc = "Vertical split"})
keymap("n", "<leader>h", "<C-w>s", {desc = "Horizontal split"})
