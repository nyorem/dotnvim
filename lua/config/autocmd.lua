vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cmake,c,cpp',
    group = vim.api.nvim_create_augroup('black_on_save', { clear = true }),
    callback = function (opts)
        vim.opt.makeprg = "cd $(git rev-parse --show-toplevel) && cmake --build build -j 8"
        vim.keymap.set("n", "<F7>", "<cmd>Make<CR>", { buffer = true })
    end,
})
