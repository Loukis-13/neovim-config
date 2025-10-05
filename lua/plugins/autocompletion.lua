return {
    {
        "hrsh7th/nvim-cmp", -- https://github.com/hrsh7th/nvim-cmp
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    -- { name = "copilot" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },
}
