return {
    {
        "Olical/conjure",
        lazy = false,
        init = function()
            vim.g["conjure#mapping#doc_word"] = false -- Disable the documentation mapping
            -- vim.g["conjure#log#fold#enabled"] = true

            vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { "deftest", "defflow", "defspec" }
            -- vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
            vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
            vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "lein repl"
        end,
        keys = {
            { "<localleader>dd", "<cmd>ConjureCljDebugInit<CR>",                 desc = "Start Clojure debugging" },
            { "<localleader>dc", "<cmd>ConjureCljDebugInput continue<CR>",       desc = "Debug continue" },
            { "<localleader>dl", "<cmd>ConjureCljDebugInput locals<CR>",         desc = "Debug locals" },
            { "<localleader>dI", "<cmd>ConjureCljDebugInput inspect<CR>",        desc = "Debug inspect" },
            { "<localleader>dt", "<cmd>ConjureCljDebugInput trace<CR>",          desc = "Debug trace" },
            { "<localleader>dh", "<cmd>ConjureCljDebugInput here<CR>",           desc = "Debug here" },
            { "<localleader>da", "<cmd>ConjureCljDebugInput continue-all<CR>",   desc = "Debug continue-all" },
            { "<localleader>dn", "<cmd>ConjureCljDebugInput next<CR>",           desc = "Debug next" },
            { "<localleader>do", "<cmd>ConjureCljDebugInput out<CR>",            desc = "Debug out" },
            { "<localleader>dj", "<cmd>ConjureCljDebugInput inject<CR>",         desc = "Debug inject" },
            { "<localleader>dp", "<cmd>ConjureCljDebugInput inspect-prompt<CR>", desc = "Debug inspect-prompt" },
            { "<localleader>dq", "<cmd>ConjureCljDebugInput quit<CR>",           desc = "Debug quit" },
            { "<localleader>di", "<cmd>ConjureCljDebugInput in<CR>",             desc = "Debug in" },
            { "<localleader>de", "<cmd>ConjureCljDebugInput eval<CR>",           desc = "Debug eval" },
        }
    },
    {
        "Olical/aniseed",
        ft = "fnl"
    },
}
