return {
  {
    "natecraddock/workspaces.nvim",
    config = function()
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
    end,
  },
  {
    "natecraddock/sessions.nvim",
    config = function()
      require("sessions").setup({
          session_filepath = vim.fn.stdpath("data") .. "/sessions",
          absolute = true,
      })

      vim.keymap.set('n', '<Space>ps', ':SessionsSave<CR>', { desc = "Save current session" })
      vim.keymap.set('n', '<Space>pr', ':SessionsLoad<CR>', { desc = "Restore last session" })
    end,
  }
}
