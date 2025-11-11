---@diagnostic disable-next-line: unused-function, unused-local
local function accept_nes_suggestion(cmp)
    if vim.b[vim.api.nvim_get_current_buf()].nes_state then
        cmp.hide()
        return (
            require("copilot-lsp.nes").apply_pending_nes()
            and require("copilot-lsp.nes").walk_cursor_end_edit()
        )
    end
    if cmp.snippet_active() then
        return cmp.accept()
    else
        return cmp.select_and_accept()
    end
end

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
            keymap = {
                preset = 'enter',
                ['<Esc>'] = { 'hide', 'fallback' },
                -- ['<Up>'] = { 'fallback' },
                -- ['<Down>'] = { 'fallback' },
                -- ['<Tab>'] = { 'select_next', accept_nes_suggestion, 'fallback' },
                -- ['<S-Tab>'] = { 'select_prev', 'fallback' },
            },
            cmdline = {
                keymap = {
                    preset = 'inherit',
                    -- ['<Tab>'] = { 'show', 'select_next', 'fallback' },
                },
                completion = { menu = { auto_show = true } },
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
                default = { 'lsp', 'path', 'snippets', 'buffer', "copilot" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                }
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
}
