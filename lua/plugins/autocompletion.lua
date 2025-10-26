return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'enter',
                ['<Esc>'] = { 'hide', 'fallback' },
                ['<Up>'] = { 'fallback' },
                ['<Down>'] = { 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
            },
            cmdline = {
                keymap = { preset = 'inherit' },
                -- completion = { menu = { auto_show = true } },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = {
                list = { selection = { preselect = false, auto_insert = false } },
                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = {
                    enabled = vim.g.ai_cmp,
                },
            },
            snippets = {
                preset = "default",
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
}
