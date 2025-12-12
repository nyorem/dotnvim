return {
  -- THE extensible picker
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  },
  config = function()
    -- options
    require('telescope').setup()

    -- keymaps
    vim.keymap.set('n', '<Leader>sd', function() Snacks.picker.grep() end, { desc = "Grep inside current directory" })

    vim.keymap.set('n', '<Leader>sp', function()
      local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
      if vim.v.shell_error == 0 then
        Snacks.picker.git_grep()
      else
        Snacks.picker.grep()
      end
    end, { desc = "Grep inside whole git repository" })

    vim.keymap.set('n', '<Leader>fn', function()
      Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Search inside neovim configuration" })

    vim.keymap.set('n', '<Leader>hh', function() Snacks.picker.help() end, { desc = "Search inside vim help" })

    vim.keymap.set('n', '<Leader>,', function() Snacks.picker.buffers() end, { desc = "List open buffers" })

    vim.keymap.set('n', '<Leader><Leader>', function() Snacks.picker.files() end, { desc = "Find a file" })

    vim.keymap.set('n', '<C-p>', function()
      vim.fn.system("git rev-parse --show-toplevel")
      if vim.v.shell_error == 0 then
        Snacks.picker.git_files()
      else
        Snacks.picker.files()
      end
    end, { desc = "Find a file in git repository" })

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
