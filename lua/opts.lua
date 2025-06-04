vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.hidden = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.encoding = 'UTF-8'
vim.opt.history = 5000
vim.opt.clipboard = 'unnamedplus'
vim.opt.laststatus = 2
vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'
vim.opt.cindent = true
vim.opt.linebreak = true
vim.opt.termguicolors = true
vim.opt.shell = "/bin/zsh"
vim.opt.splitright = true
-- vim.opt.winborder = 'rounded'
vim.opt.wrap = false
vim.opt.completeopt:append("noselect")
vim.cmd("colorscheme vscode")

vim.diagnostic.config {
    virtual_text = {
        prefix = ' ',
    },
    -- virtual_lines = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        source = "always",
    },
}
