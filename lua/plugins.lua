-- {{{1 vim-plug
local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/bundle")

Plug 'akinsho/toggleterm.nvim'
Plug 'catppuccin/nvim'
Plug 'f-person/git-blame.nvim'
Plug 'folke/which-key.nvim'
Plug 'ibhagwan/fzf-lua'
Plug 'ldelossa/nvim-dap-projects'
Plug 'mg979/vim-visual-multi'
Plug 'mfussenegger/nvim-dap'
Plug 'natecraddock/sessions.nvim'
Plug 'natecraddock/workspaces.nvim'
Plug 'NeogitOrg/neogit'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug 'prichrd/netrw.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'sindrets/diffview.nvim'

vim.call("plug#end")

-- {{{1 catppuccin
require("catppuccin").setup({
    term_colors = true,
})

-- {{{1 neogit
local neogit = require("neogit")
neogit.setup {}
vim.keymap.set('n', '<Space>gg', ':Neogit cwd=%:p:h<CR>')

-- Make fold markers don't break the diff view (see https://github.com/NeogitOrg/neogit/issues/452)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "NeogitStatus" },
    group = vim.api.nvim_create_augroup("NeogitStatusOptions", {}),
    callback = function()
      vim.opt.foldenable = false
    end,
})

-- {{{1 neovide
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false

  vim.g.coc_node_path = vim.env.HOME .."/.nvm/versions/node/v18.14.1/bin/node"

  vim.keymap.set({'i', 'c'}, '<C-v>', '<c-r>+')
  vim.keymap.set({'n', 'v'}, '<C-c>', '"+y')
end

-- {{{1 workspaces and sessions
require("workspaces").setup({
    sort = true,
    mru_sort = false,
    cd_type = "local",
    hooks = {
      open = { "Telescope find_files" },
    },
})

vim.keymap.set('n', '<Space>pa', ':WorkspacesAdd<CR>')
vim.keymap.set('n', '<Space>pd', ':WorkspacesRemove<CR>')

require("sessions").setup({
    session_filepath = vim.fn.stdpath("data") .. "/sessions",
    absolute = true,
})

vim.keymap.set('n', '<Space>ps', ':SessionsSave<CR>')
vim.keymap.set('n', '<Space>pr', ':SessionsLoad<CR>')

-- {{{1 telescope
require('telescope').setup {
  defaults = {
    layout_config = {
      preview_width = 0.5,
    }
  },
  extensions = {
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('workspaces')

vim.keymap.set('n', '<Space>pp', ':Telescope workspaces<CR>')
vim.keymap.set('n', '<Space>sp', function()
  local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").live_grep({ noremap = true, cwd = root })
  else
    require("telescope.builtin").live_grep({ noremap = true })
  end
end)

-- {{{1 toggleterm
require("toggleterm").setup {
  open_mapping = [[<Space>tt]],
  insert_mappings = false,
  terminal_mappings = false,
  direction = 'tab',
  autochdir = true,
}

-- automatically enter insert mode when opening a terminal
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
    callback = function(args)
      if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
        vim.cmd("startinsert")
      end
    end,
  })

vim.keymap.set('n', '<Space>tn', ':tab terminal<CR>')

-- {{{1 git-blame
require('gitblame').setup {
     enabled = false,
}
vim.keymap.set('n', '<Space>gb', ':GitBlameToggle<CR>')

-- {{1 netrw.nvim
require("netrw").setup {
  mappings = {
    -- Copy absolute path of file under cursor to clipboard
    ['<Space>y'] = function(payload)
      local absolute_path = payload.dir .. "/" .. payload.node
      vim.fn.setreg('+', absolute_path)
    end,
  },
}

-- {{{1 nvim-dap
local dap = require('dap')
local dapui = require("dapui")

dapui.setup()

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.env.HOME .. '/bin/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

vim.keymap.set('n', '<Space>dd', function() require('dap').continue() end)
vim.keymap.set('n', '<Space>de', function()
  local dap = require('dap')
  local dapui = require("dapui")
  dap.terminate()
  dap.close()
  dapui.close()
end)
vim.keymap.set('n', '<Space>dl', function() require('dap').step_into() end)
vim.keymap.set('n', '<Space>dh', function() require('dap').step_out() end)
vim.keymap.set('n', '<Space>dj', function() require('dap').step_over() end)
vim.keymap.set('n', '<Space>db', function() require('dap').toggle_breakpoint() end)

require('nvim-dap-projects').search_project_config()

-- {{{2 nvim-dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- {{{1 which-key
vim.o.timeout = true
vim.o.timeoutlen = 500

require('which-key').setup {
  key_labels = {
    ["<Space>"] = "SPC",
    ["<CR>"] = "RET",
    ["<tab>"] = "TAB",
  },
}

-- {{{1 colorscheme
vim.cmd.colorscheme "catppuccin"
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.lightline = { colorscheme = 'catppuccin' }

-- {{{1 other stuff
vim.keymap.set('n', '<Space>os', ':Startify<CR>')

vim.cmd [[
  autocmd TermOpen * tnoremap <Esc><Esc> <c-\><c-n>
  autocmd FileType fzf silent! tunmap <Esc><Esc>
]]
