-- Ranger file explorer
return {
    "kevinhwang91/rnvimr",
    config = function()
        vim.g.rnvimr_enable_ex = 1
        vim.g.rnvimr_enable_picker = 1
        vim.g.rnvimr_enable_bw = 1
        vim.keymap.set("n", "<leader>e", "<cmd>RnvimrToggle<CR>", {desc="Open file explorer"})
    end,
}
