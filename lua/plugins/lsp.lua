return {
    {
        "mason-org/mason-lspconfig.nvim", -- https://github.com/mason-org/mason-lspconfig.nvim
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig", -- https://github.com/neovim/nvim-lspconfig
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
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })
                    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })
                end,
            })

            -- require("lspconfig").gleam.setup({})
            vim.lsp.enable("gleam")
        end
    },
}
