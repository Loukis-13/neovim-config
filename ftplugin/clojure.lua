vim.filetype.add({ pattern = { [".*.json.base"] = "json" } })

vim.keymap.set("n", "<localleader>nd", "i#nu/tapd <Esc>")
vim.keymap.set("n", "<localleader>nt", "i#nu/tap <Esc>")
vim.keymap.set("n", "<localleader>nf", "i#nu/ftap <Esc>")

vim.keymap.set("ia", "nd", "#nu/tapd")
vim.keymap.set("ia", "nt", "#nu/tap")
vim.keymap.set("ia", "nf", "#nu/ftap")
