return {
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
        "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
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
        keys = {
            { "<C-b>", "<Cmd>Neotree toggle<Enter>", mode = { "n", "i", "v" }, silent = true },
        }
    },
    {
        "akinsho/toggleterm.nvim", -- https://github.com/akinsho/toggleterm.nvim
        event = "VeryLazy",
        opts = { shell = "/bin/zsh", open_mapping = "<C-j>" },
        keys = { { "<Esc>", "<C-\\><C-n>", mode = "t", silent = true } }
    },

    -- themes
    { "Mofiqul/vscode.nvim",             lazy = true },                                  -- https://github.com/Mofiqul/vscode.nvim
    { "sputnick1124/uiua.vim",           ft = { "uiua" } },                              -- https://github.com/sputnick1124/uiua.vim
    { "HiPhish/rainbow-delimiters.nvim", main = "rainbow-delimiters.setup", opts = {} }, -- https://github.com/HiPhish/rainbow-delimiters.nvim
}
