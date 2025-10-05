return {
    {
        "folke/snacks.nvim", -- https://github.com/folke/snacks.nvim
        event = "VeryLazy",
        init = function()
            -- vim.g.loaded_netrwPlugin = 1
            -- vim.g.loaded_netrw = 1
        end,
        opts = {
            words = {},
            gitbrowse = {},
            lazygit = {},
            picker = {
                --     sources = {
                --         explorer = {
                --             win = {
                --                 list = {
                --                     keys = {
                --                         ["<c-b>"] = { "cancel", mode = { "i", "n" } },
                --                         ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                --                         ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                --                     }
                --                 }
                --             }
                --         }
                --     }
            },
            -- explorer = {
            --     replace_netrw = true
            -- },
            bigfile = {},
            image = {},
            quickfile = {},
            statuscolumn = {
                right = { "mark", "sign" },
                left = { "fold", "git" }
            },
        },
        keys = {
            { "]]",         "<Cmd>lua Snacks.words.jump(1, true)<CR>",  desc = "Next reference" },
            { "[[",         "<Cmd>lua Snacks.words.jump(-1, true)<CR>", desc = "Previous reference" },
            { "<leader>gB", "<Cmd>lua Snacks.gitbrowse()<CR>",          desc = "Git Browse",        mode = { "n", "v" } },
            { "<leader>gg", "<Cmd>lua Snacks.lazygit()<CR>",            desc = "Lazygit" },
            { "F",          "<Cmd>lua Snacks.picker.grep()<CR>",        desc = "Grep search" },
            { "G",          "<Cmd>lua Snacks.lazygit()<CR>",            desc = "Lazy Git" },
            -- { "<C-b>",      "<Cmd>lua Snacks.explorer()<CR>",           desc = "File explorer" },
        }
    },
}
