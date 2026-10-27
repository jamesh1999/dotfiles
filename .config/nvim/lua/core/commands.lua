-- ======================
-- Commands
-- ======================

-- :W sudo save
vim.api.nvim_create_user_command("W", function()
  vim.cmd("w !sudo tee % > /dev/null")
end, {})

vim.cmd([[cnoreabbrev qw wq]])
