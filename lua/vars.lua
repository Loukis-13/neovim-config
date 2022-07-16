vim.g.coc_global_extensions = {
	'coc-snippets',
	'coc-pairs',
	'coc-tsserver',
	'coc-eslint',
	'coc-prettier',
	'coc-json',
	'coc-python',
	'coc-rust-analyzer',
    'coc-lua'
}

vim.g.kommentary_create_default_mappings = false

-- Undercurls on errors and warnings
vim.api.nvim_set_hl(0, 'CocErrorHighlight', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = '#fb4934' })
vim.api.nvim_set_hl(0, 'CocWarningHighlight', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = '#fe8019' })
vim.api.nvim_set_hl(0, 'CocInfoHighlight', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = '#fabd2f' })
vim.api.nvim_set_hl(0, 'CocHintHighlight', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = '#83a598' })

vim.cmd([[
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
]])

