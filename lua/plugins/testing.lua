return {
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
}
