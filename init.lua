local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

require("opts")         -- OptiBons
require("vars")         -- Variables
require("keys")         -- Keymaps

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim" -- Package manager

    use {"neoclide/coc.nvim", branch = "release"} -- https://github.com/neoclide/coc.nvim
    use "mattn/emmet-vim" -- Snippets https://github.com/mattn/emmet-vim
    use "kyazdani42/nvim-web-devicons" -- https://github.com/kyazdani42/nvim-web-devicons
    use "kyazdani42/nvim-tree.lua" -- https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
    use "sheerun/vim-polyglot" -- Syntax highlight https://github.com/sheerun/vim-polyglot
    use "Yggdroot/indentLine" -- Tab lines https://github.com/Yggdroot/indentLine
    use "svermeulen/vimpeccable"  -- maps, commands https://github.com/svermeulen/vimpeccable
    use "nvim-lualine/lualine.nvim" -- https://github.com/nvim-lualine/lualine.nvim
    use {"akinsho/bufferline.nvim", tag = "v2.*"} -- https://github.com/akinsho/bufferline.nvim
    use "b3nj5m1n/kommentary" -- https://github.com/b3nj5m1n/kommentary
    -- use "folke/lsp-colors.nvim" -- https://github.com/folke/lsp-colors.nvim
    use "xiyaowong/nvim-transparent" -- https://github.com/xiyaowong/nvim-transparent
    -- use 'koenverburg/peepsight.nvim' -- https://github.com/koenverburg/peepsight.nvim

    -- themes
    use "rafi/awesome-vim-colorschemes" -- https://github.com/rafi/awesome-vim-colorschemes
    use "morhetz/gruvbox" -- https://github.com/morhetz/gruvbox
    use 'Mofiqul/vscode.nvim' -- https://github.com/Mofiqul/vscode.nvim

    -- games
    use "seandewar/killersheep.nvim" -- :KillKillKill https://github.com/seandewar/killersheep.nvim
    use "alec-gibson/nvim-tetris" -- https://github.com/alec-gibson/nvim-tetris
    use "ThePrimeagen/vim-be-good" -- https://github.com/ThePrimeagen/vim-be-good

    -- Automatically vim.opt.up your coBnfiguration after cloning packer.nvim
    -- Put this at the end after all plugins
    if Packer_bootstrap then require("packer").sync() end

    require("nvim-tree").setup{ open_on_setup = true, filters = { dotfiles = true } }
    require("killersheep").setup{ keymaps = { move_left = "<Left>", move_right = "<Right>" }}
    require("kommentary.config").configure_language("default", { prefer_single_line_comments = true })
    require("bufferline").setup{}
    require("lualine").setup {
      options = {
        theme = "codedark",
        component_separators = { left = "|", right = "|"},
        section_separators = { left = "", right = ""},
        globalstatus = true,
      }
    }

    --use "neovim/nvim-lspconfig" -- Configurations for Nvim LSP
    --require"lspconfig".pyright.setup{}
end)

