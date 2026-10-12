return {
    {
        "folke/snacks.nvim", -- https://github.com/folke/snacks.nvim
        priority = 1000,
        lazy = false,
        opts = {
            words = {},
            gh = {},
            gitbrowse = {},
            lazygit = {
                config = {
                    os = {
                        edit = '[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}})',
                    },
                },
            },
            bigfile = {},
            image = {},
            quickfile = {},
            explorer = {},
            -- scroll = {},   -- no noticeable changes
            -- notifier = {},
            statuscolumn = {
                right = { "mark", "sign" },
                left = { "fold", "git" },
            },
            picker = {
                sources = {
                    explorer = {
                        win = {
                            list = {
                                keys = {
                                    ["<c-b>"] = { "cancel", mode = { "i", "n" } },
                                    ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                                    ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                                },
                            },
                        },
                    },
                },
            },
            dashboard = {
                sections = {
                    { section = "header" },
                    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    { section = "startup" },
                },
            },
        },
        keys = {
            { "]]",         "<Cmd>lua Snacks.words.jump(1, true)<CR>",          desc = "Next reference" },
            { "[[",         "<Cmd>lua Snacks.words.jump(-1, true)<CR>",         desc = "Previous reference" },
            { "<leader>gb", "<Cmd>lua Snacks.gitbrowse()<CR>",                  desc = "Git Browse",                    mode = { "n", "v" } },
            { "F",          "<Cmd>lua Snacks.picker.grep()<CR>",                desc = "Grep search" },
            { "<leader>gg", "<Cmd>lua Snacks.lazygit()<CR>",                    desc = "Lazygit" },
            { "<C-b>",      "<Cmd>lua Snacks.explorer()<CR>",                   desc = "File explorer" },
            { "<leader>.",  function() Snacks.scratch() end,                    desc = "Toggle Scratch Buffer" },
            { "<leader>gp", function() Snacks.picker.gh_pr() end,               desc = "GitHub Pull Requests (open)" },
            { "grr",        function() Snacks.picker.lsp_references() end,      desc = "See references for symbol" },
            { "gri",        function() Snacks.picker.lsp_implementations() end, desc = "See implementations for symbol" }
        }
    },
}
