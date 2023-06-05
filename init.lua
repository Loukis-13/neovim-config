local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
        install_path })
end

require("packer").startup(function(use)
    use "wbthomason/packer.nvim"       -- Package manager
    use "kyazdani42/nvim-web-devicons" -- https://github.com/kyazdani42/nvim-web-devicons
    use {
        'VonHeikemen/lsp-zero.nvim',   -- LSP https://github.com/VonHeikemen/lsp-zero.nvim
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            local lsp = require('lsp-zero')
            lsp.preset('recommended')

            -- local rust_lsp = lsp.build_options('rust_analyzer', {})

            lsp.setup()

            -- require('rust-tools').setup({server = rust_lsp})

            require("vars")
        end
    }
    use {
        "jose-elias-alvarez/null-ls.nvim", -- https://github.com/jose-elias-alvarez/null-ls.nvim
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup {
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.completion.spell,
                },
            }
        end
    }
    use {
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
    }
    use {
        "kyazdani42/nvim-tree.lua", -- https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
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
        end
    }
    use {
        "folke/trouble.nvim", -- https://github.com/folke/trouble.nvim
        config = function() require("trouble").setup() end
    }
    use {
        "windwp/nvim-autopairs", -- https://github.com/windwp/nvim-autopairs
        config = function() require("nvim-autopairs").setup() end
    }
    use {
        "akinsho/toggleterm.nvim", -- https://github.com/akinsho/toggleterm.nvim
        config = function() require("toggleterm").setup() end
    }
    use {
        "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
        tag = "v3.*",
        config = function() require("bufferline").setup() end
    }
    use {
        "b3nj5m1n/kommentary", -- https://github.com/b3nj5m1n/kommentary
        config = function()
            require("kommentary.config").configure_language("default",
                { prefer_single_line_comments = true })
        end
    }
    use {
        "svermeulen/vimpeccable", -- maps, commands https://github.com/svermeulen/vimpeccable
        config = function() require("keys") end
    }
    use {
        'simrat39/rust-tools.nvim', -- https://github.com/simrat39/rust-tools.nvim
        config = function()
            require("rust-tools").setup {
                tools = {
                    runnables = {
                        use_telescope = true,
                    },
                    inlay_hints = {
                        auto = true,
                        show_parameter_hints = false,
                        highlight = "Identifier",
                    },
                },
                server = {
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                command = "clippy",
                            },
                        },
                    },
                },
            }
        end
    }

    use "lukas-reineke/indent-blankline.nvim" -- Tab lines https://github.com/lukas-reineke/indent-blankline.nvim
    use "xiyaowong/nvim-transparent"          -- https://github.com/xiyaowong/nvim-transparent

    -- themes
    use "rafi/awesome-vim-colorschemes" -- https://github.com/rafi/awesome-vim-colorschemes
    use "morhetz/gruvbox"               -- https://github.com/morhetz/gruvbox
    use 'Mofiqul/vscode.nvim'           -- https://github.com/Mofiqul/vscode.nvim

    -- games
    use {
        "seandewar/killersheep.nvim", -- :KillKillKill https://github.com/seandewar/killersheep.nvim
        config = function() require("killersheep").setup { keymaps = { move_left = "<Left>", move_right = "<Right>" } } end
    }
    use "alec-gibson/nvim-tetris"  -- https://github.com/alec-gibson/nvim-tetris
    use "ThePrimeagen/vim-be-good" -- https://github.com/ThePrimeagen/vim-be-good

    -- Automatically vim.opt.up your coBnfiguration after cloning packer.nvim
    -- Put this at the end after all plugins
    if Packer_bootstrap then require("packer").sync() end

    require("opts")
end)
