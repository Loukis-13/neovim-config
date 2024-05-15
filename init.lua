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
        "svermeulen/vimpeccable", -- maps, commands https://github.com/svermeulen/vimpeccable
        config = function() require("keys") end
    },
    {
        'nvim-treesitter/nvim-treesitter', -- https://github.com/nvim-treesitter/nvim-treesitter
        build = ":TSUpdate"
    },
    { "nvim-tree/nvim-web-devicons" }, -- https://github.com/nvim-tree/nvim-web-devicons
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'L3MON4D3/LuaSnip' },
    {
        'hrsh7th/nvim-cmp', -- https://github.com/hrsh7th/nvim-cmp
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                })
            })
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim', -- LSP https://github.com/VonHeikemen/lsp-zero.nvim
        branch = 'v3.x',
        config = function()
            local lsp_zero = require('lsp-zero')

            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)
        end
    },
    {
        'williamboman/mason.nvim',
        dependencies = 'VonHeikemen/lsp-zero.nvim',
        config = function() require('mason').setup({}) end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = 'williamboman/mason.nvim',
        config = function()
            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                },
            })
        end,
    },
    {
        "folke/trouble.nvim", -- https://github.com/folke/trouble.nvim
        config = function() require("trouble").setup() end,
        keys = { { "<C-k>", "<cmd>TroubleToggle<CR>" } }
    },
    {
        "windwp/nvim-autopairs", -- https://github.com/windwp/nvim-autopairs
        config = function() require("nvim-autopairs").setup() end
    },
    {
        'numToStr/Comment.nvim', -- https://github.com/numToStr/Comment.nvim
        opts = {
            toggler = {
                line = '<C-/>'
            },
            opleader = {
                line = '<C-/>',
            },
        },
        lazy = false,
    },
    {
        'nvim-telescope/telescope.nvim', -- https://github.com/nvim-telescope/telescope.nvim
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
        keys = { { "F", "<cmd>Telescope live_grep<CR>" } }
    },
    {
        "julienvincent/nvim-paredit", -- https://github.com/julienvincent/nvim-paredit
        config = function() require("nvim-paredit").setup() end
    },
    {
        'Olical/conjure' -- https://github.com/Olical/conjure
    },

    -- stylization
    {
        "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function() require("bufferline").setup() end
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
        config = function() require("toggleterm").setup({ shell = "/bin/zsh" }) end,
        keys = {
            { "<C-j>", "<cmd>ToggleTerm<Enter>", mode = { "n", "i", "t" }, silent = true },
            { "<Esc>", "<C-\\><C-n>",            mode = "t",               silent = true }
        }
    },

    -- themes
    { "morhetz/gruvbox" },            -- https://github.com/morhetz/gruvbox
    { 'Mofiqul/vscode.nvim' },        -- https://github.com/Mofiqul/vscode.nvim
    { "xiyaowong/nvim-transparent" }, -- https://github.com/xiyaowong/nvim-transparent

    -- games
    {
        "seandewar/killersheep.nvim", -- :KillKillKill https://github.com/seandewar/killersheep.nvim
        config = function() require("killersheep").setup { keymaps = { move_left = "<Left>", move_right = "<Right>" } } end
    },
    { "alec-gibson/nvim-tetris" }, -- https://github.com/alec-gibson/nvim-tetris
    { "ThePrimeagen/vim-be-good" } -- https://github.com/ThePrimeagen/vim-be-good
})

require("opts")
