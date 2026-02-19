-- '-x' allows ShellCheck to follow sourced files, which is important for scripts that use 'source' or '.' to include other scripts.
vim.keymap.set("n", "<F7>", "<cmd>ShellCheck! -x<CR>", { buffer = true })
