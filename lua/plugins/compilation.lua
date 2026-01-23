return
{
  {
    -- emacs compile mode
    -- use <C-r> to recompile
    "ej-shafran/compile-mode.nvim",
    enabled = true,
    config = function()
      vim.g.compile_mode = {
        bang_expansion = true, -- expand some special characters like '%'
        recompile_no_fail = true, -- Recompile will call Compile even if it was not called before
      }

      vim.keymap.set("n", "<Leader>r", ":botright vertical Compile ", { desc = "Run command" })
      vim.keymap.set("n", "<Leader>R", ":botright vertical Recompile", { desc = "Rerun last command" })
    end,
  },
}
