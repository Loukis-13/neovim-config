return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = true,
        event = {
            "BufReadPre " .. vim.fn.expand "~" .. "/vaults/*.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/vaults/*.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            workspaces = {
                -- {
                --     name = "personal",
                --     path = "~/vaults/personal",
                -- },
                {
                    name = "nubank",
                    path = "~/vaults/nubank",
                },
            },
        },
    },
}
