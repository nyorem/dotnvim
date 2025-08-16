return
{
  {
    -- emacs compile mode
    -- use <C-r> to recompile
    "ej-shafran/compile-mode.nvim",
    enabled = false,
    config = function()
      vim.g.compile_mode = {
        default_command = "cd $(git rev-parse --show-toplevel) && cmake --build build -j8",
        recompile_no_fail = true,
      }

      vim.keymap.set('n', '<Space>cc', ':tab Compile<CR>', { desc = "Compile the project" })
    end,
  },
  {
    "pohlrabi404/compile.nvim",
    event = "VeryLazy",
    opts = {
      term_win_opts = {
        split = "right",
        width = 0.5,
      },
      cmds = {
        default = "cd $(git rev-parse --show-toplevel) && cmake --build build -j8",
      }
    },
  }
}
