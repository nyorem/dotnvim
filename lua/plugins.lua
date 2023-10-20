-- {{{1 VIM-PLUG
local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.nvim/bundle")

Plug 'nvim-lua/plenary.nvim'
Plug 'NeogitOrg/neogit'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'

Plug 'sindrets/diffview.nvim'
Plug 'ibhagwan/fzf-lua'

Plug 'catppuccin/nvim'
Plug 'olimorris/persisted.nvim'

vim.call("plug#end")

-- {{{1 NEOGIT
local neogit = require("neogit")
neogit.setup {
}
vim.keymap.set('n', '<Space>gg', ':Neogit<CR>')

-- {{{1 NEOVIDE
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false

  vim.g.coc_node_path = vim.env.HOME .."/.nvm/versions/node/v18.14.1/bin/node"

  vim.keymap.set({'i', 'c'}, '<C-v>', '<c-r>+')
  vim.keymap.set({'n', 'v'}, '<C-c>', '"+y')
end

-- {{{1 TELESCOPE
require("telescope").load_extension("persisted")

require('telescope').setup {
  extensions = {
    project = {
      order_by = "asc",
    }
  }
}
vim.keymap.set('n', '<Space>pp', ':Telescope project<CR>')
vim.keymap.set('n', '<Space>sp',
  require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true }
)

-- {{{1 STUFF
vim.cmd.colorscheme "catppuccin"

-- {{{1 PERSISTED
require("persisted").setup {
}
