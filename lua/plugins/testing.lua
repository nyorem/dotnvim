return {
  "nyorem/ctest-telescope.nvim",
  dependencies = {
    "akinsho/toggleterm.nvim"
  },
  config = function()
    vim.keymap.set("n", "<Space>cg", function()
      if vim.bo.filetype == "cpp" or vim.bo.filetype == "c" or vim.bo.filetype == "oil" then
        require("ctest-telescope").run_test()
      end
    end, { desc = "Run unit test" })
  end,
}
