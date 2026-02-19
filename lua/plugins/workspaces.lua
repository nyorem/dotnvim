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
