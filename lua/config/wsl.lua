-- TODO: use lua instead?
vim.cmd [[
    if executable('wslview')
        " see https://old.reddit.com/r/neovim/comments/olq8dw/defining_the_browse_command_for_use_with/
        " wslview comes from https://github.com/wslutilities/wslu
        " escaping trick comes from https://stackoverflow.com/questions/15394572/escaping-in-vim-when-shelling-out-so-its-not-expanded-to-filename
        function OpenBrowserWsl(url)
            execute "!wslview " . shellescape(a:url, 1)
        endfunction

        command! -nargs=1 Browse call OpenBrowserWsl(<f-args>)
    endif

    " <ctrl-i> and <tab> are the same in terminal vim, so we need to remap it
    nnoremap <C-n>i <C-i>
]]
