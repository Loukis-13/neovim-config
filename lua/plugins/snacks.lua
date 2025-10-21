return {
    {
        "folke/snacks.nvim", -- https://github.com/folke/snacks.nvim
        priority = 1000,
        lazy = false,
        opts = {
            words = {},
            gitbrowse = {},
            lazygit = {},
            bigfile = {},
            image = {},
            quickfile = {},
            statuscolumn = {
                right = { "mark", "sign" },
                left = { "fold", "git" }
            },
            explorer = {},
            picker = {
                sources = {
                    explorer = {
                        win = {
                            list = {
                                keys = {
                                    ["<c-b>"] = { "cancel", mode = { "i", "n" } },
                                    ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                                    ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                                }
                            }
                        }
                    }
                }
            },
            dashboard = {
                sections = {
                    { section = "header" },
                    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    { section = "startup" },

                    { pane = 2, padding = 7 },
                    { pane = 2, title = "Obsidian Notes" },
                    function()
                        local files = vim.fn.glob("~/vaults/**", true, true)
                        local entries = {}
                        for _, file in ipairs(files) do
                            if vim.fn.isdirectory(file) == 1 then
                                table.insert(entries, {
                                    pane = 2,
                                    indent = 2,
                                    title = vim.fn.fnamemodify(file, ":t"),
                                })
                            else
                                table.insert(entries, {
                                    pane = 2,
                                    indent = 3,
                                    icon = "󰣏",
                                    file = file,
                                    action = function()
                                        vim.cmd("edit " .. file)
                                        vim.cmd.cd(vim.fn.fnamemodify(file, ":h"))
                                    end,
                                })
                            end
                        end
                        return entries
                    end
                },
            },
            -- scroll = {},   -- no noticeble changes
            -- notifier = {},
        },
        keys = {
            { "]]",         "<Cmd>lua Snacks.words.jump(1, true)<CR>",  desc = "Next reference" },
            { "[[",         "<Cmd>lua Snacks.words.jump(-1, true)<CR>", desc = "Previous reference" },
            { "<leader>gB", "<Cmd>lua Snacks.gitbrowse()<CR>",          desc = "Git Browse",        mode = { "n", "v" } },
            { "F",          "<Cmd>lua Snacks.picker.grep()<CR>",        desc = "Grep search" },
            { "G",          "<Cmd>lua Snacks.lazygit()<CR>",            desc = "Lazygit" },
            { "<C-b>",      "<Cmd>lua Snacks.explorer()<CR>",           desc = "File explorer" },
            -- { "qq",         "<Cmd>lua Snacks.bufdelete.delete()<CR>",   desc = "Delete buffer" }
        }
    },
}
