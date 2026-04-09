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
            vim.keymap.set({ "n", "i" }, "<esc>", function()
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
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            -- Claude panel
            { "<leader>a",  nil,                              desc = "AI/Claude Code" },
            { "<leader>ag", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
            { "<leader>ac", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        desc = "Send to Claude",     mode = "v" },
            { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>",     desc = "Add file",           ft = { "snacks_picker_list" }, },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny diff" },
        },
    }
}
