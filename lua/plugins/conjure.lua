return {
    {
        "Olical/conjure", -- https://github.com/Olical/conjure
        init = function()
            vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { "deftest", "defflow", "defspec" }
            vim.g["conjure#mapping#doc_word"] = false -- Disable the documentation mapping
            -- vim.g["conjure#log#fold#enabled"] = true
        end
    },
    {
        "Olical/aniseed",
        ft = "fnl"
    },
}
