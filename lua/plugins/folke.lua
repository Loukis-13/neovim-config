return {
    {
        "folke/which-key.nvim", -- https://github.com/folke/which-key.nvim
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function() require("which-key").show({ global = false }) end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "folke/trouble.nvim", -- https://github.com/folke/trouble.nvim
        opts = {},
        keys = { { "<C-k>", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" } }
    },
}
