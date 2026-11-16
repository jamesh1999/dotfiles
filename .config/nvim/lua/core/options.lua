-- ======================
-- Options
-- ======================

vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.magic = true
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.visualbell = true
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.sidescrolloff = 8
vim.opt.pumheight = 10
vim.opt.undofile = true

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = { current_line = true }
})
