return {
  {
    "stevearc/overseer.nvim",
    -- version = "v1.6.0",
    dependencies = {
      -- "franco-ruggeri/overseer-extra.nvim"
    },
    enabled = true,
    opts = {
      -- templates = {
      --   "user.configure_cmake",
      -- },
      -- templates = { "builtin", "extra" },
    },
    config = function()
      require("overseer").setup()

      vim.keymap.set("n", "<Space>cg", function() require("overseer").run_task({ name = "CMake configure" }) end, { noremap = true, desc = "Configure" })
      vim.keymap.set("n", "<Space>cc", function() require("overseer").run_task({ name = "Build target", strategy = { "toggleterm" } }) end, { noremap = true, desc = "Build" })
    end,
  },
}
