vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt:append("noselect")
vim.opt.cpoptions:append("I")
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.encoding = "UTF-8"
vim.opt.expandtab = true
vim.opt.foldlevel = 5
vim.opt.hidden = true
vim.opt.history = 5000
vim.opt.laststatus = 2
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.shell = "/bin/zsh"
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
-- vim.opt.spell = true
vim.opt.spelllang = 'en,pt'
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.updatetime = 300
-- vim.opt.virtualedit = "all"
vim.opt.winborder = 'rounded'
vim.opt.wrap = false
vim.cmd.colorscheme("vscode")

vim.diagnostic.config({
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
})

vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#303030" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#303030" })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function(_)
        for _, v in ipairs(vim.list_slice(vim.v.argv, 2)) do
            if vim.fn.isdirectory(v) == 1 then
                vim.cmd.cd(v)
                break
            elseif vim.fn.file_readable(v) == 1 then
                vim.cmd.cd(vim.fn.fnamemodify(v, ":p:h"))
                break
            end
        end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = vim.iter(vim.api.nvim_get_runtime_file('parser/*', true))
        :map(function(p) return vim.fn.fnamemodify(p, ':t:r') end)
        :unique()
        :totable(),
    callback = function()
        vim.treesitter.start()
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
})
