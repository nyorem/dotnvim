return {
  {
    -- nested neovim sessions inside terminal
    "brianhuster/unnest.nvim"
  },
  {
    -- toggleable terminal window
    'akinsho/toggleterm.nvim',
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
        -- autochdir = true,
      }
      vim.keymap.set('n', '<Leader>to', ":ToggleTerm direction=vertical<CR>", { desc = "Open a terminal on the side" })
    end,
  }
}
