return
{
  {
    -- ctest integration
    "nyorem/ctest-telescope.nvim",
    enabled = false,
    dependencies = {
      "akinsho/toggleterm.nvim"
    },
    config = function()
      require("ctest-telescope").setup({
        dap_config = {
          stopAtEntry = true,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description =  'enable pretty printing',
              ignoreFailures = false
            },
          },
        }
      })

      vim.keymap.set("n", "<Space>cG", function()
        if vim.bo.filetype == "cpp" or vim.bo.filetype == "c" or vim.bo.filetype == "oil" then
          require("ctest-telescope").pick_test_and_debug()
        end
      end, { desc = "Debug unit test" })

      vim.keymap.set("n", "<Space>cg", function()
        if vim.bo.filetype == "cpp" or vim.bo.filetype == "c" or vim.bo.filetype == "oil" then
          require("ctest-telescope").run_test()
        end
      end, { desc = "Run unit test" })
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
      { "<Space>tt", "<cmd>Neotest run<cr>", desc = "Run test under cursor" },
      { "<Space>ti", "<cmd>Neotest output<cr>", desc = "Test output" },
      { "<Space>ts", "<cmd>Neotest summary<cr>", desc = "Summary" },
      { "<Space>ta", "<cmd>lua require('neotest').run.run({ suite = true })<cr>", desc = "Run all tests" },
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
              return string.match(file, "Test.+cpp") or string.match(file, "test_.+cpp")
            end,
          })
        }
      })
    end,
  }
}
