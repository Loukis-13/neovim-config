return {
    {
        "julienvincent/nvim-paredit", -- https://github.com/julienvincent/nvim-paredit
        config = function()
            local paredit = require("nvim-paredit")

            paredit.setup({
                use_default_keys = false,
                keys = {
                    ["<localleader>@"] = { paredit.unwrap.unwrap_form_under_cursor, "Splice sexp" },
                    ["<localleader>o"] = { paredit.api.raise_element, "Raise element" },
                    ["<localleader>O"] = { paredit.api.raise_form, "Raise form" },
                    -- ["<C-A-Up>"] = { paredit.api.slurp_backwards, "Slurp forwards" },
                    -- ["<C-A-Down>"] = { paredit.api.barf_backwards, "Barf backwards" },

                    ["<C-A-Left>"] = { paredit.api.slurp_forwards, "Slurp forwards" },
                    ["<C-A-Right>"] = { paredit.api.barf_forwards, "Barf forwards" },
                    ["<A-Right>"] = {
                        paredit.api.move_to_next_element_tail,
                        "Jump to next element tail",
                        repeatable = false,
                        mode = { "n", "i", "x", "o", "v" },
                    },
                    ["<A-Left>"] = {
                        paredit.api.move_to_prev_element_head,
                        "Jump to previous element head",
                        repeatable = false,
                        mode = { "n", "i", "x", "o", "v" },
                    },
                    ["<A-Up>"] = {
                        paredit.api.drag_element_backwards,
                        "Slurp forwards",
                        mode = { "n", "x", "o", "v" },
                    },
                    ["<A-Down>"] = {
                        paredit.api.drag_element_forwards,
                        "Barf backwards",
                        mode = { "n", "x", "o", "v" },
                    },
                }
            })
        end
    },
    {
        "windwp/nvim-autopairs", -- https://github.com/windwp/nvim-autopairs
        event = "InsertEnter",
        opts = {},
    },
}
