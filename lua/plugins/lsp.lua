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
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lsp_defaults.capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end,
                        { buffer = event.buf, desc = "Open documentation" })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })
                    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })

                    -- local client = vim.lsp.get_client_by_id(event.data.client_id)
                    -- if client:supports_method("textDocument/completion") then
                    --     vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
                    -- end
                end,
            })

            -- require("lspconfig").gleam.setup({})
            vim.lsp.enable("gleam")
        end
    },
}
