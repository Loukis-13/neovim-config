-- vim.g.mapleader = ","
-- vim.g.maplocalleader = ","
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.hidden = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.encoding = "UTF-8"
vim.opt.history = 5000
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 2
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.cindent = true
vim.opt.linebreak = true
vim.opt.termguicolors = true
vim.opt.shell = "/bin/zsh"
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.completeopt:append("noselect")
vim.cmd("colorscheme vscode")

vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
        },
    },
    virtual_text = {
        prefix = " ",
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        source = "always",
    },
}

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function(data)
        if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
        elseif vim.fn.expand("%:p") ~= "" then
            vim.cmd.cd(vim.fn.expand("%:p:h"))
        end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = ((require("nvim-treesitter") and require("nvim-treesitter").get_installed()) or {}),
    callback = function()
        vim.treesitter.start()
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.cmd("silent! %foldopen!")
    end,
})
