-- {{{1 vim-plug
local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/bundle")

Plug 'akinsho/toggleterm.nvim'
Plug 'catppuccin/nvim'
Plug 'Civitasv/cmake-tools.nvim'
Plug 'folke/which-key.nvim'
Plug 'github/copilot.vim'
Plug 'ibhagwan/fzf-lua'
Plug 'jonarrien/telescope-cmdline.nvim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'ldelossa/nvim-dap-projects'
Plug 'kylechui/nvim-surround'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'natecraddock/sessions.nvim'
Plug 'natecraddock/workspaces.nvim'
Plug 'NeogitOrg/neogit'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug 'nvim-tree/nvim-tree.lua'
Plug 'pwntester/octo.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'sindrets/diffview.nvim'
Plug 'stevearc/oil.nvim'

vim.call("plug#end")

-- {{{1 catppuccin
require("catppuccin").setup({
    term_colors = true,
})

-- {{{1 neovide
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false

  vim.g.coc_node_path = vim.env.HOME .."/.nvm/versions/node/v18.14.1/bin/node"
  vim.g.copilot_node_command = vim.env.HOME .."/.nvm/versions/node/v18.14.1/bin/node"

  vim.keymap.set({'i', 'c'}, '<C-v>', '<c-r>+')
  vim.keymap.set({'n', 'v'}, '<C-c>', '"+y')

  -- source: https://neovide.dev/faq.html#how-can-i-dynamically-change-the-scale-at-runtime
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-+>", function()
      change_scale_factor(1/1.25)
    end)
end

-- {{{1 neogit
local neogit = require("neogit")
neogit.setup {
  disable_insert_on_commit = true,
}
-- vim.keymap.set('n', '<Space>gg', function()
--   local cwd_without_oil = string.gsub(vim.fn.expand("%:p:h"), "oil://", "")
--   require("neogit").open({ cwd = cwd_without_oil })
-- end)

-- {{{1 workspaces and sessions
require("workspaces").setup({
    sort = true,
    mru_sort = false,
    cd_type = "local",
    hooks = {
      open = { "Telescope find_files" },
    },
})

require('telescope').load_extension('workspaces')
vim.keymap.set('n', '<Space>pa', ':WorkspacesAdd<CR>', { desc = "Add current directory to workspace list" })
vim.keymap.set('n', '<Space>pd', ':WorkspacesRemove<CR>', { desc = "Remove current directory from the workspace list" })
vim.keymap.set('n', '<Space>pp', ':Telescope workspaces<CR>', { desc = "List all workspaces" })

require("sessions").setup({
    session_filepath = vim.fn.stdpath("data") .. "/sessions",
    absolute = true,
})

vim.keymap.set('n', '<Space>ps', ':SessionsSave<CR>', { desc = "Save current session" })
vim.keymap.set('n', '<Space>pr', ':SessionsLoad<CR>', { desc = "Restore last session" })

-- {{{1 telescope
require('telescope').setup {
  defaults = {
    layout_config = {
      preview_width = 0.5,
    }
  },
  extensions = {
    cmdline = {
      picker = {
        layout_config = {
          width  = 130,
          height = 40,
        }
      },
    },
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('cmdline')

vim.api.nvim_set_keymap('n', '<leader><leader>', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })

vim.keymap.set('n', '<Space>sd', ':Telescope live_grep<CR>', { desc = "Grep inside current directory" })
vim.keymap.set('n', '<Space>sp', function()
  local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").live_grep({ noremap = true, cwd = root })
  else
    require("telescope.builtin").live_grep({ noremap = true })
  end
end, { desc = "Grep inside whole git repository" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Space>h', builtin.help_tags, { desc = "Search inside vim help" })
vim.keymap.set('n', '<Space>,', builtin.buffers, { desc = "List open buffers" })
vim.keymap.set('n', '<Space><Space>', builtin.find_files, { desc = "Find a file" })
vim.keymap.set('n', '<C-p>', function()
  if not pcall(builtin.git_files) then builtin.find_files() end
end, { desc = "Find a file in git repository" })
vim.keymap.set('n', '<Space>fr', builtin.oldfiles, { desc = "List all recent files" })
vim.keymap.set('n', '<Space>gb', ":Telescope git_branches<CR>", { noremap = true, silent = true, desc = "List all git branches" })

-- {{{1 toggleterm
require("toggleterm").setup {
  size = function(term)
    if term.direction == "vertical" then
      return 0.5 * vim.o.columns
    else
      return 15
    end
  end,
  shade_terminals = false,
  -- autochdir = true,
}
vim.keymap.set('n', '<Space>tt', ":ToggleTerm direction=vertical<CR>", { desc = "Open a terminal on the side" })

-- automatically enter insert mode when opening a terminal
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
    callback = function(args)
      if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
        vim.cmd("startinsert")
      end
    end,
  })

vim.keymap.set('n', '<Space>tn', ':tab terminal<CR>', { desc = "Open a terminal in a new tab" })

-- {{{1 gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '>' },
    delete = { text = '-' },
    topdelete = { text = '^' },
    changedelete = { text = '<' },
  },
  current_line_blame_opts = {
    delay = 0,
  }
}
vim.keymap.set('n', '<Space>gB', ':Gitsigns toggle_current_line_blame<CR>', { desc = "Toggle git blame" })

-- {{{1 diffview.nvim
require("diffview").setup {
  use_icons = false,
  keymaps = {
    file_panel = {
      { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
    }
  }
}
vim.keymap.set('n', '<Space>gd', ":DiffviewOpen<CR>", { noremap = true, silent = true, desc = "Open diffview" })

-- {{{1 nvim-dap
local dap = require('dap')
local dapui = require("dapui")

dapui.setup()

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.env.HOME .. '/dev/bin/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
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

dap.configurations.c = dap.configurations.cpp

vim.keymap.set('n', '<Space>dd', function() require('dap').continue() end, { desc = "Start/Resume debugging session" })
vim.keymap.set('n', '<Space>de', function()
  local dap = require('dap')
  local dapui = require("dapui")
  dap.terminate()
  dap.close()
  dapui.close()
end, { desc = "Stop debugging session" })
vim.keymap.set('n', '<Space>dl', function() require('dap').step_into() end, { desc = "Step into" })
vim.keymap.set('n', '<Space>dh', function() require('dap').step_out() end, { desc = "Step out" })
vim.keymap.set('n', '<Space>dj', function() require('dap').step_over() end, { desc = "Step over" })
vim.keymap.set('n', '<Space>db', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint" })

require('nvim-dap-projects').search_project_config()

-- {{{2 nvim-dap-ui
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- {{{1 nvim-tree
require("nvim-tree").setup()

vim.keymap.set('n', '<Space>n', ':NvimTreeFindFileToggle<CR>', { desc = "Toggle file tree" })

-- {{{1 which-key
vim.o.timeout = true
vim.o.timeoutlen = 500

require('which-key').setup {
  replace = {
    key = {
      { "<Space>", "SPC" },
      { "<CR>", "RET" },
      { "<tab>", "TAB" },
    },
  },
  icons = {
    mappings = false,
  },
}

local wk = require('which-key')

wk.add({
  { "gc", group = "Comment" },
  { "<Space>c", group = "LSP" },
  { "<Space>ca", desc = "Run code action" },
  { "<Space>cd", desc = "Go to definition" },
  { "<Space>cf", desc = "Format selected code" },
  { "<Space>cr", desc = "Find all references" },
  { "<Space>d", group = "Debugging" },
  { "<Space>dc", desc = "Continue debugging session" },
  { "<Space>dk", desc = "Restart Vimspector" },
  { "<Space>dt", desc = "Toggle breakpoint" },
  { "<Space>dT", desc = "Clear all breakpoints" },
  { "<Space>f", group = "Files" },
  { "<Space>g", group = "Git" },
  { "<Space>gl", desc = "Git log" },
  { "<Space>gg", desc = "Git status" },
  { "<Space>gp", group = "Github" },
  { "<Space>jp", group = "Pretty print JSON buffer" },
  { "<Space>p", group = "Projects" },
  { "<Space>s", group = "Search" },
  { "<Space>t", group = "Terminal" },
  { "<Space>v", group = "Vim" },
})

-- {{{1 nvim-bqf
require("bqf").setup({
    preview = {
      auto_preview = false,
    },
})

-- {{{1 nvim-surround
require("nvim-surround").setup({})

-- {{{1 oil.nvim
require("oil").setup({
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, bufnr)
        return name == "." or name == ".."
      end,
    },
    skip_confirm_for_simple_edits = true,
    -- change cwd when changing directory from oil
    -- https://github.com/stevearc/oil.nvim/issues/68
    keymaps = {
      ["<C-p>"] = false,
      ["-"] = function()
        require("oil.actions").parent.callback()
        vim.cmd.lcd(require("oil").get_current_dir())
      end,
      ["<CR>"] = function()
        require("oil").select(nil, function(err)
          if not err then
            local curdir = require("oil").get_current_dir()
            if curdir then
              vim.cmd.lcd(curdir)
            end
          end
        end)
      end,
      ["<Space>y"] = function()
        -- source: https://github.com/stevearc/oil.nvim/blob/fb8b101d7cb4727d8719ab6ed141330eca997d3f/lua/oil/actions.lua#L194
        local oil = require("oil")
        local entry = oil.get_cursor_entry()
        local dir = oil.get_current_dir()
        if not entry or not dir then
          return
        end
        vim.fn.setreg("+", dir .. entry.name)
      end,
    },
})

-- vim-vinegar like mapping to go up a directory
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- use <CR> to confirm and <ESC> to quit in a prompt
-- https://github.com/stevearc/oil.nvim/issues/114#issuecomment-1571332722
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil_preview",
  callback = function(params)
    vim.keymap.set("n", "<CR>", "o", { buffer = params.buf, remap = true, nowait = true })
    vim.keymap.set("n", "<ESC>", "c", { buffer = params.buf, remap = true, nowait = true })
  end,
})


-- {{{1 cmake-tools.nvim
require("cmake-tools").setup{
    cmake_generate_options = {
      "-DENABLE_STANDALONE=TRUE",
      "-DENABLE_CDS=FALSE",
      "-DENABLE_TEST=TRUE",
      "-DENABLE_RUN_TESTS_AFTER_BUILD=FALSE",
      "-DENABLE_SRR=TRUE",
      "-DENABLE_DM=TRUE",
      "-DREST_API_VERSION=2",
      "-DENABLE_GTEST_DISCOVER=TRUE",
      "-DENABLE_EVCI=TRUE",
      "-DENABLE_OCPP16=TRUE",
    },
    cmake_build_options = { "-j8" },
    cmake_build_directory = "./build",
    cmake_executor = {
      name = "quickfix",
      default_opts = {
        quickfix = {
          size = 20,
          auto_close_when_success = false,
        },
        toggleterm = {
          direction = "horizontal",
          auto_scroll = true,
        },
        terminal = {
          split_size = 20,
        },
      },
    },
}

vim.keymap.set('n', '<F6>', ':CMakeGenerate<CR>', { desc = "Configure CMake project" })
vim.keymap.set('n', '<F7>', ':CMakeBuild<CR>', { desc = "Build CMake project" })
vim.keymap.set('n', '<F8>', ':CMakeCloseExecutor<CR>', { desc = "Close CMake executor" })

-- {{{1 octo.nvim
require("octo").setup({
    enable_builtin = true,
    suppress_missing_scope = {
      projects_v2 = true,
    },
    file_panel = {
      use_icons = false,
    },
})

vim.keymap.set('n', '<Space>go', '<CMD>Octo<CR>', { desc = "Open Octo dashboard" })
vim.keymap.set('n', '<Space>gpc', ':Octo search is:pr archived:false author:@me is:open<CR>', { desc = "List all the PRs I created" })
vim.keymap.set('n', '<Space>gpa', ':Octo search is:pr archived:false assignee:@me is:open<CR>', { desc = "List all the PRs assigned to me" })
vim.keymap.set('n', '<Space>gpm', ':Octo search is:pr archived:false mentions:@me is:open<CR>', { desc = "List all the PRs where I am mentioned" })
vim.keymap.set('n', '<Space>gpr', ':Octo search is:pr archived:false review-requested:@me is:open<CR>', { desc = "List all the PRs where I am requested to review" })

-- {{{1 colorscheme
vim.cmd.colorscheme "catppuccin"
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.lightline = { colorscheme = 'catppuccin' }

-- {{{1 other stuff
vim.keymap.set('n', '<Space>vv', ':e ~/.config/nvim/lua/plugins.lua<CR>', { desc = "Edit neovim configurtion" })

vim.cmd [[
  autocmd TermOpen * tnoremap <Esc><Esc> <c-\><c-n>
  autocmd FileType fzf silent! tunmap <Esc><Esc>
]]

-- fix issue when launching neovim inside a python virtual environment
-- https://github.com/neovim/neovim/issues/1887#issuecomment-280653872
if vim.fn.exists("$VIRTUAL_ENV") == 1 then
    vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
else
    vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which python3"), "\n", "", "g")
end
