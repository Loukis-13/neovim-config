local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- vim.g["conjure#log#wrap"] = true
vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { "deftest", "defflow" }

-- https://github.com/folke/lazy.nvim
require("lazy").setup({
    {
        "svermeulen/vimpeccable", -- maps, commands https://github.com/svermeulen/vimpeccable
        config = function() require("keys") end
    },
    {
        'nvim-treesitter/nvim-treesitter', -- https://github.com/nvim-treesitter/nvim-treesitter
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                highlight = { enable = true },
                ensure_installed = { "vimdoc", "luadoc", "vim", "lua", "markdown" }
            }
        end
    },
    { "nvim-tree/nvim-web-devicons" }, -- https://github.com/nvim-tree/nvim-web-devicons
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {},
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
        'neovim/nvim-lspconfig', -- https://github.com/neovim/nvim-lspconfig
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        init = function()
            -- Reserve a space in the gutter
            -- This will avoid an annoying layout shift in the screen
            vim.opt.signcolumn = 'yes'
        end,
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
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end,
            })

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                }
            })

            require('lspconfig').uiua.setup({})
        end
    },
    {
        "folke/trouble.nvim", -- https://github.com/folke/trouble.nvim
        config = function() require("trouble").setup() end,
        keys = { { "<C-k>", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" } }
    },
    {
        "windwp/nvim-autopairs", -- https://github.com/windwp/nvim-autopairs
        config = function()
            require("nvim-autopairs").setup({
                ignored_next_char = ""
            })
        end
    },
    {
        'numToStr/Comment.nvim', -- https://github.com/numToStr/Comment.nvim
        opts = {
            toggler = {
                line = '<C-_>'
            },
            opleader = {
                line = '<C-_>',
            },
        },
        lazy = false,
    },
    {
        'nvim-telescope/telescope.nvim', -- https://github.com/nvim-telescope/telescope.nvim
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
        keys = {
            { "F", "<cmd>Telescope live_grep<CR>" },
            { "G", "<cmd>Telescope git_status<CR>" }
        }
    },
    {
        "julienvincent/nvim-paredit", -- https://github.com/julienvincent/nvim-paredit
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
                    ["<M-Right>"] = {
                        paredit.api.move_to_next_element_tail,
                        "Jump to next element tail",
                        repeatable = false,
                        mode = { "n", "i", "x", "o", "v" },
                    },
                    ["<M-Left>"] = {
                        paredit.api.move_to_prev_element_head,
                        "Jump to previous element head",
                        repeatable = false,
                        mode = { "n", "i", "x", "o", "v" },
                    },
                    ["<M-Up>"] = {
                        paredit.api.drag_element_backwards,
                        "Slurp forwards",
                        mode = { "n", "x", "o", "v" },
                    },
                    ["<M-Down>"] = {
                        paredit.api.drag_element_forwards,
                        "Barf backwards",
                        mode = { "n", "x", "o", "v" },
                    },

                    [">("] = false,
                    [">)"] = false,
                    [">e"] = false,
                    [">f"] = false,
                    ["<("] = false,
                    ["<)"] = false,
                    ["<e"] = false,
                    ["<f"] = false,
                }
            })
        end
    },
    {
        'Olical/conjure' -- https://github.com/Olical/conjure
    },

    -- stylization
    {
        "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local s = " "
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " " or (e == "warning" and " " or " ")
                            s = s .. n .. sym
                        end
                        return s
                    end
                }
            })
        end
    },
    {
        "lewis6991/gitsigns.nvim", -- https://github.com/lewis6991/gitsigns.nvim
        config = function() require('gitsigns').setup() end
    },
    {
        "nvim-lualine/lualine.nvim", -- https://github.com/nvim-lualine/lualine.nvim
        config = function()
            require("lualine").setup {
                options = {
                    theme = "codedark",
                    component_separators = { left = "|", right = "|" },
                    section_separators = { left = "", right = "" },
                    globalstatus = true,
                }
            }
        end
    },
    {
        "nvim-tree/nvim-tree.lua", -- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
        lazy = false,
        config = function()
            require("nvim-tree").setup { filters = { dotfiles = true } }

            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                callback = function(data)
                    -- buffer is a [No Name]
                    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

                    -- buffer is a directory
                    local directory = vim.fn.isdirectory(data.file) == 1

                    if not no_name and not directory then
                        return
                    end

                    -- change to the directory
                    if directory then
                        vim.cmd.cd(data.file)
                    end
                    -- open the tree
                    require("nvim-tree.api").tree.open()
                end
            })
        end,
        keys = {
            { "<C-b>", "<cmd>NvimTreeToggle<Enter>", mode = { "n", "i", "v" }, silent = true },
        }
    },
    {
        "akinsho/toggleterm.nvim", -- https://github.com/akinsho/toggleterm.nvim
        lazy = false,
        config = function()
            require("toggleterm").setup({
                shell = "/bin/zsh",
                open_mapping = "<C-j>",
            })
        end,
        keys = {
            { "<Esc>", "<C-\\><C-n>", mode = "t", silent = true }
        }
    },

    -- themes
    { 'Mofiqul/vscode.nvim',        lazy = true, }, -- https://github.com/Mofiqul/vscode.nvim
    { "xiyaowong/nvim-transparent", lazy = true, }, -- https://github.com/xiyaowong/nvim-transparent
    -- "Apeiros-46B/uiua.vim",  -- https://github.com/Apeiros-46B/uiua.vim
    { "sputnick1124/uiua.vim" },                    -- https://github.com/sputnick1124/uiua.vim

    -- games
    {
        "seandewar/killersheep.nvim", -- :KillKillKill https://github.com/seandewar/killersheep.nvim
        config = function() require("killersheep").setup { keymaps = { move_left = "<Left>", move_right = "<Right>" } } end,
        lazy = true,
    },
    {
        "alec-gibson/nvim-tetris", -- https://github.com/alec-gibson/nvim-tetris
        lazy = true,
    },
})

require("opts")

