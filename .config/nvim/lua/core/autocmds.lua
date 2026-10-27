-- ======================
-- Autocommands
-- ======================

-- Wrap markdown files
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {'*.md'},
  callback = function(ev)
    vim.opt_local.wrap = true
  end
})
