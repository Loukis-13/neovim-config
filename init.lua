vim.pack.add({ "https://github.com/folke/lazy.nvim" })

vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("lazy").setup({
    { import = "plugins" },
})

require("configs.opts")
require("configs.mappings")
