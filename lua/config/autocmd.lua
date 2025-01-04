vim.cmd [[
augroup vimrcEx
    autocmd!

    " New filetypes
    autocmd BufNewFile,BufRead *.ecpp setlocal filetype=cpp

    " Specific parameters for some filetypes
    autocmd FileType cmake,c,cpp let &makeprg = "cd $(git rev-parse --show-toplevel) && cmake --build build -j 8"
    autocmd FileType cmake,c,cpp  nnoremap <buffer> <F7> :Make<CR>
    autocmd FileType sh nnoremap <buffer> <F7> :ShellCheck!<CR>
    autocmd FileType markdown setlocal foldlevel=99

    " Help mode bindings
    " <CR> to follow a link
    " C-t to go back
    " q to quit
    autocmd filetype help nnoremap <buffer><CR> <C-]>
    autocmd filetype help nnoremap <buffer>q :q<CR>
augroup END
]]
