return {
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
        init = function()
            local vaults_path = vim.fn.expand("~") .. "/vaults"
            local git_opts = { cwd = vaults_path, text = true }

            local function show_and_wait(msgs)
                table.insert(msgs, { "Press any key to continue...", "Comment" })
                vim.api.nvim_echo(msgs, true, {})
                vim.fn.getchar()
            end

            local function add_output(chunks, result, label)
                if result.code == 0 and result.stdout ~= "" then
                    table.insert(chunks, { label .. ":\n" .. result.stdout .. "\n", "Info" })
                end
                if result.code ~= 0 and result.stderr ~= "" then
                    table.insert(chunks, { label .. " error:\n" .. result.stderr .. "\n", "ErrorMsg" })
                end
            end

            -- Pull changes on enter
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    if not vim.startswith(vim.fn.getcwd(), vaults_path) then
                        return
                    end
                    vim.notify("Pulling changes...")
                    vim.system({ "git", "pull", "--ff-only" }, git_opts, function(result)
                        vim.schedule(function()
                            if result.code == 0 then
                                vim.notify(result.stdout, vim.log.levels.INFO)
                            else
                                vim.notify(result.stderr, vim.log.levels.ERROR)
                            end
                        end)
                    end)
                end,
            })

            -- Cmmit changes on exit
            vim.api.nvim_create_autocmd("VimLeavePre", {
                callback = function()
                    if not vim.startswith(vim.fn.getcwd(), vaults_path) then
                        return
                    end

                    vim.notify("Commiting changes...")

                    local status = vim.system({ "git", "diff-index", "--quiet", "HEAD", "--" }, git_opts):wait()

                    if status.code == 0 then
                        vim.notify("No changes to sync")
                        return
                    end

                    local commit_msg = vim.fn.strftime("%Y-%m-%d %H:%M") .. " - " .. vim.fn.expand("$USER")
                    local add_result = vim.system({ "git", "add", "-A" }, git_opts):wait()
                    local commit_result = vim.system({ "git", "commit", "-m", commit_msg }, git_opts):wait()
                    local push_result = vim.system({ "git", "push" }, git_opts):wait()

                    local chunks = {}
                    if push_result.code == 0 then
                        table.insert(chunks, { "Git sync completed successfully!\n", "MoreMsg" })
                    else
                        table.insert(chunks, { "Git sync encountered errors.\n", "ErrorMsg" })
                    end
                    add_output(chunks, add_result, "Add")
                    add_output(chunks, commit_result, "Commit")
                    add_output(chunks, push_result, "Push")
                    show_and_wait(chunks)
                end,
            })
        end,
        config = function()
            require("obsidian").setup({
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
