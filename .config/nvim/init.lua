-- ======================
-- Bootstrap lazy.nvim
-- ======================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)


-- Set leader key first
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true


-- ======================
-- Plugins
-- ======================
require("lazy").setup({
    {
        "catgoose/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({})
        end
    },
    { "jamesh1999/nord-vim" },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local custom_nord = require("lualine.themes.nord");
            custom_nord.normal.a = { bg = "#81A1C1", fg = "#3B4252", gui = "bold"};
            custom_nord.insert.a = { bg = "#FDB674", fg = "#3B4252", gui = "bold"};
            custom_nord.visual.a = { bg = "#88C0D0", fg = "#3B4252", gui = "bold"};
            custom_nord.replace.a = { bg = "#ECEFF4", fg = "#3B4252", gui = "bold"};
            custom_nord.inactive.a = { bg = "#FDB674", fg = "#3B4252", gui = "bold"};

            custom_nord.normal.b = { bg = "#4C566A", fg = "#E5E9F0"};
            custom_nord.insert.b = { bg = "#4C566A", fg = "#E5E9F0"};
            custom_nord.visual.b = { bg = "#4C566A", fg = "#E5E9F0"};
            custom_nord.replace.b = { bg = "#4C566A", fg = "#E5E9F0"};
            custom_nord.inactive.b = { bg = "#4C566A", fg = "#E5E9F0"};

            custom_nord.normal.c = { bg = "#3B4252", fg = "#E5E9F0"};
            custom_nord.insert.c = { bg = "#3B4252", fg = "#E5E9F0"};
            custom_nord.visual.c = { bg = "#3B4252", fg = "#E5E9F0"};
            custom_nord.replace.c = { bg = "#3B4252", fg = "#E5E9F0"};
            custom_nord.inactive.c = { bg = "#3B4252", fg = "#E5E9F0"};

            require("lualine").setup({
                options = {
                    theme = custom_nord,
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_x = { "filetype" },
                    lualine_y = { "encoding", "fileformat" },
                    lualine_z = { "location" },
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

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            require("telescope").setup({
                defaults = {
                    borderchars = {'─','│','─','│','┌','┐','┘','└' }
                }
            })
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            win = {
                border = {
                    { '┌', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '┐', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                    { '┘', 'FloatBorder' },
                    { '─', 'FloatBorder' },
                    { '└', 'FloatBorder' },
                    { '│', 'FloatBorder' },
                },
            },
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
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable("basedpyright")
            vim.lsp.enable("rust-analyzer")
        end
    }
})

-- ======================
-- Settings
-- ======================
vim.cmd.colorscheme("nord")
vim.api.nvim_set_hl(0, 'Normal', { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, 'SignColumn', { fg = "NONE", bg = "NONE" })

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
opt.wrap = false
opt.sidescrolloff = 8


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

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {'*.md'},
  callback = function(ev)
    vim.opt_local.wrap = true
  end
})

-- ======================
-- Plugin configuration
-- ======================
vim.g.python_highlight_indent_errors = 1
vim.g.python_highlight_space_errors = 1
vim.g.cpp_class_decl_highlight = 1
vim.g.cpp_class_scope_highlight = 1
vim.g.cpp_no_boost = 1
