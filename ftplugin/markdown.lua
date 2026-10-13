vim.opt.conceallevel = 2

vim.api.nvim_create_user_command("FormatTable", function(_) vim.cmd("! tr -s ' ' | column -t -s '|' -o '|'") end, {})
