return {
  -- THE extensible picker
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  },
  config = function()
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
  end,
}
