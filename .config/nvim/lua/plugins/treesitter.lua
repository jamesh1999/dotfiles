return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        local ts = require("nvim-treesitter")
        local languages = { "python" , "rust", "cpp", "markdown", "markdown_inline" }

        ts.setup({})
        ts.install(languages)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "lua", "python", "rust", "cpp", "markdown" },
            callback = function()
            vim.treesitter.start()
            end,
        })
    end,
    build = ":TSUpdate",
    lazy = false,
}
