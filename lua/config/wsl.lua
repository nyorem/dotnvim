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
]]

-- override vim.ui.open to use wslview if available
if vim.fn.executable("wslview") == 1 then
  local open = vim.ui.open
  vim.ui.open = function(path, opts)
    return open(path, vim.tbl_extend("keep", opts or {}, {
      cmd = { "wslview" },
    }))
  end
end
