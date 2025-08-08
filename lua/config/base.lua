-- {{{1 BASIC OPTIONS
-- Leader
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- UI
vim.opt.number = true -- Show line numbers
vim.opt.cursorline = true -- Highlight the current line
vim.opt.scrolloff = 3 -- Number of lines to see when scrolling

-- Behaviors
vim.opt.shell = "bash" -- Default shell to use with :sh command
vim.g.markdown_folding = 1 -- Enable header folding for Markdown files
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard
vim.keymap.set("v", "<C-c>", "y") -- Use <C-c> to copy in visual mode

-- Searching
vim.opt.ignorecase = true -- Case insensitive
vim.opt.smartcase = true -- Intelligent case (if caps -> take care of the case)

-- Folds
vim.opt.foldmethod = "marker"

-- {{{1 USEFUL FUNCTIONS
-- TODO: use lua instead?
vim.cmd [[
function! ReadMan(text)
  :exe ":tabnew"
  " make it a scratch buffer (to not care about if being 'unsaved')
  :exe ":setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile"
  :exe ":r!man " . a:text . " | col -b"
  :exe ":goto"
  :exe ":delete"
  :exe ":set filetype=man"
endfunction

" source: https://vim.fandom.com/wiki/Open_a_window_with_the_man_page_for_the_word_under_the_cursor
function! ReadManNormal()
    call ReadMan(expand('<cword>'))
endfunction

" source: https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript/6271254#6271254
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! ReadManVisual()
    call ReadMan(s:get_visual_selection())
endfunction

" Strip trailing whitespace
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
]]

vim.keymap.set("n", "<leader>ss", ":call StripWhitespace()<CR>", { desc = "Strip trailing whitespaces"} )
vim.keymap.set("n", "<Space>m", ":call ReadManNormal()<CR>", { desc = "Open man page" })
vim.keymap.set("v", "<Space>m", ":call ReadManVisual()<CR>", { desc = "Open man page" })

-- {{{1 TEXT FORMATTING
vim.opt.linebreak = true -- Don't cut words in the end of lines
vim.opt.showbreak = "…" -- Starting character when a line is too long
vim.opt.smartindent = true -- Intelligent indentation

-- INVISIBLES
vim.opt.listchars = {
    tab = "▸ ",
    trail = "·",
    nbsp = "␣",
}
vim.opt.list = true -- Display invisible characters

-- TABS/SPACES PARAMETERS
vim.opt.expandtab = true -- Replace tabs by spaces
vim.opt.tabstop = 2 -- Number of spaces corresponding to a tabulation
vim.opt.softtabstop = 2 -- Spaces to delete if we delete a tab
vim.opt.shiftwidth = 2 -- Spaces used for an indentation

-- fix issue when launching neovim inside a python virtual environment
-- https://github.com/neovim/neovim/issues/1887#issuecomment-280653872
if vim.fn.exists("$VIRTUAL_ENV") == 1 then
    vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
else
    vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which python3"), "\n", "", "g")
end

-- {{{1 MAPPINGS
-- Use arrows for tab switching
vim.keymap.set("n", "<C-Left>", "gT")
vim.keymap.set("n", "<C-Right>", "gt")

-- Source files, lines
vim.keymap.set("n", "<space>X", "<cmd>source %<cr>", { desc = "Source current file" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Source current line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Source selected lines" })

-- Habit breaking, habit making
vim.keymap.set({"n", "i"}, "<Up>", "<NOP>")
vim.keymap.set({"n", "i"}, "<Left>", "<NOP>")
vim.keymap.set({"n", "i"}, "<Right>", "<NOP>")
vim.keymap.set({"n", "i"}, "<Down>", "<NOP>")

-- Duplicate current buffer in new tab
vim.keymap.set("n", "<C-w>T", ":tab split<CR>")

-- Tab motions
vim.keymap.set("n", "te", ":tabedit")
vim.keymap.set("n", "<tab>", ":tabnext<CR>")
vim.keymap.set("n", "<s-tab>", ":tabprev<CR>")

-- Restore ','
vim.keymap.set("n", ",,", ",")

-- Don't lose selection when shifting sideways
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Abolish Ex mode
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("v", "Q", ":norm @q<CR>")

-- Keep search matches in the middle of the window
-- and keep the same directions no matter we used '/' or '?'
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zvzz'", { expr = true})
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zvzz'", { expr = true})

-- Avoid lowercasing selected text in visual mode
vim.keymap.set("v", "u", "<NOP>")

-- ,m : maximize the current window
vim.keymap.set("n", "<leader>m", "<C-W>_<C-W><Bar>")

-- Don't save files named ':'
vim.keymap.set("c", "w:", "w")

-- Common mistakes
vim.keymap.set("c", "ww", "w")
vim.keymap.set("c", "qw", "wq")

-- Exit terminal mode with <Esc><Esc>
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Search within visual selection - this is magic
-- https://old.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/mo9nalp/
vim.keymap.set("x", "/", "<Esc>/\\%V") 

-- Duplicate line and comment first line
-- https://old.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/mo9t5xq/
vim.keymap.set("n", "ycc", function() return 'yy' .. vim.v.count1 .. "gcc']p" end, { remap = true, expr = true })

-- Keep cursor position when joining lines
-- https://old.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/mo9z1pd/
vim.keymap.set("n", "J", "mzJ`z:delmarks z<cr>")

-- Block insert in line visual mode
-- https://old.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/moelhto/
vim.keymap.set('x', 'I', function() return vim.fn.mode() == 'V' and '^<C-v>I' or 'I' end, { expr = true })
vim.keymap.set('x', 'A', function() return vim.fn.mode() == 'V' and '$<C-v>A' or 'A' end, { expr = true })
