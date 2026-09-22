return {
    {
        "Loukis-13/sync.nvim",
        opts = { repository = "obsidian-notes" },
    },
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = true,
        event = {
            "BufReadPre */vaults/*.md",
            "BufNewFile */vaults/*.md",
        },
        dependencies = {
            "saghen/blink.cmp",
            { "snapwich/obsidian-tasks.nvim", opts = {} },
        },
        config = function()
            require("obsidian").setup({
                legacy_commands = false,
                ui = {
                    enable = false,
                },
                workspaces = {
                    {
                        name = "personal",
                        path = "~/vaults/personal",
                    },
                    {
                        name = "nubank",
                        path = "~/vaults/nubank",
                    },
                },
                note = {
                    id_func = require("obsidian.builtin").title_id,
                },
                checkbox = {
                    enabled = true,
                    create_new = true,
                    order = { " ", "/", "x" },
                },
                daily_notes = {
                    enabled = true,
                    folder = "daily-notes",
                    template = "templates/daily-notes.md",
                },
            })
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = { "saghen/blink.cmp" },
    },
}
