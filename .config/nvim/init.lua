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


-- Set leader key first
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- ======================
-- Plugins
-- ======================
require("lazy").setup({
    { "chrisbra/Colorizer" },
    { "jamesh1999/nord-vim" },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                theme = "nord",
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                },
            })
        end
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local ts = require("nvim-treesitter")
            local languages = { "python" , "rust", "cpp" }

            ts.setup({})
            ts.install(languages)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "lua", "python", "rust", "cpp" },
                callback = function()
                vim.treesitter.start()
                end,
            })
        end,
        build = ":TSUpdate",
        lazy = false,
    },

    { 
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
        require('rainbow-delimiters.setup').setup({
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        })
        end
    },

    -- Git status
    { "lewis6991/gitsigns.nvim" },

    -- Ranger file explorer
    {
        "kevinhwang91/rnvimr",
        config = function()
            vim.g.rnvimr_enable_ex = 1
            vim.g.rnvimr_enable_picker = 1
            vim.g.rnvimr_enable_bw = 1
            vim.keymap.set("n", "<leader>e", "<cmd>RnvimrToggle<CR>", {desc="Open file explorer"})
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
            },
        },
    }
})

-- ======================
-- Colour setup
-- ======================
vim.opt.termguicolors = false  -- Consider enabling in future
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
opt.signcolumn = "yes"

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
vim.g.python_highlight_indent_errors = 1
vim.g.python_highlight_space_errors = 1
vim.g.cpp_class_decl_highlight = 1
vim.g.cpp_class_scope_highlight = 1
vim.g.cpp_no_boost = 1
