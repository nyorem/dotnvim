-- set makerg in C files
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cmake,c,cpp',
    group = vim.api.nvim_create_augroup('makeprg', { clear = true }),
    callback = function()
        vim.opt.makeprg = "cd $(git rev-parse --show-toplevel) && cmake --build build -j 8"
        vim.keymap.set("n", "<F7>", "<cmd>Make<CR>", { buffer = true })
    end,
})

-- don't use swapfiles for neogit buffers
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'NeogitConsole',
    group = vim.api.nvim_create_augroup('neogit', { clear = true }),
    callback = function()
        vim.opt.swapfile = false
    end,
})
