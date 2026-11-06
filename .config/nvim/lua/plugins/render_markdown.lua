-- In-buffer Markdown rendering
return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    opts = {
        heading = { width = "block", left_pad = 2, right_pad = 4, position = "inline" },
        code = { width = "block", min_width = 80, left_pad = 1 },
        completions = { lsp = { enabled = true } },
        sign = { enabled = false },
    },
}
