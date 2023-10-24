-- {{{1 VIM-PLUG
local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/bundle")

Plug 'catppuccin/nvim'
Plug 'ibhagwan/fzf-lua'
Plug 'mg979/vim-visual-multi'
Plug 'NeogitOrg/neogit'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'olimorris/persisted.nvim'
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

-- {{{1 PERSISTED
require("persisted").setup {
}

-- {{{1 toggleterm
require("toggleterm").setup {
  open_mapping = [[<Space>ot]],
  insert_mappings = false,
  direction = 'tab',
}

-- {{{1 STUFF
vim.cmd.colorscheme "catppuccin"
vim.o.background = "dark"
vim.o.termguicolors = true

vim.g.lightline = {colorscheme = 'catppuccin'}

vim.keymap.set('n', '<Space>ot', ':tabedit term://%:p:h//bash<CR>A')
vim.keymap.set('n', '<Space>os', ':Startify<CR>')

vim.keymap.set('t', '<C-o>', '<C-\\><C-n>')
