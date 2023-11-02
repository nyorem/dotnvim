-- {{{1 VIM-PLUG
local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/bundle")

Plug 'catppuccin/nvim'
Plug 'f-person/git-blame.nvim'
Plug 'ibhagwan/fzf-lua'
Plug 'mg979/vim-visual-multi'
Plug 'natecraddock/sessions.nvim'
Plug 'natecraddock/workspaces.nvim'
Plug 'NeogitOrg/neogit'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug 'rmagatti/auto-session'
Plug 'sindrets/diffview.nvim'
Plug 'akinsho/toggleterm.nvim'

vim.call("plug#end")

-- {{{1 catppuccin
require("catppuccin").setup({
    term_colors = true,
})

-- {{{1 NEOGIT
local neogit = require("neogit")
neogit.setup {
}
vim.keymap.set('n', '<Space>gg', ':Neogit<CR>')

-- Make fold markers don't break the diff view (see https://github.com/NeogitOrg/neogit/issues/452)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "NeogitStatus" },
    group = vim.api.nvim_create_augroup("NeogitStatusOptions", {}),
    callback = function()
      vim.opt.foldenable = false
    end,
})

-- {{{1 NEOVIDE
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false

  vim.g.coc_node_path = vim.env.HOME .."/.nvm/versions/node/v18.14.1/bin/node"

  vim.keymap.set({'i', 'c'}, '<C-v>', '<c-r>+')
  vim.keymap.set({'n', 'v'}, '<C-c>', '"+y')
end

-- {{{1 WORKSPACES and SESSIONS
require("workspaces").setup({
    sort = true,
    mru_sort = false,
    hooks = {
      open = { "Telescope find_files" },
    },
})

vim.keymap.set('n', '<Space>pa', ':WorkspacesAdd<CR>')
vim.keymap.set('n', '<Space>pd', ':WorkspacesRemove<CR>')

vim.keymap.set('n', '<Space>ps', ':SessionSave<CR>')
vim.keymap.set('n', '<Space>pr', ':SessionRestore<CR>')

-- {{{1 TELESCOPE
require('telescope').setup {
  extensions = {
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('workspaces')

vim.keymap.set('n', '<Space>pp', ':Telescope workspaces<CR>')
vim.keymap.set('n', '<Space>sp',
  require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true }
)

-- {{{1 toggleterm
require("toggleterm").setup {
  open_mapping = [[<Space>ot]],
  insert_mappings = false,
  direction = 'tab',
}

-- {{{1 git-blame
require('gitblame').setup {
     enabled = false,
}
vim.keymap.set('n', '<Space>gb', ':GitBlameToggle<CR>')

-- {{{1 COLORSCHEME
vim.cmd.colorscheme "catppuccin"
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.lightline = {colorscheme = 'catppuccin'}

-- {{{1 Other key mappings
vim.keymap.set('n', '<Space>os', ':Startify<CR>')

vim.cmd [[
  autocmd TermOpen * tnoremap <Esc><Esc> <c-\><c-n>
  autocmd FileType fzf tunmap <Esc><Esc>
]]
