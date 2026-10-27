-- LSP servers, nvim-cmp and LuaSnip are tightly coupled,
-- so they are configured together in this file.
return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable("basedpyright")
            vim.lsp.enable("clangd")
            vim.lsp.enable("rust-analyzer")
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                formatting = {
                    fields = { "icon", "abbr", "menu", "kind" },
                    format = function(entry, vim_item)
                        local lspkind = require("lspkind")
                        local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        kind.icon = " " .. (kind.icon or "") .. "  "
                        kind.kind = "   (" .. (kind.kind or "") .. ")"

                        return kind
                    end,
                },
                snippet = {
                    expand = function(args)
                      require('luasnip').lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    -- Enter to confirm completion
                    ["<CR>"] = cmp.mapping.confirm({select = false}),

                    -- (Shift+)Tab navigation
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),

                    -- Ctrl+Space to open completions
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),

                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },

                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                    documentation = cmp.config.window.bordered(),
                }
            })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp"
    }
}
