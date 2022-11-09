local vimp = require('vimp')

-- Buffers navigation
vimp.nmap('<A-Right>', ':bn<Enter>')
vimp.imap('<A-Right>', '<C-o>:bn<Enter>')
vimp.nmap('<A-Left>', ':bp<Enter>')
vimp.imap('<A-Left>', '<C-o>:bp<Enter>')
vimp.nmap('<A-Up>', '<C-w><Up>')
vimp.imap('<A-Up>', '<Ecs><C-w><Up>i')
vimp.nmap('<A-Down>', '<C-w><Down>')
vimp.imap('<A-Down>', '<Ecs><C-w><Down>i')

-- Delete
vimp.vmap('<Backspace>', 'di')

-- Undo and redo
vimp.nmap('<C-z>', ':u<Enter>')
vimp.imap('<C-z>', '<C-o>:u<Enter>')
vimp.nmap('<C-y>', ':red<Enter>')
vimp.imap('<C-y>', '<C-o>:red<Enter>')

-- Terminal
vimp.nmap("<C-j>", ":ToggleTerm<Enter>")
vimp.imap("<C-j>", "<C-o>:ToggleTerm<Enter>i")
vimp.tnoremap("<Esc>", "<C-\\><C-n>")
vimp.tnoremap("<C-j>", "<C-\\><C-n>:ToggleTerm<Enter>")

-- Save and close
vimp.nmap("<C-s>", ":w<CR>")
vimp.imap("<C-s>", "<C-o>:w<CR>")
vimp.nmap("<C-q>", ":wq<CR>")
vimp.imap("<C-q>", "<Esc>:wq<CR>")
vimp.nmap("qq", ":if (len(getbufinfo({'buflisted':1}))>1) <bar>exe 'bd'<bar> else <bar>exe 'q'<bar> endif <Enter>")
vimp.imap("qq", "<Esc>:if (len(getbufinfo({'buflisted':1}))>1) <bar>exe 'bd'<bar> else <bar>exe 'q'<bar> endif <Enter>")

-- Copy, cut and paste
vimp.vmap("<C-c>", "y<Esc>i")
vimp.vmap("<C-x>", "d<Esc>i")
vimp.nmap("<C-v>", "p")
vimp.imap("<C-v>", "<Esc>pi<Right>")

-- Control tree
vimp.nmap({'silent'}, "<C-b>", ":NvimTreeToggle<Enter>")
vimp.vmap({'silent'}, "<C-b>", ":NvimTreeToggle<Enter>")
vimp.imap({'silent'}, "<C-b>", "<Esc>:NvimTreeToggle<Enter>")
vimp.nmap({'silent'}, "<S-b>", ":NvimTreeFocus<Enter>")

-- Comment
vimp.nmap({'silent'}, "<C-_>", "<Plug>kommentary_line_default")
vimp.imap({'silent'}, "<C-_>", "<C-o><Plug>kommentary_line_default")
vimp.xmap({'silent'}, "<C-_>", "<Plug>kommentary_visual_default<C-c>")

-- Lines selection
vimp.nmap("<S-Up>",    "v<Up>")
vimp.nmap("<S-Down>",  "v<Down>")
vimp.nmap("<S-Left>",  "v<Left>")
vimp.nmap("<S-Right>", "v<Right>")
vimp.vmap("<S-Up>",    "<Up>")
vimp.vmap("<S-Down>",  "<Down>")
vimp.vmap("<S-Left>",  "<Left>")
vimp.vmap("<S-Right>", "<Right>")
vimp.imap("<S-Up>",    "<Esc>v<Up>")
vimp.imap("<S-Down>",  "<Esc>v<Down>")
vimp.imap("<S-Left>",  "<Esc>v<Left>")
vimp.imap("<S-Right>", "<Esc>v<Right>")
vimp.nmap("<S-Home>",  "v<Home>")
vimp.nmap("<S-End>",   "v<End>")
vimp.imap("<S-Home>",  "<Esc>v<Home>")
vimp.imap("<S-End>",   "<Esc>v<End>")

-- Adjust indentation
vimp.vmap("<Tab>", ">gv")
vimp.vmap("<S-Tab>", "<gv")

-- QuickFix
vimp.nnoremap("<M-CR>", ":lua vim.lsp.buf.code_action()<CR>")

-- Format
vimp.nmap("<C-f>", ":lua vim.lsp.buf.format()<CR>")


-- Arguments: mode (optional)
vimp.map_command("ShowAllMaps", function(...)
  -- Use empty string as prefix to select all
  vimp.show_maps('', ...)
end)

-- Arguments: prefix (required), mode (optional)
vimp.map_command("ShowMaps", function(...)
  vimp.show_maps(...)
end)

