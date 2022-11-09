vim.diagnostic.config{
  virtual_text = {
    prefix = ' ',
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    source = "always",
  },
}

-- vim.g.kommentary_create_default_mappings = false

-- -- Undercurls on errors and warnings
-- vim.api.nvim_set_hl(0, 'CocErrorHighlight', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = '#fb4934' })
-- vim.api.nvim_set_hl(0, 'CocWarningHighlight', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = '#fe8019' })
-- vim.api.nvim_set_hl(0, 'CocInfoHighlight', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = '#fabd2f' })
-- vim.api.nvim_set_hl(0, 'CocHintHighlight', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = '#83a598' })
