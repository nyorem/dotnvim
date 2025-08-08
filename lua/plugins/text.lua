return {
  {
    -- gl = align
    "tommcdo/vim-lion",
  },
  {
    -- yank ring
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup({
        ring = {
          permanent_wrapper = require("yanky.wrappers").remove_carriage_return,
        },
      })

      require("telescope").load_extension("yank_history")

      vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("n", "<m-p>", "<Plug>(YankyPreviousEntry)")
      vim.keymap.set("n", "<m-n>", "<Plug>(YankyNextEntry)")

      vim.keymap.set('n', '<Space>y', ":Telescope yank_history<CR>", { noremap = true, desc = "Yank Ring" })
    end
  },
  {
    -- incremental selection with <CR>
    "SUSTech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },
  {
    -- context aware indentation for code blocks in Markdown
    "wurli/contextindent.nvim",
    opts = { pattern = "*.md" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    }
  },
  {
    -- s = substitute
    -- cx = exchange
    "gbprod/substitute.nvim",
    config = function()
      vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
      vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
      vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
      vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })

      require("substitute").setup({
        on_substitute = require("yanky.integration").substitute(),
      })

      vim.keymap.set("n", "cx", require('substitute.exchange').operator, { noremap = true })
      vim.keymap.set("n", "cxx", require('substitute.exchange').line, { noremap = true })
      vim.keymap.set("x", "X", require('substitute.exchange').visual, { noremap = true })
      vim.keymap.set("n", "cxc", require('substitute.exchange').cancel, { noremap = true })
    end,
  },
  {
    -- better f/F/t/T movements with indicators
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true,
        dim = true,
      })
    end,
  },
}
