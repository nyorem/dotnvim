return {
  {
    "tommcdo/vim-lion",
  },
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup({})

      vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("n", "<m-p>", "<Plug>(YankyPreviousEntry)")
      vim.keymap.set("n", "<m-n>", "<Plug>(YankyNextEntry)")
    end
  },
}
