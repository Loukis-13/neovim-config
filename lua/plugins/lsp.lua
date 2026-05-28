return {
    {
        "mason-org/mason.nvim",
        opts = {},
        keys = {
            { "M", "<cmd>Mason<CR>", desc = "Mason" },
        }
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "saghen/blink.cmp", },
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config

            lsp_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lsp_defaults.capabilities,
                require('blink.cmp').get_lsp_capabilities()
            )

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    vim.lsp.inlay_hint.enable(true, { client_id = event.data.client_id, bufnr = event.buf })
                    vim.lsp.codelens.enable(true, { client_id = event.data.client_id })

                    -- -- Completion
                    -- vim.lsp.completion.enable(true, event.data.client_id, event.buf, {
                    --     autotrigger = true,
                    --     convert = function(item)
                    --         return { abbr = item.label:gsub('%b()', '') }
                    --     end,
                    -- })
                    -- vim.keymap.set('i', '<c-space>', function()
                    --     vim.lsp.completion.get()
                    -- end)
                    --
                    -- -- Inline completion
                    -- vim.lsp.inline_completion.enable()
                    -- vim.keymap.set('i', '<Tab>', function()
                    --     if not vim.lsp.inline_completion.get() then
                    --         return '<Tab>'
                    --     end
                    -- end, { expr = true, desc = 'Accept the current inline completion' })

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })
                    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })
                end,
            })
        end
    },
}
