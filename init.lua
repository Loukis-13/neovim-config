local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- https://github.com/folke/lazy.nvim
require("lazy").setup({
    {
        "echasnovski/mini.icons", -- https://github.com/echasnovski/mini.icons
        lazy = true,
        opts = {},
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter', -- https://github.com/nvim-treesitter/nvim-treesitter
        build = ":TSUpdate",
        lazy = false,
        -- branch = 'master',
        branch = 'main',
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp', -- https://github.com/hrsh7th/nvim-cmp
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },

    -- LSP
    {
        "mason-org/mason-lspconfig.nvim", -- https://github.com/mason-org/mason-lspconfig.nvim
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        'neovim/nvim-lspconfig', -- https://github.com/neovim/nvim-lspconfig
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'hrsh7th/cmp-nvim-lsp' },
        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end,
                        { buffer = event.buf, desc = "Open documentation" })
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })
                    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })

                    -- local client = vim.lsp.get_client_by_id(event.data.client_id)
                    -- if client:supports_method('textDocument/completion') then
                    --     vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
                    -- end
                end,
            })
        end
    },
    {
        "folke/trouble.nvim", -- https://github.com/folke/trouble.nvim
        opts = {},
        keys = { { "<C-k>", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" } }
    },
    {
        "windwp/nvim-autopairs", -- https://github.com/windwp/nvim-autopairs
        event = "InsertEnter",
        opts = {},
    },
    {
        "julienvincent/nvim-paredit", -- https://github.com/julienvincent/nvim-paredit
        -- "folliehiyuki/nvim-paredit", branch = "nvim-treesitter-main",
        config = function()
            local paredit = require("nvim-paredit")

            paredit.setup({
                use_default_keys = false,
                keys = {
                    ["<localleader>@"] = { paredit.unwrap.unwrap_form_under_cursor, "Splice sexp" },
                    ["<localleader>o"] = { paredit.unwrap.unwrap_form_under_cursor, "Splice sexp" },
                    ["<C-M-P><C-M-R>"] = {
                        paredit.unwrap.unwrap_form_under_cursor,
                        "Splice sexp",
                        mode = { "n", "x", "o", "v" },
                    },
                    ["<A-Right>"] = {
                        paredit.api.move_to_next_element_tail,
                        "Jump to next element tail",
                        repeatable = false,
                        mode = { "n", "i", "x", "o", "v" },
                    },
                    ["<A-Left>"] = {
                        paredit.api.move_to_prev_element_head,
                        "Jump to previous element head",
                        repeatable = false,
                        mode = { "n", "i", "x", "o", "v" },
                    },
                    ["<A-Up>"] = {
                        paredit.api.drag_element_backwards,
                        "Slurp forwards",
                        mode = { "n", "x", "o", "v" },
                    },
                    ["<A-Down>"] = {
                        paredit.api.drag_element_forwards,
                        "Barf backwards",
                        mode = { "n", "x", "o", "v" },
                    },
                }
            })
        end
    },
    {
        'Olical/conjure', -- https://github.com/Olical/conjure
        init = function()
            vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { "deftest", "defflow", "defspec" }
        end
    },
    -- {
    --     'liquidz/elin', -- https://liquidz.github.io/elin/
    --     init = function()
    --         vim.g.elin_enable_default_key_mappings = true
    --     end
    -- },

    {
        "folke/which-key.nvim", -- https://github.com/folke/which-key.nvim
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function() require("which-key").show({ global = false }) end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "folke/snacks.nvim", -- https://github.com/folke/snacks.nvim
        event = "VeryLazy",
        opts = {
            words = {},
            gitbrowse = {},
            lazygit = {},
            picker = {
                -- sources = {
                --     explorer = {
                --         win = {
                --             list = {
                --                 keys = {
                --                     ["<c-b>"] = { "cancel", mode = { "i", "n" } },
                --                     ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                --                     ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                --                 }
                --             }
                --         }
                --     }
                -- }
            },
            -- explorer = {},
            bigfile = {},
            image = {},
            quickfile = {},
        },
        keys = {
            { "]]",         "<Cmd>lua Snacks.words.jump(1, true)<CR>",  desc = "Next reference" },
            { "[[",         "<Cmd>lua Snacks.words.jump(-1, true)<CR>", desc = "Previous reference" },
            { "<leader>gB", "<Cmd>lua Snacks.gitbrowse()<CR>",          desc = "Git Browse",        mode = { "n", "v" } },
            { "<leader>gg", "<Cmd>lua Snacks.lazygit()<CR>",            desc = "Lazygit" },
            { "F",          "<Cmd>lua Snacks.picker.grep()<CR>",        desc = "Grep search" },
            { "G",          "<Cmd>lua Snacks.lazygit()<CR>",            desc = "Lazy Git" },
            -- { "<C-b>",      "<Cmd>lua Snacks.explorer()<CR>",           desc = "File explorer" },
        }
    },

    -- stylization
    {
        "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diagnostics_dict, _)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " " or (e == "warning" and " " or " ")
                        s = s .. n .. sym
                    end
                    return s
                end
            }
        },
    },
    {
        "lewis6991/gitsigns.nvim", -- https://github.com/lewis6991/gitsigns.nvim
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim", -- https://github.com/nvim-lualine/lualine.nvim
        event = "VeryLazy",
        opts = {
            options = {
                theme = "codedark",
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
            }
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim", -- https://github.com/nvim-neo-tree/neo-tree.nvim
        lazy = false,
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            source_selector = {
                winbar = true,
            },
            window = {
                width = 35,
                mappings = {
                    ["<C-f>"] = "none",
                    ["<C-b>"] = "none",
                    ["<C-d>"] = { "scroll_preview", config = { direction = -10 } },
                    ["<C-u>"] = { "scroll_preview", config = { direction = 10 } },
                }
            }
        },
        init = function()
            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                callback = function(data)
                    if vim.fn.isdirectory(data.file) == 1 then
                        vim.cmd.cd(data.file)
                    end
                end
            })
        end,
        keys = {
            { "<C-b>", "<Cmd>Neotree toggle<Enter>", mode = { "n", "i", "v" }, silent = true },
        }
    },
    {
        "akinsho/toggleterm.nvim", -- https://github.com/akinsho/toggleterm.nvim
        event = "VeryLazy",
        opts = { shell = "/bin/zsh", open_mapping = "<C-j>", },
        keys = { { "<Esc>", "<C-\\><C-n>", mode = "t", silent = true } }
    },

    -- themes
    { 'Mofiqul/vscode.nvim',             lazy = true },                                  -- https://github.com/Mofiqul/vscode.nvim
    { "xiyaowong/nvim-transparent",      lazy = true },                                  -- https://github.com/xiyaowong/nvim-transparent
    { "sputnick1124/uiua.vim",           ft = { 'uiua' } },                              -- https://github.com/sputnick1124/uiua.vim
    -- { "Apeiros-46B/uiua.vim",            ft = { 'uiua' } },           -- https://github.com/Apeiros-46B/uiua.vim
    { 'HiPhish/rainbow-delimiters.nvim', main = "rainbow-delimiters.setup", opts = {} }, -- https://github.com/HiPhish/rainbow-delimiters.nvim

    -- games
    {
        "seandewar/killersheep.nvim", -- :KillKillKill https://github.com/seandewar/killersheep.nvim
        cmd = "KillKillKill",
        opts = { keymaps = { move_left = "<Left>", move_right = "<Right>" } },
    },
    { "alec-gibson/nvim-tetris", cmd = "Tetris" }, -- https://github.com/alec-gibson/nvim-tetris
})


-- OPTIONS
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
vim.opt.wrap = false
vim.opt.completeopt:append("noselect")
vim.cmd("colorscheme vscode")

vim.filetype.add({ pattern = { [".*.json.base"] = "json" } })

vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
        },
    },
    virtual_text = {
        prefix = ' ',
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
        end
    end
})


-- MAPPINGS
-- Buffers navigation
vim.keymap.set("n", ">", ":bn<CR>")
vim.keymap.set("n", "<", ":bp<CR>")

-- Comment
vim.keymap.set({ "n", "v", "i" }, "<C-/>", "<Cmd>normal gcc<CR>", { noremap = false })

-- Move line
vim.keymap.set({ "n", "i" }, "<A-Up>", "<Cmd>m-2<CR>")
vim.keymap.set({ "n", "i" }, "<A-Down>", "<Cmd>m+1<CR>")

-- Delete selection
vim.keymap.set("v", "<BS>", "di")

-- Save and close
vim.keymap.set({ "i", "n" }, "<C-s>", "<Cmd>w<CR>")

-- Close buffer or quit
vim.keymap.set("n", "qq", function() vim.cmd(#vim.fn.getbufinfo({ buflisted = 1 }) > 1 and "bd" or "q") end)

-- Copy, cut and paste
vim.keymap.set("v", "<C-c>", "y<Esc>i")
vim.keymap.set("v", "<C-x>", "d<Esc>i")
vim.keymap.set("n", "<C-v>", "p<Right>")
vim.keymap.set("i", "<C-v>", "<Esc>pi<Right>")

-- Lines selection
vim.keymap.set({ "n", "v", "i" }, "<S-Home>", "<Esc>v<Home>")
vim.keymap.set({ "n", "v", "i" }, "<S-End>", "<Esc>v<End>")
for _, key in ipairs({ "Up", "Down", "Left", "Right" }) do
    vim.keymap.set(
        { "n", "v", "i" },
        "<S-" .. key .. ">",
        function() return (vim.fn.mode() == "v" and "" or "<Esc>v") .. "<" .. key .. ">" end,
        { expr = true }
    )
end

-- Adjust indentation
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Add indentation" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Remove indentation" })

-- QuickFix / Code action
vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "QuickFix / Code action" })

-- Format
vim.keymap.set({ "n", "v", "i" }, "<C-f>", vim.lsp.buf.format, { desc = "Format" })

-- Move with Meta key
vim.keymap.set({ "n", "v", "i" }, "<A-Right>", "e", { noremap = true })
vim.keymap.set({ "n", "v", "i" }, "<A-Left>", "b", { noremap = true })
