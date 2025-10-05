-- Buffers navigation
vim.keymap.set("n", ">", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<", ":bp<CR>", { silent = true })

-- Comment
vim.keymap.set({ "n", "v", "i" }, "<C-/>", "<Cmd>normal gcc<CR>", { noremap = false })

-- Move line
vim.keymap.set({ "n", "i" }, "<A-Up>", "<Cmd>m-2<CR>")
vim.keymap.set({ "n", "i" }, "<A-Down>", "<Cmd>m+1<CR>")

-- Delete selection
vim.keymap.set("v", "<BS>", "di")

-- Save
vim.keymap.set({ "i", "n" }, "<C-s>", "<Cmd>w<CR>")

-- Close buffer or quit
vim.keymap.set("n", "qq", function() vim.cmd(#vim.fn.getbufinfo({ buflisted = 1 }) > 1 and "bd" or "q") end)

-- Copy, cut and paste
vim.keymap.set("v", "<C-c>", "y<Esc>")
vim.keymap.set("v", "<C-x>", "d<Esc>")
vim.keymap.set("n", "<C-v>", "p<Right>")
vim.keymap.set("i", "<C-v>", "<Esc>pi<Right>")

-- Signature help
vim.keymap.set('n', 'grs', '<Plug>(nvim.lsp.ctrl-s)')

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

-- Open Lazy
vim.keymap.set("n", "L", "<Cmd>Lazy<Cr>")

-- Command keymaps
if vim.fn.has("mac") then
    -- Command
    vim.keymap.set({ "n", "v", "i" }, "<D-/>", "<Cmd>normal gcc<CR>", { noremap = false })

    -- Save
    vim.keymap.set({ "i", "n" }, "<D-s>", "<Cmd>w<CR>")

    -- Move
    vim.keymap.set({ "n", "v", "i" }, "<D-Right>", "<End>")
    vim.keymap.set({ "n", "v", "i" }, "<D-Left>", "<Home>")
    vim.keymap.set({ "n", "v", "i" }, "<D-Up>", "<PageUp>")
    vim.keymap.set({ "n", "v", "i" }, "<D-Down>", "<PageDown>")

    -- Copy, cut and paste
    vim.keymap.set("v", "<D-c>", "y<Esc>")
    vim.keymap.set("v", "<D-x>", "d<Esc>")
    vim.keymap.set("n", "<D-v>", "p<Right>")
    vim.keymap.set("i", "<D-v>", "<Esc>pi<Right>")
end
