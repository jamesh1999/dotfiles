return {
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
}
