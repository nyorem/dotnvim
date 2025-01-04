return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  },
  config = function()
    -- options
    require('telescope').setup {
      defaults = {
        layout_config = {
          preview_width = 0.5,
        }
      },
      extensions = {
        cmdline = {
        },
        live_grep_args = {
          auto_quoting = false,
        },
      }
    }

    -- extensions
    local telescope = require("telescope")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("fzf")

    -- keymaps
    vim.keymap.set('n', '<Space>sd', ':Telescope live_grep<CR>', { desc = "Grep inside current directory" })
    vim.keymap.set('n', '<Space>sp', function()
      local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
      if vim.v.shell_error == 0 then
        require("telescope").extensions.live_grep_args.live_grep_args({ noremap = true, cwd = root })
      else
        require("telescope").extensions.live_grep_args.live_grep_args({ noremap = true })
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
    vim.keymap.set('n', '<Space>tr', ":Telescope resume<CR>", { noremap = true, silent = true, desc = "Resume last telescope picker" })
    vim.keymap.set('n', '<Space>tp', ":Telescope pickers<CR>", { noremap = true, silent = true, desc = "List previously used telescope pickers" })
  end,
}
