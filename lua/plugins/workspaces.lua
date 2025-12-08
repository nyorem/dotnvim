return {
  {
    -- manage projects
    "natecraddock/workspaces.nvim",
    config = function()
      require("workspaces").setup({
          sort = true,
          mru_sort = false,
          cd_type = "local",
          hooks = {
            open = function() Snacks.picker.files() end,
          },
      })
      require('telescope').load_extension('workspaces')
      vim.keymap.set('n', '<Leader>pa', '<Cmd>WorkspacesAdd<CR>', { desc = "Add current directory to workspace list" })
      vim.keymap.set('n', '<Leader>pd', '<Cmd>WorkspacesRemove<CR>', { desc = "Remove current directory from the workspace list" })
      vim.keymap.set('n', '<Leader>pp', '<Cmd>Telescope workspaces<CR>', { desc = "List all workspaces" })
    end,
  },
  {
    -- manage your sessions
    "natecraddock/sessions.nvim",
    config = function()
      require("sessions").setup({
          session_filepath = vim.fn.stdpath("data") .. "/sessions",
          absolute = true,
      })

      vim.keymap.set('n', '<Leader>ss', '<Cmd>SessionsSave<CR>', { desc = "Save current session" })
      vim.keymap.set('n', '<Leader>sr', '<Cmd>SessionsLoad<CR>', { desc = "Restore last session" })
    end,
  },
}
