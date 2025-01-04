-- Help mode bindings
-- <CR> to follow a link
-- q to quit

vim.keymap.set("n", "<CR>", "<C-]>", { buffer = true })
vim.keymap.set("n", "q", ":q<CR>", { buffer = true})
