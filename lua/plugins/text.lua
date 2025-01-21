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
  {
    "SUSTech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },
  {
    "wurli/contextindent.nvim",
    opts = { pattern = "*.md" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    }
  },
}
