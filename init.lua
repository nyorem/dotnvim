-- {{{1 config
require("config.base")
require("config.autocmds")
require("config.filetype")
require("config.wsl")
require("config.marks")

-- {{{1 plugins
-- experimental loader to make startup faster
vim.loader.enable()

-- {{{2 core
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim"
})

vim.pack.add({
  -- end certain structures automatically
  "https://github.com/tpope/vim-endwise",

  -- UNIX helpers
  "https://github.com/tpope/vim-eunuch",

  -- heuristically set buffer options
  "https://github.com/tpope/vim-sleuth",

  -- :S(subvert) to replace all occurrences of a word under the cursor, respecting case
  -- change case with cr: s = snake_case, m = MixedCase, c = camelCase, u = UPPER_CASE, - = dash-case, . = dot.case
  -- "https://github.com/tpope/vim-abolish",

  -- handy brackets mappings
  "https://github.com/tpope/vim-unimpaired",

  -- smarter paste that preserves indentation
  -- 'nemanjamalesija/smart-paste.nvim',

  -- disable search highlighting when you are done with searching
  'https://github.com/romainl/vim-cool',

  -- sudo write
  "https://github.com/lambdalisue/vim-suda",
})

-- vim-unimpaired
-- '(' and ')' are more accessible on an AZERTY layout
vim.keymap.set({"n", "o", "x"}, "(", "[", { remap = true })
vim.keymap.set({"n", "o", "x"}, ")", "]", { remap = true })

-- vim-suda
vim.keymap.set("c", "w!!", ":SudaWrite")

-- {{{2 compilation
vim.pack.add({
  -- emacs compile mode
  -- use <C-r> to recompile
  "https://github.com/ej-shafran/compile-mode.nvim",
})

-- compile-mode.nvim
vim.g.compile_mode = {
  bang_expansion = true, -- expand some special characters like '%'
  recompile_no_fail = true, -- Recompile will call Compile even if it was not called before
}

vim.keymap.set("n", "<Leader>r", ":botright vertical Compile ", { desc = "Run command" })
vim.keymap.set("n", "<Leader>R", ":botright vertical Recompile", { desc = "Rerun last command" })

-- {{{2 completion
vim.pack.add({
  -- lightning fast completion
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
  -- your best AI coding assistant
  "https://github.com/github/copilot.vim",
  -- -<space>j to jump to any definition/declaration
  "https://github.com/pechorin/any-jump.vim",
})

-- blink.cmp
require("blink.cmp").setup({
  keymap = { preset = "super-tab" },
})

-- copilot.vim
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- {{{2 debugging
vim.pack.add({
  -- debug your code
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/mfussenegger/nvim-dap-python",
  "https://github.com/igorlfs/nvim-dap-view",
})

-- dap
local dap = require('dap')

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
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
    end,
    args = function()
      return { vim.fn.input('Arguments: ', '--gtest_filter=*') }
    end,
    cwd = '${workspaceFolder}',
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      },
    },
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
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}

require("dap-python").setup("python3")

dap.configurations.c = dap.configurations.cpp

vim.keymap.set('n', '<Leader>dd', "<CMD>DapViewToggle<CR>", { desc = "Open Dap View" })
vim.keymap.set('n', '<Leader>dw', "<CMD>DapViewWatch<CR>", { desc = "Watch current variable" })
vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end, { desc = "Start/Resume debugging session" })
vim.keymap.set('n', '<Leader>de', function()
  dap.terminate()
  dap.close()
end, { desc = "Stop debugging session" })
vim.keymap.set('n', '<Leader>dl', function() require('dap').step_into() end, { desc = "Step into" })
vim.keymap.set('n', '<Leader>dh', function() require('dap').step_out() end, { desc = "Step out" })
vim.keymap.set('n', '<Leader>dj', function() require('dap').step_over() end, { desc = "Step over" })
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint" })

-- {{{2 filetypes
vim.pack.add({
  -- syntax highlighting for bitbake files (bb, bbappend, bbclass, inc)
  "https://github.com/kergoth/vim-bitbake",

  -- syntax highlighting for robot files
  "https://github.com/mfukar/robotframework-vim",

  -- syntax highlighting for jai files
  "https://github.com/rluba/jai.vim",
})

-- {{{2 git
vim.pack.add({
  -- magit like plugin
  "https://github.com/NeogitOrg/neogit",

  -- git information in buffers
  "https://github.com/lewis6991/gitsigns.nvim",

  -- Jira issues and pull requests in Neovim
  "https://github.com/emrearmagan/atlas.nvim",
  "https://github.com/esmuellert/codediff.nvim",

  -- when you need one more git helper
  -- <range>Gclog = commit history for selection (use 0 for whole file)
  "https://github.com/tpope/vim-fugitive",

  -- enable GBrowse
  "https://github.com/tpope/vim-rhubarb",

  -- git log integration in vim
  -- "https://github.com/junegunn/gv.vim",

  -- solve merge conflicts
  "https://github.com/akinsho/git-conflict.nvim",

  -- git worktrees
  "https://github.com/afonsofrancof/worktrees.nvim",

  -- Explorer key bindings:
  -- za = toggle fold under cursor 
  -- zA = toggle all folds under cursor
  -- zM = close all folds
  -- zR = open all folds
  -- t switches from inline to side by side diff
  -- i switches from tree to list view
  --
  -- Common use cases:
  -- * git diff: CodeDiff <branchA> <branchB>
  -- * PR-like diff: CodeDiff <branchA>...<branchB>
  -- * file comparison: CodeDiff file a b
  -- * directory comparison: CodeDiff dir a b
  -- * file history: CodeDiff history HEAD~10 %
  "https://github.com/esmuellert/codediff.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
})

-- neogit
local neogit = require("neogit")
neogit.setup {
  disable_insert_on_commit = true,
  auto_refresh = true,
  process_spinner = false,
}
vim.keymap.set('n', '<Leader>gg', function()
  local dir = require("utils.toolbox").get_current_dir()
  vim.cmd.lcd(dir)

  if vim.bo.filetype == "oil" then
    local cwd_without_oil = string.gsub(vim.fn.expand("%:p:h"), "oil://", "")
    require("neogit").open({ cwd = cwd_without_oil })
  else
    require("neogit").open()
  end
end, { desc = "Git status" })

-- gitsigns
local gitsigns = require('gitsigns')

gitsigns.setup {
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
vim.keymap.set('n', '<Leader>gB', gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })

vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set('v', '<Leader>gs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = "Stage lines" })

vim.keymap.set('n', '<leader>gS', gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set('v', '<Leader>gS', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = "Reset lines" })

-- atlas
require("atlas").setup({
  providers = {
    github = {},
    jira = {
      base_url = os.getenv("JIRA_BASE_URL"),
      email = os.getenv("JIRA_EMAIL"),
      token = os.getenv("JIRA_TOKEN"),
    },
  },
  pulls = {
    diff = {
      open_cmd = "CodeDiff",
    },
    repo_config = {
      paths = {
        ["etn-electrical/*"] = "/home/eaton/dev/eaton/*"
      },
    },
  },
})

vim.keymap.set("n", '<Leader>gi', '<CMD>Atlas issues<CR>', { desc = "List all the issues I'm involved in" })
vim.keymap.set("n", '<Leader>gp', '<CMD>Atlas pulls<CR>', { desc = "List all the PRs I'm involved in" })
vim.keymap.set("n", '<Leader>gP', '<CMD>Atlas create pr<CR>', { desc = "Create a PR" })

-- vim-fugitive
vim.keymap.set("n", "<Leader>gl", ":tab Git log<CR>", { desc = "Git log" })

-- TODO: use lua instead?
vim.cmd [[
autocmd User FugitiveIndex nmap <buffer> p :Git push<CR>
autocmd User FugitiveIndex nmap <buffer> P :Git push --force-with-lease<CR>
autocmd User FugitiveIndex nmap <buffer> f :Git fetch<CR>
autocmd User FugitiveIndex nmap <buffer> F :Git pull --rebase<CR>

autocmd User FugitiveIndex nmap <buffer> l :tab Git log<CR>
autocmd User FugitiveIndex nmap <buffer> <TAB> =
autocmd User FugitiveIndex nmap <buffer> x X
autocmd User FugitiveObject setlocal foldmethod=syntax nofoldenable
autocmd User FugitiveObject,FugitiveIndex nnoremap <buffer> q :q<CR>
]]

-- git-conflict.nvim
---@diagnostic disable-next-line: missing-fields
require("git-conflict").setup({})

vim.keymap.set("n", "<Leader>gw", ":Gwrite<CR>", { desc = "Mark conflicts as resolved" })

-- worktrees.nvim
require("worktrees").setup({
  base_path = ".",
  mappings = {
    delete = "<leader>wd",
  },
})

vim.keymap.set("n", "<leader>ww", function() Snacks.picker.worktrees() end, { desc = "List Worktrees" })
vim.keymap.set("n", "<leader>wa", function() Snacks.picker.worktrees_new() end, { desc = "New Worktree" })

-- codediff.nvim
require("codediff").setup({
  diff = {
    layout = "inline",
  },
  explorer = {
    view_mode = "tree",
  },
})

-- {{{2 lsp
vim.pack.add({
  -- LSP and code formatting
  "https://github.com/neovim/nvim-lspconfig",
  'https://github.com/stevearc/conform.nvim',

  "https://github.com/folke/lazydev.nvim",

  -- show diagnostics in quickfix list
  "https://github.com/folke/trouble.nvim",

  -- generic linting
  "https://github.com/mfussenegger/nvim-lint",
})

-- lsp
-- disable virtual text for diagnostics by default
vim.diagnostic.config {
  virtual_text = false,
  underline = false,
  signs = true,
}

-- blink
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- turn off logging to avoid huge file ($HOME/.local/state/nvim/lsp.log)
vim.lsp.log.set_level("off")
-- vim.lsp.log.set_level("debug") -- to turn it back on

-- bash
vim.lsp.config("bashls", {
  capabilities = capabilities,
})
vim.lsp.enable({"bashls"})

-- lua
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
})
vim.lsp.enable({"lua_ls"})

-- c/cpp
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "-j=1",
    "-background-index",
    "--malloc-trim",
  },
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp" },
})
vim.lsp.enable({"clangd"})

-- python
vim.lsp.config("pyright", {
  capabilities = capabilities,
})
vim.lsp.enable({"pyright"})

-- markdown
-- vim.lsp.config("marksman", {
--   capabilities = capabilities,
-- })
-- vim.lsp.enable({"marksman"})

-- key mappings
vim.keymap.set("n", "<Leader>cs", "<cmd>LspClangdSwitchSourceHeader<CR>", { desc = "Switch between header and source file" })
vim.keymap.set("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Run code action" })
vim.keymap.set("n", "<Leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
vim.keymap.set("n", "<Leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Find all references" })

vim.keymap.set("n", "<Leader>co", vim.diagnostic.open_float, { desc = "Open diagnostics in floating window" })

vim.keymap.set("n", "<Leader>ch", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay hints enabled" or "Inlay hints disabled")
end, { desc = "Show inlay hints" })

vim.keymap.set("n", "<Leader>ct", function()
  local current = vim.diagnostic.config()
  vim.diagnostic.config({
    virtual_text = not current.virtual_text,
    underline = not current.underline,
    signs = not current.signs,
  })
end, { desc = "Toggle diagnostics" })

-- code formatting
require("conform").setup({
    formatters_by_ft = {
      cpp = { "clang-format" },
      python = {
        -- To fix auto-fixable lint errors.
        "ruff_fix",
        -- To run the Ruff formatter.
        "ruff_format",
        -- To organize the imports.
        "ruff_organize_imports",
      }
    },
})

-- TODO: seems to be broken
vim.keymap.set({"n", "v"}, "<Leader>cf", function() require("conform").format() end, { desc = "Format selected code"} )

-- lazydev
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

-- trouble.nvim
require("trouble").setup({})
vim.keymap.set("n", "<Leader>cx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics (Trouble)" })

-- nvim-lint
require("lint").linters_by_ft = {
  bitbake = { "oelint-adv" },
  sh = { "shellcheck" },
}

vim.keymap.set("n", "<F7>", function()
  require("lint").try_lint()
end, { desc = "Lint current file" })

-- {{{2 mini
vim.pack.add({
  -- toolbox
  "https://github.com/echasnovski/mini.nvim",
})

-- mini.nvim
-- enhanced statusline
local statusline = require("mini.statusline")
statusline.setup({ use_icons = false })

-- enhance some text objects (an = around next, al = around last...)
local ai = require('mini.ai')
ai.setup({
  custom_textobjects = {
    -- treesitter-based function/class text objects:
    -- aF/iF = around/inside function, aC/iC = around/inside class
    F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    C = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
  },
})

-- nerd icons
require('mini.icons').setup({ style = "glyph" })

-- indent scope indicator
require('mini.indentscope').setup()

-- move lines or visual selection with <M-hjkl>
require('mini.move').setup()

-- new operators:
-- * cx to exchange text
-- * g= to evaluate text
-- * gm to multiply text
-- * gs to sort text
require("mini.operators").setup({
  exchange = { prefix = 'cx' },
  replace = { prefix = '' },
})

-- split and join objects with gS
require('mini.splitjoin').setup()

-- surround objects with sa (add), sd (delete), sr (replace), sh (highlight), sf/sF (find left/right)
require('mini.surround').setup()

-- {{{2 oil
vim.pack.add({
  -- netrw of the future
  "https://forge.barrettruth.com/barrettruth/canola.nvim"
})

-- canola.nvim
-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

require("oil").setup({
    win_options = {
      winbar = "%!v:lua.get_oil_winbar()",
    },
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
      -- ["<Esc>"] = { callback = "actions.close", mode = "n" },
      ["<C-p>"] = false,
      ["-"] = function()
        require("oil.actions").parent.callback()
        vim.cmd.lcd(require("oil").get_current_dir())
      end,
      ["<CR>"] = { function()
        require("oil").select(nil, function(err)
          if not err then
            local curdir = require("oil").get_current_dir()
            if curdir then
              vim.cmd.lcd(curdir)
            end
          end
        end)
      end, desc = "Select" },
      ["!"] = {function()
        local oil = require("oil")
        local entry = oil.get_cursor_entry()
        local dir = oil.get_current_dir()
        if not entry or not dir then
          return
        end
        local path = dir .. entry.name
        vim.fn.feedkeys(":")
        vim.fn.feedkeys("!")
        vim.fn.feedkeys(path)
        local go_to_beginning = vim.api.nvim_replace_termcodes("<Home><Right>", true, true, true)
        vim.fn.feedkeys(go_to_beginning)
      end, desc = "Start command line with a path under the cursor "},
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

-- remember the last directory opened in oil and provide a mapping to go back to it
-- https://github.com/stevearc/oil.nvim/issues/437#issuecomment-2207801331
local last = nil
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "oil://*",
  callback = function(args) last = require("oil").get_current_dir() end,
})

vim.keymap.set("n", "<leader>-", function()
  if last then
    require("oil").open(last)
  else
    vim.notify("No previous directory to open", vim.log.levels.WARN)
  end
end, { desc = "Reopen last directory" })

-- {{{2 overseer
vim.pack.add({
  "https://github.com/stevearc/overseer.nvim",
})

-- overseer
local overseer = require("overseer")
local build_task

overseer.setup()

vim.keymap.set("n", "<Leader>cg", function()
  overseer.run_task({ name = "CMake configure",
    params = {
      build_type = "debug",
      extra_cmake_args = "",
    }
  }) end,
  { desc = "Configure with default arguments" })

vim.keymap.set("n", "<Leader>cG", function()
  overseer.run_task({ name = "CMake configure" }) end,
  { desc = "Configure with extra arguments" })

vim.keymap.set("n", "<Leader>cc", function()
  overseer.run_task({ name = "Build target",
    params = {
      target = "all",
      jobs = 4,
    }
  },
  function(task)
    build_task = task
  end)
end, { desc = "Build with default arguments" })

vim.keymap.set("n", "<Leader>ck", function()
  if build_task then
    build_task:stop()
  end
end, { desc = "Stop current build task" })

vim.keymap.set("n", "<Leader>cC", function()
  overseer.run_task({ name = "Build target" },
    function(task)
      build_task = task
    end
  )
end, { desc = "Build with extra arguments" })

-- {{{2 pickers
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind

  if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == "update") then
    if not ev.data.active then vim.cmd.packadd('telescope-fzf-native.nvim') end
    vim.system({'cmake', '-S', '.', '-B', 'build', '-D', 'CMAKE_BUILD_TYPE=Release'}):wait()
    vim.system({'cmake', '--build', 'build', '--config', 'Release'}):wait()
  end
end })

vim.pack.add({
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-live-grep-args.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
})

-- telescope
require('telescope').setup()
local toolbox = require("utils.toolbox")

vim.keymap.set('n', '<Leader>sp', function()
  local dir = toolbox.get_current_dir()
  local root = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })[1]
  if vim.v.shell_error == 0 and root and root ~= "" then
    Snacks.picker.git_grep({ cwd = root })
  else
    Snacks.picker.grep({ cwd = dir })
  end
end, { desc = "Grep inside whole git repository of current file" })

vim.keymap.set('n', '<Leader>sd', function()
  Snacks.picker.grep({ cwd = toolbox.get_current_dir() })
end, { desc = "Grep inside current file's directory" })

vim.keymap.set('n', '<Leader>fn', function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Search inside neovim configuration" })

vim.keymap.set('n', '<Leader>hh', function() Snacks.picker.help() end, { desc = "Search inside vim help" })

vim.keymap.set('n', '<Leader>,', function() Snacks.picker.buffers() end, { desc = "List open buffers" })

vim.keymap.set('n', '<Leader><Leader>', function() Snacks.picker.files() end, { desc = "Find a file" })

vim.keymap.set('n', '<C-p>', function()
  local dir = toolbox.get_current_dir()
  local root = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })[1]
  if vim.v.shell_error == 0 and root and root ~= "" then
    Snacks.picker.git_files({ cwd = root })
  else
    Snacks.picker.files({ cwd = dir })
  end
end, { desc = "Find a file in git repository of current file" })

vim.keymap.set('n', '<Leader>fr', function() Snacks.picker.recent() end, { desc = "List all recent files" })

vim.keymap.set('n', '<Leader>gb', function() Snacks.picker.git_branches() end, { desc = "List all git branches" })

vim.keymap.set('n', '<Leader>pr', function() Snacks.picker.resume() end, { noremap = true, silent = true, desc = "Resume last picker" })

vim.keymap.set('n', '<Leader>pl', function() Snacks.picker() end, { noremap = true, silent = true, desc = "List all available pickers" })

vim.keymap.set('n', '<Leader>pk', function() Snacks.picker.keymaps() end, { noremap = true, silent = true, desc = "List keymaps" })

vim.keymap.set('n', 'z=', function() Snacks.picker.spelling() end, { desc = "Spelling suggestions" })

vim.keymap.set('n', '<Leader>ps', function() Snacks.picker.lsp_symbols() end, { desc = "LSP document symbols" })

vim.keymap.set({'n', 'x'}, '<Leader>sw', function() Snacks.picker.grep_word() end, { desc = "Grep current word" })

-- {{{2 quikfix
vim.pack.add({
  -- better quickfix (filtering with <TAB>...)
  -- "https://github.com/kevinhwang91/nvim-bqf",

  -- quickfix list as a buffer
  "https://github.com/stefandtw/quickfix-reflector.vim",
})

-- {{{2 shellcheck
vim.pack.add({
  -- checking your shell scripts
  "https://github.com/itspriddle/vim-shellcheck",
})

-- {{{2 snacks
vim.pack.add({
  -- another toolbox
  "https://github.com/folke/snacks.nvim",
})

-- snacks
require("snacks").setup({
  bigfile = { enabled = true, notify = false },
  quickfile = { enabled = true },
  -- to grep into results:
  -- - query -- <rg args> where <rg args> = *.lua or -ig *.lua or -g subdirector/** for example
  -- - <c-g> to go into live mode and .lua or !.lua
  picker = {
    enabled = true,
    main = {
      file = false, -- allow to override current buffer with picked object
    },
    sources = {
      files = {
        layout = "ivy",
      },
      git_files = {
        layout = "ivy",
      },
      grep = {
        ignorecase = true,
      },
      git_grep = {
        ignorecase = true,
      },
      worktrees = {
        title = "Worktrees",
        layout = { preset = "select", preview = false },
        ---@type snacks.picker.finder
        finder = function(opts, filter)
          local worktrees = require("worktrees.git").get_worktrees()
          if not worktrees then
            worktrees = {}
          end
          local current = require("worktrees.git").get_worktree_root() or ""

          ---@type Worktree[]
          local worktree_list = vim.tbl_values(worktrees)

          ---@async
          ---@param cb async fun(item: snacks.picker.finder.Item)
          return function(cb)
            for i, worktree in ipairs(worktree_list) do
              local item = {
                idx = i,
                file = worktree.path,
                text = vim.fs.basename(worktree.path),
                path = worktree.path,
                branch = worktree.branch,
                current = vim.fs.normalize(current) == vim.fs.normalize(worktree.path),
              }

              cb(item)
            end
          end
        end,
        format = function(item, picker)
          local a = Snacks.picker.util.align
          local ret = {} ---@type snacks.picker.Highlight[]
          if item.current then
            ret[#ret + 1] = { a("", 2), "SnacksPickerGitBranchCurrent" }
          else
            ret[#ret + 1] = { a("", 2), "SnacksPickerGitBranch" }
          end
          ret[#ret + 1] = { " " }
          Snacks.picker.highlight.format(item, a(item.text, 10), ret)
          ret[#ret + 1] = { " " }
          local branch = "[" .. item.branch:gsub("refs/heads/", "") .. "]"
          if item.current then
            ret[#ret + 1] = { a(branch, 10), "SnacksPickerGitBranchCurrent" }
          else
            ret[#ret + 1] = { a(branch, 10), "SnacksPickerGitBranch" }
          end
          ret[#ret + 1] = { " " }
          Snacks.picker.highlight.format(item, item.path, ret)
          return ret
        end,
        win = {
          input = {
            keys = {
              ["<C-x>"] = { "delete", mode = { "i", "n" } },
            },
          },
        },
        actions = {
          ---@param picker snacks.Picker
          delete = function(picker)
            local items = picker:selected({ fallback = true })
            local worktrees = #items > 1 and " worktrees?" or " worktree?"
            vim.ui.select(
              { "Yes", "No" },
              { prompt = "Really want to delete " .. #items .. worktrees },
              function(choise)
                if choise == "Yes" then
                  for _, item in ipairs(items) do
                    local current_worktree_path = require("worktrees.git").get_worktree_root() or ""
                    if vim.fs.normalize(current_worktree_path) ~= vim.fs.normalize(item.path) then
                      require("worktrees").utils.delete_worktree(item.path)
                    else
                      vim.notify("Cannot delete current worktree", vim.log.levels.ERROR)
                    end
                  end
                  picker:find()
                end
              end
            )
          end,
        },
        confirm = function(picker, item)
          picker:close()
          if item == nil then
            return vim.notify("No worktree selected", vim.log.levels.WARN)
          end
          if item.current then
            return vim.notify("Selected worktree already active", "info")
          end
          return require("worktrees").utils.switch_worktree(item.path)
        end,
      },
      worktrees_new = {
        title = "New worktree",
        finder = "git_branches",
        format = "git_branch",
        preview = "git_log",
        all = true,
        win = {
          input = {
            keys = {
              ["<C-n>"] = { "new", mode = { "i", "n" } },
            },
          },
        },
        actions = {
          ---@param picker snacks.Picker
          new = function(picker)
            picker:close()
            local branch = picker.finder.filter.pattern
            require("worktrees").utils.create_worktree("", branch, true)
          end,
        },
        ---@param picker snacks.Picker
        ---@param item? snacks.picker.Item
        confirm = function(picker, item)
          picker:close()
          local branch = item ~= nil and item.branch or picker.finder.filter.pattern
          require("worktrees").utils.create_worktree("", branch, true)
        end,
      },
    },
  }
})

-- {{{2 terminal
vim.pack.add({
  -- nested neovim sessions inside terminal
  "https://github.com/brianhuster/unnest.nvim",

  -- toggleable terminal window
  'https://github.com/akinsho/toggleterm.nvim',
})

-- toggleterm.nvim
require("toggleterm").setup {
  size = function(term)
    if term.direction == "vertical" then
      return 0.5 * vim.o.columns
    else
      return 15
    end
  end,
  shade_terminals = false,
  start_on_insert = false,
  -- autochdir = true,
}

vim.keymap.set('n', '<Leader>to', ":ToggleTerm direction=vertical<CR>", { desc = "Open a terminal on the side" })

-- automatically go into insert mode when entering a terminal buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*toggleterm#*",
  callback = function()
    vim.schedule(function()
      vim.cmd("startinsert")
    end)
  end,
})

-- {{{2 testing
vim.pack.add({
  -- ctest integration
  "https://github.com/nyorem/ctest-telescope.nvim",

  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/antoinemadec/FixCursorHold.nvim",

  -- adapters below
  "https://github.com/orjangj/neotest-ctest",
})

-- ctest-telescope.nvim
require("ctest-telescope").setup({})

vim.keymap.set("n", "<Leader>tr", function()
  if vim.bo.filetype == "cpp" or vim.bo.filetype == "c" or vim.bo.filetype == "oil" then
    require("ctest-telescope").run_test()
  end
end, { desc = "Run test (telescope)" })

-- neotest
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      -- Convert newlines, tabs and whitespaces into a single whitespace
      -- for improved virtual text readability
      local message = diagnostic.message:gsub("[\r\n\t%s]+", " ")
      return message
    end,
  },
}, neotest_ns)

require("neotest").setup({
  adapters = {
    require("neotest-ctest").setup({
      is_test_file = function(file)
        local basename = vim.fs.basename(file)
        return string.match(basename, "Test.+cpp") ~= nil or string.match(basename, "test_.+cpp") ~= nil
      end,
    })
  }
})

vim.keymap.set("n", "<Leader>tt", "<cmd>Neotest run<cr>", { desc = "Run test under cursor" })
vim.keymap.set("n", "<Leader>ti", "<cmd>Neotest output<cr>", { desc = "Test output" })
vim.keymap.set("n", "<Leader>ts", "<cmd>Neotest summary<cr>", { desc = "Test summary" })
vim.keymap.set("n", "<Leader>ta", "<cmd>lua require('neotest').run.run({ suite = true })<cr>", { desc = "Run all tests" })

-- {{{2 text
vim.pack.add({
  -- gl = align
  "https://github.com/tommcdo/vim-lion",

  -- yank ring
  -- "https://github.com/gbprod/yanky.nvim",

  -- incremental selection with <CR>
  "https://github.com/SUSTech-data/wildfire.nvim",

  -- context aware indentation for code blocks in Markdown
  "https://github.com/wurli/contextindent.nvim",

  -- better f/F/t/T movements with indicators
  "https://github.com/unblevable/quick-scope",

  -- Markdown table manipulation:
  -- Go to next cell = '<TAB>'
  -- Go to previous cell = '<S-TAB>'
  -- Insert a row above the current row = '<M-k>'
  -- Insert a row below the current row = '<M-j>'
  -- Move the current row up = '<M-S-k>'
  -- Move the current row down = '<M-S-j>'
  -- Insert a column to the left of current column = '<M-h>'
  -- Insert a column to the right of current column = '<M-l>'
  -- Move the current column to the left = '<M-S-h>'
  -- Move the current column to the right = '<M-S-l>'
  -- Insert a new table = '<M-t>'
  -- Insert a new table that is not surrounded by pipes = '<M-S-t>'
  -- Delete the column under cursor = '<M-d>'
  "https://github.com/SCJangra/table-nvim",

  "https://github.com/ywpkwon/yank-path.nvim",

  "https://github.com/SunnyTamang/select-undo.nvim",
})

-- wildfire
require("wildfire").setup()

-- quick-scope
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

-- table-nvim
require("table-nvim").setup({})

-- yank-path
require("yank-path").setup({
  default_mapping = false, -- disable default 'Y' mapping
})

vim.keymap.set("n", "<Leader>yy", "<CMD>YankPath<CR>", { desc = "Yank full path of current file" })

-- select-undo
require("select-undo").setup({
  line_mapping = "zu",     -- Step undo mapping (frees gu for lowercasing)
  sweep_mapping = "zU",    -- Sweep undo mapping (frees gU for uppercasing)
  partial_mapping = "zcu", -- Partial undo mapping
})

-- {{{2 theme
vim.pack.add({
  -- the best theme
  "https://github.com/catppuccin/nvim",
})

-- catppuccin
vim.cmd.colorscheme "catppuccin"

-- {{{2 treesitter
vim.pack.add({
  "https://github.com/romus204/tree-sitter-manager.nvim",

  -- syntax-aware text objects and motions (provides the `textobjects`
  -- queries used by mini.ai for aF/iF/aC/iC selections too)
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

-- tree-sitter-manager
require("tree-sitter-manager").setup({
  ensure_installed = { "bash", "c", "cmake", "cpp", "comment", "json", "lua", "markdown", "markdown_inline", "python", "query", "regex", "vim", "vimdoc", "yaml" },
})

-- nvim-treesitter-textobjects
require("nvim-treesitter-textobjects").setup({
  move = { set_jumps = true },
})

local move = require("nvim-treesitter-textobjects.move")

-- Jump to start/end of next/previous function.
vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Previous function start" })
vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Previous function end" })

-- {{{2 which-key
vim.pack.add({
  -- don't forget your keybindings
  "https://github.com/folke/which-key.nvim",
})

-- which-key.nvim
vim.o.timeout = true
vim.o.timeoutlen = 500

local wk = require('which-key')

wk.setup({
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
})

wk.add({
  { "gc", group = "Comment" },
  { "<Leader>c", group = "LSP" },
  { "<Leader>d", group = "Debugging" },
  { "<Leader>f", group = "Files" },
  { "<Leader>g", group = "Git" },
  { "<Leader>h", group = "Help" },
  { "<Leader>gp", group = "Github" },
  { "<Leader>p", group = "Projects & Pickers" },
  { "<Leader>s", group = "Search & Sessions" },
  { "<Leader>t", group = "Terminal & Testing" },
  { "<Leader>u", group = "Utilities" },
  { "<Leader>w", group = "Worktrees" },
})

-- {{{2 workspaces
vim.pack.add({
  -- manage projects
  "https://github.com/natecraddock/workspaces.nvim",

  -- manage your sessions
  -- "https://github.com/natecraddock/sessions.nvim",
})

-- workspaces.nvim
require("workspaces").setup({
    sort = true,
    mru_sort = false,
    cd_type = "local",
    hooks = {
      open = function() Snacks.picker.git_files() end,
    },
})
vim.keymap.set('n', '<Leader>pa', '<Cmd>WorkspacesAdd<CR>', { desc = "Add current directory to workspace list" })
vim.keymap.set('n', '<Leader>pd', '<Cmd>WorkspacesRemove<CR>', { desc = "Remove current directory from the workspace list" })

-- copied from https://github.com/folke/snacks.nvim/discussions/498#discussioncomment-11859446
vim.keymap.set('n', '<Leader>pp', function()
  local items = {}
  local longest_name = 0
  for i, workspace in ipairs(require('workspaces').get()) do
    table.insert(items, {
      idx = i,
      score = i,
      text = workspace.path,
      name = workspace.name,
    })
    longest_name = math.max(longest_name, #workspace.name)
  end
  longest_name = longest_name + 2
  return Snacks.picker({
    items = items,
    format = "text",
    layout = "select",
    confirm = function(picker, item)
      picker:close()
      vim.cmd(('WorkspacesOpen %s'):format(item.name))
    end,
  })
end, { desc = "Pick project" })

