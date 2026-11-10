-- LSP servers, nvim-cmp and LuaSnip are tightly coupled,
-- so they are configured together in this file.
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            vim.lsp.enable("basedpyright")
            vim.lsp.enable("clangd")
            vim.lsp.enable("rust_analyzer")
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
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            cmp.setup({
                formatting = {
                    fields = { "icon", "abbr", "menu", "kind" },
                    format = function(entry, vim_item)
                        local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        kind.icon = " " .. (kind.icon or "") .. "  "
                        kind.kind = "   (" .. (kind.kind or "") .. ")"

                        return kind
                    end,
                },
                snippet = {
                    expand = function(args)
                      luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    -- Enter to confirm completion
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),

                    -- (Shift+)Tab navigation
                    ["<Tab>"] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                        cmp.select_next_item()
                      elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                      else
                        fallback()
                      end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                        cmp.select_prev_item()
                      elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                      else
                        fallback()
                      end
                    end, { "i", "s" }),

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

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local builtin = require("telescope.builtin")

                    -- Override Neovim's default LSP maps to use Telescope instead of the quickfix list
                    vim.keymap.set("n", "grd", builtin.lsp_definitions,
                         { buffer = event.buf, desc = "Go to definition", silent = true })

                    vim.keymap.set("n", "grr", builtin.lsp_references,
                         { buffer = event.buf, desc = "Find references", silent = true })

                    vim.keymap.set("n", "gri", builtin.lsp_implementations,
                         { buffer = event.buf, desc = "Find implementations", silent = true })

                    vim.keymap.set("n", "grt", builtin.lsp_type_definitions,
                         { buffer = event.buf, desc = "Go to type definition", silent = true })

                    vim.keymap.set("n", "gO", builtin.lsp_document_symbols,
                         { buffer = event.buf, desc = "Document symbols", silent = true })

                    vim.keymap.set("n", "gre", vim.diagnostic.open_float,
                         { buffer = event.buf, desc = "Show error / warning", silent = true })
                end,
            })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end
    }
}
