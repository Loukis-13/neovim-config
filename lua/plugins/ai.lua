return {
    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        -- dependencies = { "copilotlsp-nvim/copilot-lsp" },
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "copilotlsp-nvim/copilot-lsp",
        enabled = false,
        init = function()
            vim.g.copilot_nes_debounce = 500
            vim.lsp.enable("copilot_ls")

            vim.keymap.set("n", "<tab>", function()
                local bufnr = vim.api.nvim_get_current_buf()
                local state = vim.b[bufnr].nes_state
                if state then
                    -- Try to jump to the start of the suggestion edit.
                    -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
                    local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                        or (
                            require("copilot-lsp.nes").apply_pending_nes()
                            and require("copilot-lsp.nes").walk_cursor_end_edit()
                        )
                    return nil
                else
                    -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
                    return "<C-i>"
                end
            end, { desc = "Accept Copilot NES suggestion", expr = true })

            -- Clear copilot suggestion with Esc if visible, otherwise preserve default Esc behavior
            vim.keymap.set({"n", "i"}, "<esc>", function()
                if not require("copilot-lsp.nes").clear() then
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
                end
            end, { desc = "Clear Copilot suggestion or fallback" })
        end,
        opts = {
            nes = {
                move_count_threshold = 3, -- Clear after 3 cursor movements
            }
        }
    },

    -- Avante
    {
        "yetone/avante.nvim",
        enabled = false,
        build = "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            instructions_file = "avante.md",
            provider = "copilot",
            -- selection = {
            --     hint_display = "none",
            -- },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "folke/snacks.nvim",
            "echasnovski/mini.icons",
            -- "zbirenbaum/copilot.lua",    -- for providers='copilot'
            -- {
            --     -- support for image pasting
            --     "HakonHarnes/img-clip.nvim",
            --     event = "VeryLazy",
            --     opts = {
            --         -- recommended settings
            --         default = {
            --             embed_image_as_base64 = false,
            --             prompt_for_file_name = false,
            --             drag_and_drop = {
            --                 insert_mode = true,
            --             },
            --         },
            --     },
            -- },
        },
    }
}
