return {
  {
    -- nested neovim sessions inside terminal
    "brianhuster/unnest.nvim"
  },
  {
    -- toggleable terminal window
    'akinsho/toggleterm.nvim',
    enabled = true,
    config = function()
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
    end,
  },
}
