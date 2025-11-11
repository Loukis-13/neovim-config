return {
    {
        "Olical/conjure", -- https://github.com/Olical/conjure
        init = function()
            vim.g["conjure#mapping#doc_word"] = false -- Disable the documentation mapping
            -- vim.g["conjure#log#fold#enabled"] = true

            vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { "deftest", "defflow", "defspec" }
            -- vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
            vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
            vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "lein repl"
        end
    },
    {
        "Olical/aniseed",
        ft = "fnl"
    },
}
