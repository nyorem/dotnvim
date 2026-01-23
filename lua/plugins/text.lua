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

      vim.keymap.set('n', '<Leader>yr', ":Telescope yank_history<CR>", { noremap = true, desc = "Yank Ring" })
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
    -- better f/F/t/T movements with indicators
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true,
        dim = true,
        disabled_filetypes = {
          "NeogitStatus",
        },
      })
    end,
  },
  {
    -- Markdown table manipulation:
    -- Go to next cell = '<TAB>'
    -- Go to previous cell = '<S-TAB>'
    -- Insert a row above the current row = '<A-k>'
    -- Insert a row below the current row = '<A-j>'
    -- Move the current row up = '<A-S-k>'
    -- Move the current row down = '<A-S-j>'
    -- Insert a column to the left of current column = '<A-h>'
    -- Insert a column to the right of current column = '<A-l>'
    -- Move the current column to the left = '<A-S-h>'
    -- Move the current column to the right = '<A-S-l>'
    -- Insert a new table = '<A-t>'
    -- Insert a new table that is not surrounded by pipes = '<A-S-t>'
    -- Delete the column under cursor = '<A-d>'
    "SCJangra/table-nvim",
    ft = "markdown",
    opts = {},
  },
  {
    "ywpkwon/yank-path.nvim",
    config = function()
      require("yank-path").setup()

      vim.keymap.set("n", "<Leader>yy", "<CMD>YankPath<CR>", { desc = "Yank full path of current file" })
    end,
  },
}
