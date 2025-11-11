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
            "saghen/blink.cmp",
            "nvim-treesitter/nvim-treesitter",
        },
        init = function()
            -- Pull changes on enter
            vim.api.nvim_create_autocmd("VimEnter", {
                pattern = vim.fn.expand "~" .. "/vaults/*.md",
                callback = function()
                    os.execute('git pull')
                end
            })

            -- Auto commit and push on exit
            vim.api.nvim_create_autocmd("VimLeavePre", {
                pattern = vim.fn.expand "~" .. "/vaults/*.md",
                callback = function()
                    local handle = io.popen("git status --porcelain")
                    if not handle then return end
                    local output = handle:read("*a")
                    handle:close()
                    if output ~= "" then
                        local message = vim.fn.strftime("%Y-%m-%d %H:%M") .. " - " .. vim.fn.expand("$USER")
                        os.execute('git add -A')
                        os.execute('git commit -m "' .. message .. '"')
                        os.execute('git push')
                    end
                end
            })
        end,
        opts = {
            legacy_commands = false,
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
        },
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = { "saghen/blink.cmp" },
    },
}
