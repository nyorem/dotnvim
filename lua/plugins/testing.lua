return
{
  {
    -- ctest integration
    "nyorem/ctest-telescope.nvim",
    dependencies = {
      "akinsho/toggleterm.nvim"
    },
    config = function()
      require("ctest-telescope").setup({})

      vim.keymap.set("n", "<Leader>tr", function()
        if vim.bo.filetype == "cpp" or vim.bo.filetype == "c" or vim.bo.filetype == "oil" then
          require("ctest-telescope").run_test()
        end
      end, { desc = "Run test" })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- adapters below
      "orjangj/neotest-ctest",
    },
    keys = {
      { "<Leader>tt", "<cmd>Neotest run<cr>", desc = "Run test under cursor" },
      { "<Leader>ti", "<cmd>Neotest output<cr>", desc = "Test output" },
      { "<Leader>ts", "<cmd>Neotest summary<cr>", desc = "Test summary" },
      { "<Leader>ta", "<cmd>lua require('neotest').run.run({ suite = true })<cr>", desc = "Run all tests" },
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Convert newlines, tabs and whitespaces into a single whitespace
            -- for improved virtual text readability
            local message = diagnostic.message:gsub("[\r\n\t%s]+", " ")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup({
        adapters = {
          require("neotest-ctest").setup({
            is_test_file = function(file)
              local basename = vim.fs.basename(file)
              return string.match(basename, "Test.+cpp") ~= nil or string.match(basename, "test_.+cpp") ~= nil
            end,
          })
        }
      })
    end,
  }
}
