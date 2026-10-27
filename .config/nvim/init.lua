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


-- ======================
-- Leader keys (must be set before any keymap is defined)
-- ======================
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- ======================
-- Core config
-- ======================
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.commands")


-- ======================
-- Plugins
-- ======================
require("lazy").setup({
    -- Theme
    { "jamesh1999/nord-vim" },

    require("plugins.colorizer"),
    require("plugins.lualine"),
    require("plugins.treesitter"),
    require("plugins.rainbow"),
    require("plugins.gitsigns"),
    require("plugins.rnvimr"),
    require("plugins.telescope"),
    require("plugins.which_key"),
    require("plugins.mason"),

    -- LSP + completion (tightly coupled plugins)
    require("plugins.lsp"),
})


-- ======================
-- Colorscheme (requires the nord plugin to be loaded)
-- ======================
vim.cmd.colorscheme("nord")
vim.api.nvim_set_hl(0, 'Normal', { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, 'SignColumn', { fg = "NONE", bg = "NONE" })
