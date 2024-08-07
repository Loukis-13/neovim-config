local vimp = require('vimp')

-- goto definition
-- <C-w> }

-- Buffers navigation
vimp.nnoremap('>', ':bn<Enter>')
vimp.nnoremap('<', ':bp<Enter>')

-- move line
vimp.nmap('<A-Up>', ':m-2<Enter>')
vimp.imap('<A-Up>', '<Esc>:m-2<Enter>i')
vimp.nmap('<A-Down>', ':m+1<Enter>')
vimp.imap('<A-Down>', '<Esc>:m+1<Enter>i')

-- Delete
vimp.vmap('<Backspace>', 'di')

-- Undo and redo
vimp.nmap('<C-z>', ':u<Enter>') -- u
vimp.imap('<C-z>', '<C-o>:u<Enter>')
vimp.nmap('<C-y>', ':red<Enter>') -- <C-r>
vimp.imap('<C-y>', '<C-o>:red<Enter>')

-- Save and close
vimp.nmap("<C-s>", ":w<CR>")
vimp.imap("<C-s>", "<C-o>:w<CR>")
-- vimp.nmap("<C-q>", ":wq<CR>")
-- vimp.imap("<C-q>", "<Esc>:wq<CR>")
vimp.nmap("qq", ":if (len(getbufinfo({'buflisted':1}))>1) <bar>exe 'bd'<bar> else <bar>exe 'q'<bar> endif <Enter>")
vimp.imap("qq", "<Esc>:if (len(getbufinfo({'buflisted':1}))>1) <bar>exe 'bd'<bar> else <bar>exe 'q'<bar> endif <Enter>")

-- Copy, cut and paste
vimp.vmap("<C-c>", "y<Esc>i")
vimp.vmap("<C-x>", "d<Esc>i")
vimp.nmap("<C-v>", "p")
vimp.imap("<C-v>", "<Esc>pi<Right>")

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
vimp.nnoremap("<C-.>", ":lua vim.lsp.buf.code_action()<CR>")

-- Format
vimp.nmap("<C-f>", ":lua vim.lsp.buf.format()<CR>")

-- Move with Meta key
vimp.map("<M-Right>", "e")
vimp.map("<M-Left>", "b")

