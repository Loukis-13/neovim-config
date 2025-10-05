return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
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
