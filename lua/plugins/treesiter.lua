return {
    {
        "nvim-treesitter/nvim-treesitter", -- https://github.com/nvim-treesitter/nvim-treesitter
        build = ":TSUpdate",
        lazy = false,
        branch = "main",
        opts = {
            ensure_installed = { "regex", "markdown", "html" }
        }
    },
}
