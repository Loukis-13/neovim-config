return {
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            "fang2hou/blink-copilot"
        },
        version = '1.*',
        opts = {
            enabled = function() return not vim.tbl_contains({ "markdown", "snacks_picker_list" }, vim.bo.filetype) end,
            keymap = { preset = 'enter', },
            cmdline = {
                keymap = {
                    preset = 'inherit',
                    ['<Esc>'] = { "cancel", "fallback" }
                },
                completion = { menu = { auto_show = true } },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = {
                trigger = { show_on_keyword = true },
                list = { selection = { preselect = true, auto_insert = false } },
                accept = { auto_brackets = { enabled = true, }, },
                ghost_text = { enabled = true, },
                menu = {
                    auto_show = false,
                    draw = { treesitter = { "lsp" }, },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
            },
            snippets = {
                preset = "default",
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', "copilot", "obsidian-tasks" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                    ["obsidian-tasks"] = {
                        module = "obsidian-tasks.cmp.source",
                        name = "ObsidianTasks",
                    },
                }
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
}
