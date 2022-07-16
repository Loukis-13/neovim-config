local vimp = require('vimp')

vimp.nmap('<A-Right>', ':bn<Enter>')
vimp.imap('<A-Right>', '<C-o>:bn<Enter>')

vimp.nmap('<A-Left>', ':bp<Enter>')
vimp.imap('<A-Left>', '<C-o>:bp<Enter>')

vimp.vmap('<Backspace>', 'di')

vimp.nmap('<C-z>', ':u<Enter>')
vimp.imap('<C-z>', '<C-o>:u<Enter>')

vimp.nmap('<C-y>', ':red<Enter>')
vimp.imap('<C-y>', '<C-o>:red<Enter>')

vimp.nmap("<C-j>", ":terminal<Enter>i")
vimp.imap("<C-j>", "<C-o>:terminal<Enter>i")

-- Save and close
vimp.nmap("<C-s>", ":w<CR>")
vimp.imap("<C-s>", "<C-o>:w<CR>")
vimp.nmap("<C-Q>", ":wq<CR>")
vimp.imap("<C-Q>", "<Esc>:wq<CR>")
vimp.nmap("<F4>", ":if (len(getbufinfo({'buflisted':1}))>1) <bar>exe 'bd'<bar> else <bar>exe 'q'<bar> endif <Enter>")
vimp.imap("<F4>", "<Esc>:if (len(getbufinfo({'buflisted':1}))>1) <bar>exe 'bd'<bar> else <bar>exe 'q'<bar> endif <Enter>")

vimp.vmap("<C-c>", "y<Esc>i")
vimp.vmap("<C-x>", "d<Esc>i")
vimp.nmap("<C-v>", "p")
vimp.imap("<C-v>", "<C-o>p")

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

local function check_back_space()
  local col = vim.fn.col('.') - 1
  return col <= 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

vimp.inoremap({'silent', 'expr'}, '<Tab>', function ()
    if vim.fn.pumvisible() ~= 0 then
        return "<C-n>"
    elseif check_back_space() then
        return "<Tab>"
    else
        return vim.fn["coc#refresh"]()
    end
end)
vimp.inoremap({'silent', 'expr'}, '<S-Tab>', 'pumvisible() ? "<C-p>" : "<C-o>:<<Enter>"')
vimp.vmap("<Tab>", ">gv")
vimp.vmap("<S-Tab>", "<gv")

--Remap for rename current word
vimp.nmap("<F2>", "<Plug>(coc-rename)")

--Remap for format selected region
vimp.xmap("<leader>f", "<Plug>(coc-format-selected)")
vimp.nmap("<leader>f", "<Plug>(coc-format-selected)")

--Use K to show documentation in preview window
--vimp.nnoremap({"silent"}, "K", function ()
  --if index({'vim','help'}, filetype) >= 0 then
    --return "execute 'h '.expand('<cword>')"
  --else
    --return ":call CocAction('doHover')"
  --end
--end)

-- Use `[g` and `]g` to navigate diagnostics
vimp.nmap({"silent"}, "[g", "<Plug>(coc-diagnostic-prev)")
vimp.nmap({"silent"}, "]g", "<Plug>(coc-diagnostic-next)")

-- Remap keys for gotos
vimp.nmap({"silent"}, "gd", "<Plug>(coc-definition)")
vimp.nmap({"silent"}, "gy", "<Plug>(coc-type-definition)")
vimp.nmap({"silent"}, "gr", "<Plug>(coc-references)")

--Using CocList
--Show all diagnostics
vimp.nnoremap({"silent"}, "<space>a", ":<C-u>CocList diagnostics<cr>")
--Manage extensions
vimp.nnoremap({"silent"}, "<space>e", ":<C-u>CocList extensions<cr>")
--Show commands
vimp.nnoremap({"silent"}, "<space>c", ":<C-u>CocList commands<cr>")
--Find symbol of current document
vimp.nnoremap({"silent"}, "<space>o", ":<C-u>CocList outline<cr>")
--Search workspace symbols
vimp.nnoremap({"silent"}, "<space>s", ":<C-u>CocList -I symbols<cr>")
--Do default action for next item.
vimp.nnoremap({"silent"}, "<space>j", ":<C-u>CocNext<CR>")
--Do default action for previous item.
vimp.nnoremap({"silent"}, "<space>k", ":<C-u>CocPrev<CR>")
--Resume latest coc list
vimp.nnoremap({"silent"}, "<space>p", ":<C-u>CocListResume<CR>i")

--Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vimp.xmap({"silent", "nowait"}, "<M-Enter>", "<Plug>(coc-codeaction-selected)")
vimp.nmap({"silent", "nowait"}, "<M-Enter>", "<Plug>(coc-codeaction-selected)w")

--Remap for do codeAction of current line
vimp.nmap("<leader>ac", "<Plug>(coc-codeaction)")
--Fix autofix problem of current line
vimp.nmap("<leader>qf", "<Plug>(coc-fix-current)")

--Create mappings for function text object, requires document symbols feature of languageserver.
vimp.xmap("if", "<Plug>(coc-funcobj-i)")
vimp.xmap("af", "<Plug>(coc-funcobj-a)")
vimp.omap("if", "<Plug>(coc-funcobj-i)")
vimp.omap("af", "<Plug>(coc-funcobj-a)")

--Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
vimp.nmap({"silent"}, "<C-d>", "<Plug>(coc-range-select)")
vimp.xmap({"silent"}, "<C-d>", "<Plug>(coc-range-select)")

--Use <c-space> to trigger completion.
vimp.inoremap({"silent", "expr"}, "<c-space>", "coc#refresh()")

--Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
--Coc only does snippet and additional edit on confirm.
vimp.inoremap({"expr"}, "<cr>", 'pumvisible() ? "<C-y>" : "<C-g>u<CR>"')
--Or use `complete_info` if your vim support it, like:
--inoremap <expr> <cr> complete_nfo()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"


-- Use `:Format` to format current buffer
vimp.map_command("Format", function() return vim.fn.CocAction('format') end)

-- Use `:Fold` to fold current buffer
vimp.map_command("Fold", function(...) return vim.fn.CocAction('fold', ...) end)

-- use `:OR` for organize import of current buffer
vimp.map_command("OR", function() return vim.fn.CocAction('runCommand', 'editor.action.organizeImport') end)

-- prettier command for coc
vimp.map_command("Prettier", function() vim.cmd":CocCommand prettier.formatFile" end)

-- Arguments: mode (optional)
vimp.map_command("ShowAllMaps", function(...)
  -- Use empty string as prefix to select all
  vimp.show_maps('', ...)
end)

-- Arguments: prefix (required), mode (optional)
vimp.map_command("ShowMaps", function(...)
  vimp.show_maps(...)
end)

